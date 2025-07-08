# 🛒 Seasonal Sales Analysis - Hard

## 📋 Énoncé du problème

**Contexte business** : Identifier les catégories de produits les plus populaires par saison pour éventuellement optimiser la stratégie d'inventaire et les campagnes marketing.

### Tables disponibles

#### Table `sales`
| Column Name | Type    | Description |
|-------------|---------|-------------|
| sale_id     | int     | Identifiant unique de la vente |
| product_id  | int     | Référence au produit |
| sale_date   | date    | Date de la vente |
| quantity    | int     | Quantité vendue |
| price       | decimal | Prix unitaire |

#### Table `products`
| Column Name  | Type    | Description |
|--------------|---------|-------------|
| product_id   | int     | Identifiant unique du produit |
| product_name | varchar | Nom du produit |
| category     | varchar | Catégorie du produit |

## 🎯 Objectif

Identifier la **catégorie la plus populaire** pour chaque saison.

### Définition des saisons :
- **Hiver** : Décembre, Janvier, Février
- **Printemps** : Mars, Avril, Mai  
- **Été** : Juin, Juillet, Août
- **Automne** : Septembre, Octobre, Novembre

### Critères de popularité :
1. **Priorité 1** : Quantité totale vendue par saison
2. **Priorité 2** : En cas d'égalité, chiffre d'affaires total (quantité × prix)

### Format de sortie :
- Une ligne par saison avec la catégorie gagnante
- Triés par saison alphabétique

## 📊 Exemple

### Données d'entrée

**sales:**
| sale_id | product_id | sale_date  | quantity | price |
|---------|------------|------------|----------|-------|
| 1       | 1          | 2023-01-15 | 5        | 10.00 |
| 2       | 2          | 2023-01-20 | 4        | 15.00 |
| 3       | 3          | 2023-03-10 | 3        | 18.00 |
| 4       | 4          | 2023-04-05 | 1        | 20.00 |
| 5       | 1          | 2023-05-20 | 2        | 10.00 |
| 6       | 2          | 2023-06-12 | 4        | 15.00 |
| 7       | 5          | 2023-06-15 | 5        | 12.00 |
| 8       | 3          | 2023-07-24 | 2        | 18.00 |
| 9       | 4          | 2023-08-01 | 5        | 20.00 |
| 10      | 5          | 2023-09-03 | 3        | 12.00 |
| 11      | 1          | 2023-09-25 | 6        | 10.00 |
| 12      | 2          | 2023-11-10 | 4        | 15.00 |
| 13      | 3          | 2023-12-05 | 6        | 18.00 |
| 14      | 4          | 2023-12-22 | 3        | 20.00 |
| 15      | 5          | 2024-02-14 | 2        | 12.00 |

**products:**
| product_id | product_name    | category |
|------------|-----------------|----------|
| 1          | Warm Jacket     | Apparel  |
| 2          | Designer Jeans  | Apparel  |
| 3          | Cutting Board   | Kitchen  |
| 4          | Smart Speaker   | Tech     |
| 5          | Yoga Mat        | Fitness  |

### Résultat attendu

| season | category | total_quantity | total_revenue |
|--------|----------|----------------|---------------|
| Fall   | Apparel  | 10             | 120.00        |
| Spring | Kitchen  | 3              | 54.00         |
| Summer | Tech     | 5              | 100.00        |
| Winter | Apparel  | 9              | 110.00        |

## 🔍 Analyse business

### Insights attendus :
- **Saisonnalité des ventes** par catégorie
- **Optimisation de l'inventaire** selon les saisons
- **Stratégies marketing** adaptées aux tendances saisonnières
- **Prévisions de demande** pour la planification

### Applications métier :
- **Gestion des stocks** : Anticiper les besoins par saison
- **Campagnes marketing** : Cibler les bonnes catégories au bon moment
- **Négociation fournisseurs** : Optimiser les achats selon la demande
- **Analyse de performance** : Identifier les catégories rentables

## 💡 Compétences démontrées

- **Fonctions de dates** avancées (EXTRACT)
- **Agrégations complexes** avec GROUP BY multiples
- **Window Functions** pour le ranking
- **Logique conditionnelle** avec CASE WHEN

## 🎯 Niveau de difficulté : Hard

Cette requête nécessite une expertise en :
- **Transformation de données temporelles** complexes
- **Logique de ranking** avec critères multiples
- **Optimisation des performances** sur agrégations lourdes

## 🚀 Extensions possibles

- **Analyse multi-années** avec comparaisons YoY
- **Segmentation géographique** par région/pays
- **Prévisions ML** basées sur les tendances historiques