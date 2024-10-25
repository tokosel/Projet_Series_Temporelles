# Projet de Séries Temporelles - Prévisions du Nombre de Cas Positifs Covid-19 au Sénégal

## Contexte
Ce projet a pour objectif de modéliser et de prévoir le nombre de cas positifs confirmés de Covid-19 au Sénégal. Les données utilisées proviennent de la base de données intitulée **"base_covid19"**, dans laquelle les cas sont enregistrés sur une base journalière.

Les principales tâches de ce projet consistent à :
1. Étudier la tendance des cas positifs à travers une décomposition de la série temporelle.
2. Modéliser la série en utilisant la méthodologie de Box & Jenkins (ARIMA).
3. Effectuer des prévisions à court terme (30 jours) à l'aide des modèles ARIMA et ETS (Lissage Exponentiel), et comparer les résultats.

## Objectifs du projet
- Analyser la tendance des cas positifs de Covid-19 au Sénégal à travers des méthodes de séries temporelles.
- Prévoir le nombre de cas pour les mois à venir à l'aide des modèles ARIMA et ETS.
- Comparer les performances des modèles à travers des prévisions graphiques et des métriques de précision.

## Travail à réaliser
1. **Décomposition de la série temporelle :**
   - Décomposer la série temporelle **"CasPositif"** pour identifier les composantes principales : tendance, saisonnalité et résidus.
   - Ajuster la tendance à l'aide d'une **moyenne mobile** et d'un **modèle linéaire**.

2. **Modélisation Box & Jenkins :**
   - Modéliser la série temporelle en utilisant un modèle ARIMA. 
   - Interpréter les sorties du modèle (ACF, PACF, paramètres du modèle).

3. **Prévision ARIMA :**
   - Effectuer une prévision des cas positifs pour une période de 30 jours à l'aide du modèle ARIMA.
   - Visualiser ces prévisions avec leurs **intervalles de confiance** dans deux graphiques séparés.
   - Analyser les résultats.

4. **Prévision ETS (Lissage Exponentiel) :**
   - Prévoir également les cas sur une période de 30 jours à l'aide d'un modèle **ETS**.
   - Comparer graphiquement les résultats des prévisions ARIMA et ETS.

## Données
Les données utilisées dans ce projet sont fournies dans le fichier **base_covid19.csv** et contiennent :
- **Date** : La date de l'enregistrement.
- **CasPositif** : Le nombre quotidien de cas positifs confirmés de Covid-19 au Sénégal.

## Méthodes utilisées
- **Décomposition STL** : Séparation de la série en tendance, saisonnalité et résidus.
- **Moyenne mobile** : Calcul de la tendance lissée à l'aide d'une moyenne mobile sur 7 jours.
- **Modélisation ARIMA** : Modèle autoregressif intégré à moyenne mobile, avec identification des paramètres grâce aux fonctions ACF et PACF.
- **Modélisation ETS** : Lissage exponentiel prenant en compte l'erreur, la tendance et la saisonnalité.
- **Prévisions à court terme** : Prédiction des cas futurs sur une période de 30 jours avec ARIMA et ETS.

## Utilisation du projet
1. Cloner ce dépôt sur votre machine locale :
   ```bash
   git clone https://github.com/tokosel/Projet_Series_Temporelles.git


## Licence
Ce projet est sous licence MIT.

## Auteur
**Abdoulaye SALL**  
M1 - SID 2023-2024

