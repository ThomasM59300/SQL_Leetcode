-- Étape 1 : Sélection des employés ayant au moins 3 évaluations
WITH employes_eligibles AS (
    SELECT employee_id
    FROM performance_reviews 
    GROUP BY employee_id
    HAVING COUNT(*) >= 3
),

-- Étape 2 : Numérotation des 3 dernières évaluations pour ces employés
dernieres_evaluations AS (
    SELECT * 
    FROM (
        SELECT 
            *, 
            ROW_NUMBER() OVER (
                PARTITION BY employee_id 
                ORDER BY review_date DESC
            ) AS rown
        FROM performance_reviews
    )
    WHERE employee_id IN (SELECT employee_id FROM employes_eligibles) 
      AND rown <= 3
),

-- Étape 3 : Reconstitution des triplets d’évaluations consécutives par employé
triplets AS (
    SELECT 
        a.employee_id,
        a.rating AS x,  -- évaluation la plus ancienne des trois, correspond à rown = 3
        b.rating AS y,
        c.rating AS z   -- évaluation la plus récente, correspond à rown = 1
    FROM dernieres_evaluations AS a 
    JOIN dernieres_evaluations AS b 
        ON b.rown = a.rown - 1 AND a.employee_id = b.employee_id
    JOIN dernieres_evaluations AS c 
        ON c.rown = a.rown - 2 AND a.employee_id = c.employee_id
)

-- Étape 4 : Calcul de l'amélioration et sélection des cas d'amélioration continue
SELECT 
    j.employee_id,
    e.name,
    z - x AS improvement_score
FROM triplets AS j 
JOIN employees AS e
    ON j.employee_id = e.employee_id
WHERE y > x AND z > y  -- amélioration continue sur 3 évaluations consécutives
ORDER BY 
    improvement_score DESC, 
    name ASC;

-- ====================================================================
-- OPTIMISATIONS DE PERFORMANCE APPLIQUÉES (CONFORMÉMENT À LA REQUÊTE) :
-- ====================================================================
-- 1. Filtrage initial des employés avec au moins 3 évaluations :
--    - Réduit le nombre de lignes à traiter en aval.
-- 2. Utilisation de ROW_NUMBER() pour identifier les 3 évaluations les plus récentes :
--    - Permet une reconstitution fiable de l'historique récent par employé.
-- 3. Comparaison de notes à l’aide de jointures par rang :
--    - Évite les opérations coûteuses sur des fenêtres glissantes.
-- 4. Calcul direct de l'amélioration (z - x) dans la sélection finale :
--    - Moins d’étapes de calcul intermédiaire nécessaires.
-- 5. Clause WHERE filtrant uniquement les progressions strictement croissantes :
--    - Précision métier intégrée dans la requête, sans traitement postérieur.
