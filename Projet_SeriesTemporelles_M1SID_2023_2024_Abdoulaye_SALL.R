# Installation des packages nécessaires
install.packages("forecast")
install.packages("tseries")

# Chargement des bibliothèques
library(forecast)
library(tseries)

# Étape 1 : Importation et visualisation des données
data <- read.csv("C:/Users/hp/Desktop/Master SID/Series temporelles/projet/base_covid19.csv", header=TRUE, sep=";")
data$date <- as.Date(data$date, format="%d/%m/%Y")


# Visualisation des cas positifs
plot(data$date, data$CasPositif, type="l", col="blue", xlab="Date", ylab="Nombre de cas positifs", main="Évolution des cas positifs")

# Etape 1 : Décomposition

# Décomposition de la série temporelle avec STL avec une saisonnalité hebdomadaire (fréquence = 7)
serie_ts <- ts(data$CasPositif, frequency=7, start=c(2020, 3))

# Utilisation de STL pour décomposer la série
decompo_stl <- stl(serie_ts, s.window="periodic")

# Visualisation des composantes
plot(decompo_stl)


# Ajustement de la tendance avec une moyenne mobile
# On choisit une fenêtre de 7 jours (hebdomadaire)
window_size <- 7

# Calcul de la moyenne mobile
moving_avg <- filter(data$CasPositif, rep(1/window_size, window_size), sides=2)

# Visualisation de la moyenne mobile par rapport aux données originales
plot(data$date, data$CasPositif, type="l", col="blue", xlab="Date", ylab="Nombre de cas positifs", main="Cas Positifs avec Moyenne Mobile")
lines(data$date, moving_avg, col="red", lwd=2)

# Ajout de la légende pour indiquer les courbes
legend("topright", legend=c("Données originales", "Moyenne mobile"), col=c("blue", "red"), lty=1, lwd=2)

# Etape 2 : Modélisation

# Vérification de la stationnarité avec le test de Dickey-Fuller augmenté (ADF)
adf_test <- adf.test(serie_ts)
print(adf_test)

# Différenciation pour rendre la série stationnaire
diff_serie <- diff(serie_ts)

# Vérification de la stationnarité de la série différenciée
adf_test_diff <- adf.test(diff_serie)
print(adf_test_diff)

# Visualisation de la série différenciée
plot(diff_serie, main="Série des cas positifs différenciée", col="blue")

# Affichage des ACF et PACF pour identifier p et q
acf(diff_serie, main="ACF de la série différenciée")
pacf(diff_serie, main="PACF de la série différenciée")

# Ajustement d'un modèle ARIMA (p, d, q)
model_arima <- arima(serie_ts, order=c(1, 1, 1))

# Résumé du modèle
summary(model_arima)

# Résidus du modèle ARIMA
residuals <- residuals(model_arima)

# Diagnostic des résidus
acf(residuals, main="ACF des résidus")
Box.test(residuals, lag=20, type="Ljung-Box")  # Test de Ljung-Box pour l'indépendance des résidus


# Prévisions avec le modèle ARIMA
forecast_arima <- forecast(model_arima, h=30)  # Prévisions sur les 30 prochains jours
plot(forecast_arima, main="Prévisions des cas positifs avec ARIMA")
