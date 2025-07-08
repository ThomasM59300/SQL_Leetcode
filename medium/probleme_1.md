# 🏥 COVID Recovery Analysis - Medium

## 📋 Énoncé du problème

**Contexte business** : Analyser les données de récupération COVID pour identifier les patients guéris et calculer leur temps de rétablissement.

### Tables disponibles

#### Table `patients`
| Column Name  | Type    | Description |
|-------------|---------|-------------|
| patient_id  | int     | Identifiant unique du patient |
| patient_name| varchar | Nom du patient |
| age         | int     | Âge du patient |

#### Table `covid_tests`
| Column Name | Type    | Description |
|-------------|---------|-------------|
| test_id     | int     | Identifiant unique du test |
| patient_id  | int     | Référence au patient |
| test_date   | date    | Date du test |
| result      | varchar | Résultat : 'Positive', 'Negative', 'Inconclusive' |

## 🎯 Objectif

Identifier les patients **guéris** du COVID et calculer leur temps de récupération.

### Critères de guérison :
1. **Au moins un test positif** suivi d'**au moins un test négatif** à une date ultérieure
2. **Temps de récupération** = différence entre le premier test positif et le premier test négatif suivant
3. Exclure les patients sans tests positifs ET négatifs

### Format de sortie :
- Triés par `recovery_time` croissant
- En cas d'égalité, triés par `patient_name` alphabétique

## 📊 Exemple

### Données d'entrée

**patients:**
| patient_id | patient_name | age |
|------------|--------------|-----|
| 1          | Alice Smith  | 28  |
| 2          | Bob Johnson  | 35  |
| 3          | Carol Davis  | 42  |
| 4          | David Wilson | 31  |
| 5          | Emma Brown   | 29  |

**covid_tests:**
| test_id | patient_id | test_date  | result       |
|---------|------------|------------|--------------|
| 1       | 1          | 2023-01-15 | Positive     |
| 2       | 1          | 2023-01-25 | Negative     |
| 3       | 2          | 2023-02-01 | Positive     |
| 4       | 2          | 2023-02-05 | Inconclusive |
| 5       | 2          | 2023-02-12 | Negative     |
| 6       | 3          | 2023-01-20 | Negative     |
| 7       | 3          | 2023-02-10 | Positive     |
| 8       | 3          | 2023-02-20 | Negative     |
| 9       | 4          | 2023-01-10 | Positive     |
| 10      | 4          | 2023-01-18 | Positive     |
| 11      | 5          | 2023-02-15 | Negative     |
| 12      | 5          | 2023-02-20 | Negative     |

### Résultat attendu

| patient_id | patient_name | age | recovery_time |
|------------|--------------|-----|---------------|
| 1          | Alice Smith  | 28  | 10            |
| 3          | Carol Davis  | 42  | 10            |
| 2          | Bob Johnson  | 35  | 11            |

## 🔍 Analyse business

### Insights attendus :
- **Temps de récupération moyen** par groupe d'âge
- **Taux de guérison** par patient
- **Tendances temporelles** des guérisons

### Applications métier :
- **Suivi épidémiologique** des patients
- **Planification des ressources** hospitalières
- **Analyse de l'efficacité** des traitements

## 💡 Compétences démontrées

- **Window Functions** pour identifier les premiers tests
- **CTEs complexes** pour structurer la logique
- **Jointures multiples** avec conditions temporelles
- **Agrégations** pour calculer les métriques
- **Gestion des dates** et calculs temporels

## 🎯 Niveau de difficulté : Medium

Cette requête nécessite une compréhension approfondie des :
- **Fonctions analytiques** (ROW_NUMBER, RANK)
- **Logique conditionnelle** complexe
- **Optimisation** des jointures temporelles