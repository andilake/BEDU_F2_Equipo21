# Postwork sesión 7

#### Desarrollo
# Utilizando el siguiente vector numérico, realiza lo que se indica:
  
url = "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-07/Data/global.txt"

Global <- scan(url, sep="")
head(Global)
class(Global)

# Crea un objeto de serie de tiempo con los datos de Global. La serie debe ser
# mensual comenzando en Enero de 1856. Realiza una gráfica de la serie de tiempo
# anterior.

Global.ts <- ts(Global, start = c(1856,1), freq = 12)

plot(Global.ts, main = "Temperatura Global", xlab = "Tiempo",
     sub = "Enero de 1856 - Diciembre de 2005", xaxt = "n") +
  axis(1, at = seq(1856, 2006, by = 10), las=2)


# Ahora realiza una gráfica de la serie de tiempo anterior, transformando a la
# primera diferencia.


plot(diff(Global.ts), type = "l", main = "Primera diferencia de Temperatura Global", 
     xlab = "Tiempo", ylab = "Diferencia", xaxt = "n") +
  axis(1, at = seq(1856, 2006, by = 10), las=2)


# ¿Consideras que la serie es estacionaria en niveles o en primera diferencia?

# Es estacionaria en primera diferencia.

# Con base en tu respuesta anterior, obtén las funciones de autocorrelación y
# autocorrelación parcial?

acf(diff(Global.ts))
pacf(diff(Global.ts))

# De acuerdo con lo observado en las gráficas anteriores, se sugiere un modelo
# ARIMA con AR(1), I(1) y MA desde 1 a 4 rezagos. Estima los diferentes modelos
# ARIMA propuestos:"

arima(Global.ts, order = c(1, 1, 1))
arima(Global.ts, order = c(1, 1, 2))
arima(Global.ts, order = c(1, 1, 3))
arima(Global.ts, order = c(1, 1, 4))

# El mejor modelo es arima(Global.ts, order = c(1, 1, 4))

# Con base en el criterio de Akaike, estima el mejor modelo ARIMA y realiza una 
# predicción de 12 periodos (meses)

fit <- arima(Global.ts, order = c(1, 1, 4))
pr <- predict(fit, 12)$pred 

pr

ts.plot(cbind(window(Global.ts, start = 2000), pr), col = c("blue", "red"), xlab = "") +
title(main = "Predicción de temperatura global",
      xlab = "Mes",
      ylab = "Temperatura global")

