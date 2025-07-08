# 📊 Employee Performance Tracking - Medium

## 📋 Énoncé du problème

**Contexte business** : Identifier les employés qui montrent une amélioration constante de leurs performances pour les programmes de développement des talents.

### Tables disponibles

#### Table `employees`
| Column Name | Type    | Description |
|-------------|---------|-------------|
| employee_id | int     | Identifiant unique de l'employé |
| name        | varchar | Nom de l'employé |

#### Table `performance_reviews`
| Column Name | Type | Description |
|-------------|------|-------------|
| review_id   | int  | Identifiant unique de l'évaluation |
| employee_id | int  | Référence à l'employé |
| review_date | date | Date de l'évaluation |
| rating      | int  | Note de 1 à 5 (5 = excellent, 1 = insuffisant) |

## 🎯 Objectif

Identifier les employés avec une **amélioration constante** sur leurs 3 dernières évaluations.

### Critères d'amélioration :
1. **Minimum 3 évaluations** dans l'historique
2. **3 dernières évaluations** avec notes **strictement croissantes**
3. **Score d'amélioration** = différence entre la note la plus récente et la plus ancienne des 3 dernières

### Format de sortie :
- Triés par `improvement_score` décroissant
- En cas d'égalité, triés par `name` alphabétique

## 📊 Exemple

### Données d'entrée

**employees:**
| employee_id | name           |
|-------------|----------------|
| 1           | Alice Johnson  |
| 2           | Bob Smith      |
| 3           | Carol Davis    |
| 4           | David Wilson   |
| 5           | Emma Brown     |

**performance_reviews:**
| review_id | employee_id | review_date | rating |
|-----------|-------------|-------------|--------|
| 1         | 1           | 2023-01-15  | 2      |
| 2         | 1           | 2023-04-15  | 3      |
| 3         | 1           | 2023-07-15  | 4      |
| 4         | 1           | 2023-10-15  | 5      |
| 5         | 2           | 2023-02-01  | 3      |
| 6         | 2           | 2023-05-01  | 2      |
| 7         | 2           | 2023-08-01  | 4      |
| 8         | 2           | 2023-11-01  | 5      |
| 9         | 3           | 2023-03-10  | 1      |
| 10        | 3           | 2023-06-10  | 2      |
| 11        | 3           | 2023-09-10  | 3      |
| 12        | 3           | 2023-12-10  | 4      |
| 13        | 4           | 2023-01-20  | 4      |
| 14        | 4           | 2023-04-20  | 4      |
| 15        | 4           | 2023-07-20  | 4      |
| 16        | 5           | 2023-02-15  | 3      |
| 17        | 5           | 2023-05-15  | 2      |

### Résultat attendu

| employee_id | name           | improvement_score |
|-------------|----------------|-------------------|
| 2           | Bob Smith      | 3                 |
| 1           | Alice Johnson  | 2                 |
| 3           | Carol Davis    | 2                 |

## 🔍 Analyse business

### Insights attendus :
- **Identification des high performers** en progression
- **Tendances d'amélioration** par équipe/département
- **Corrélation** entre formation et performance (si on disposait des données)

### Applications métier :
- **Programmes de développement** des talents
- **Planification des promotions** et augmentations
- **Identification des mentors** potentiels
- **Stratégies de rétention** des employés performants

## 💡 Compétences démontrées

- **Window Functions** avancées (ROW_NUMBER, RANK)
- **CTEs** pour logique complexe
- **Jointures multiples** avec conditions
- **Logique conditionnelle** pour validation des critères

## 🎯 Niveau de difficulté : Medium

Cette requête nécessite une maîtrise de :
- **Fonctions de fenêtrage** pour le classement temporel
- **Logique séquentielle** pour valider les tendances
- **Optimisation** des performances sur de gros volumes