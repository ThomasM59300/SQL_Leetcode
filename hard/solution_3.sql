-- Étape 1 : Ajoute la saison à chaque vente et calcule le revenu total
WITH ventes_saisonnalisees AS (
    SELECT 
        sale_id,
        s.product_id,
        sale_date,
        quantity,
        price,
        price * quantity AS total_revenue,
        category,
        CASE 
            WHEN EXTRACT(MONTH FROM sale_date) IN (12, 1, 2) THEN 'Winter' 
            WHEN EXTRACT(MONTH FROM sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM sale_date) IN (9, 10, 11) THEN 'Fall' 
        END AS saison
    FROM sales AS s
    JOIN products AS p 
        ON p.product_id = s.product_id
),

-- Étape 2 : Agrège les ventes par catégorie et saison
agregats_saisonniers AS (
    SELECT 
        category,
        saison,
        SUM(quantity) AS total_quantity, 
        SUM(price * quantity) AS total_revenue
    FROM ventes_saisonnalisees 
    GROUP BY saison, category
),

-- Étape 3 : Classement des catégories par saison selon quantité (et revenu en second critère)
classement AS (
    SELECT 
        saison AS season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY saison 
            ORDER BY total_quantity DESC, total_revenue DESC
        ) AS rang_cat
    FROM agregats_saisonniers
)

-- Étape 4 : Récupère la catégorie top 1 pour chaque saison
SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM classement
WHERE rang_cat = 1;

-- ====================================================================
-- OPTIMISATIONS DE PERFORMANCE APPLIQUÉES (CONFORMÉMENT À LA REQUÊTE) :
-- ====================================================================
-- 1. Calcul direct de la saison via EXTRACT + CASE :
--    - Permet un regroupement saisonnier sans table de correspondance externe.
-- 2. Utilisation d’un JOIN sur produits pour accéder à la catégorie :
--    - Centralisation des métadonnées produit.
-- 3. Agrégation des ventes avant tout tri :
--    - Réduction du volume traité lors du classement par ROW_NUMBER().
-- 4. Tri hiérarchisé : quantité descendante, puis revenu total :
--    - Garantit la sélection de la meilleure catégorie par saison.
-- 5. Utilisation de ROW_NUMBER() pour un classement optimisé :
--    - Plus efficace que des sous-requêtes imbriquées avec MAX().
