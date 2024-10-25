# Projet Series Temporelles M1-SID 2023-2024 UADB
# Abdoulaye SALL Code étudiant 1819037

# Import des packages nécessaires pour l'analyse de séries temporelles
library(forecast)
library(ggplot2)
library(tseries)
library(tidyr)

# 1. IMPORT ET PRÉPARATION DES DONNÉES
data <- read.csv("base_covid19.csv", header=TRUE, sep=";")
# Création de la série temporelle avec fréquence hebdomadaire
cas_ts <- ts(data$CasPositif, frequency=7)


# 2. DÉCOMPOSITION ET ANALYSE DE LA TENDANCE
# Décomposition de la série en composantes (tendance, saisonnalité, résidus)
decomposition <- stl(cas_ts, s.window="periodic")
plot(decomposition)

# Calcul de la moyenne mobile sur 7 jours pour lisser les fluctuations
mm_7 <- ma(cas_ts, order=7)

# Visualisation de la série avec sa moyenne mobile
plot(cas_ts, main="Cas Positifs avec Moyenne Mobile", 
     ylab="Nombre de cas", xlab="Temps")
lines(mm_7, col="red", lwd=2)
legend("topleft", legend=c("Données brutes", "Moyenne mobile"), 
       col=c("black", "red"), lty=1)

# Ajustement d'un modèle linéaire pour la tendance
temps <- 1:length(cas_ts)
modele_lineaire <- lm(as.vector(cas_ts) ~ temps)
summary(modele_lineaire)
# Ajout de la tendance linéaire au graphique précédent
lines(temps, predict(modele_lineaire), col="blue", lwd=2)

# 3. MODÉLISATION BOX-JENKINS

# Test de stationnarité sur la série originale
adf_test <- adf.test(cas_ts)
print("Test ADF sur série originale :")
print(adf_test)  # Si p-value > 0.05, série non stationnaire

# Différenciation et nouveau test de stationnarité
cas_diff <- diff(cas_ts)
adf_test_diff <- adf.test(cas_diff)
print("Test ADF sur série différenciée :")
print(adf_test_diff)  # Si p-value < 0.05, série stationnaire

# Analyse des fonctions d'autocorrélation sur la série stationnaire
par(mfrow=c(2,1))
par(mar=c(4,4,2,2))
acf(cas_diff, main="ACF des différences premières")
pacf(cas_diff, main="PACF des différences premières")


# Modélisation ARIMA sur la série différenciée (stationnaire)
modele_auto <- auto.arima(cas_diff, seasonal=TRUE)
summary(modele_auto)

# 4. PRÉVISIONS ARIMA

# Prévisions sur 30 jours
prev_arima <- forecast(modele_auto, h=30)

# 4.2 Visualisation des prévisions ARIMA
plot(prev_arima, main="Prévisions ARIMA sur 30 jours",
     xlab="Temps", ylab="Nombre de cas positifs")


# 5. PRÉVISION PAR LISSAGE EXPONENTIEL ETS (Error, Trend, Seasonality)

# Modèle de lissage exponentiel
modele_ets <- ets(cas_ts)
prev_ets <- forecast(modele_ets, h=30)

# Création du dataframe pour la comparaison des deux méthodes
df_comparaison <- data.frame(
  Date = 1:30,
  ARIMA = as.numeric(prev_arima$mean),  # Utilisation des prévisions dé-différenciées
  ETS = as.numeric(prev_ets$mean)
)

# Conversion en format long pour ggplot
df_long <- pivot_longer(df_comparaison, 
                        cols = c("ARIMA", "ETS"),
                        names_to = "Methode", 
                        values_to = "Prevision")

# Visualisation comparative des deux méthodes
ggplot(df_long, aes(x = Date, y = Prevision, color = Methode)) +
  geom_line() +
  labs(title = "Comparaison des prévisions ARIMA et ETS",
       x = "Jours de prévision",
       y = "Nombre de cas positifs") +
  theme_minimal()

# Évaluation de la précision des modèles
print("Précision du modèle ARIMA :")
accuracy(prev_arima)
print("Précision du modèle ETS :")
accuracy(prev_ets)
