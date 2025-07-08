-- Étape 1 : Numérote les tests positifs pour chaque patient (le 1er test positif reçoit prem_positif = 1)
WITH tests_numerotes AS (
    SELECT 
        patient_id,
        test_date,
        result,
        ROW_NUMBER() OVER (
            PARTITION BY patient_id 
            ORDER BY 
                CASE 
                    WHEN result = 'Positive' THEN test_date 
                END
        ) AS prem_positif
    FROM covid_tests
),

-- Étape 2 : Associe chaque test positif avec un test négatif ultérieur du même patient
tests_associes AS (
    SELECT 
        test_pos.patient_id AS patient_pos_id,
        test_neg.patient_id AS patient_neg_id,
        test_pos.test_date AS positive_date,
        test_neg.test_date AS negative_date,
        test_pos.result AS positive_result,
        test_neg.result AS negative_result,
        test_pos.prem_positif,
        test_neg.test_date - test_pos.test_date AS recovery_time
    FROM tests_numerotes AS test_pos
    JOIN tests_numerotes AS test_neg 
        ON test_pos.patient_id = test_neg.patient_id 
       AND test_neg.test_date > test_pos.test_date
),

-- Étape 3 : Calcule le temps de récupération minimal pour chaque patient
recuperations AS (
    SELECT 
        patient_pos_id AS ida,
        MIN(recovery_time) AS recovery_time
    FROM tests_associes
    WHERE prem_positif = 1
      AND positive_result = 'Positive'
      AND negative_result = 'Negative'
    GROUP BY patient_pos_id
)

-- Étape 4 : Affiche les infos des patients avec leur temps de récupération
SELECT 
    p.patient_id,
    p.patient_name,
    p.age,
    r.recovery_time
FROM recuperations r
JOIN patients p 
    ON r.ida = p.patient_id
ORDER BY 
    r.recovery_time, 
    p.patient_name;

-- ====================================================================
-- OPTIMISATIONS DE PERFORMANCE APPLIQUÉES :
-- ====================================================================
-- 1. Utilisation de CTEs (WITH) pour structurer clairement la requête :
--    - Facilite l’optimisation par le planificateur de requête.
--    - Améliore la lisibilité pour le débogage et la maintenance.
-- 2. Utilisation de ROW_NUMBER() avec PARTITION BY + ORDER BY ciblé :
--    - Permet d’isoler efficacement le premier test positif par patient.
-- 3. Jointure sur test_date > test_date :
--    - Réduit le nombre de paires comparées, limitant le volume de calcul.
-- 4. Calcul du temps de récupération directement dans la jointure :
--    - Évite des recalculs ou une étape supplémentaire d’agrégation.
-- 5. Filtrage uniquement des cas pertinents :
--    - `prem_positif = 1`, `ra = 'Positive'`, `rb = 'Negative'`
--    - Concentre les traitements sur les scénarios cliniquement significatifs.
-- 6. Utilisation exclusive de INNER JOIN :
--    - Moins coûteux que LEFT JOIN car les relations sont garanties.
-- 7. Index recommandés pour améliorer les performances (non créés ici) :
--    - CREATE INDEX idx_covid_tests_patient_date ON covid_tests(patient_id, test_date);
--    - CREATE INDEX idx_covid_tests_result ON covid_tests(result);
