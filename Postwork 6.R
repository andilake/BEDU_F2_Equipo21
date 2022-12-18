# Postwork Sesión 6

#### Desarrollo

# Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre
# como mejorar las ventas de un producto particular, y el conjunto de datos
# con el que disponemos son datos de publicidad que consisten en las ventas
# de aquel producto en 200 diferentes mercados, junto con presupuestos de
# publicidad para el producto en cada uno de aquellos mercados para tres
# medios de comunicación diferentes: TV, radio, y periódico. No es posible
# para nuestro cliente incrementar directamente las ventas del producto. Por
# otro lado, ellos pueden controlar el gasto en publicidad para cada uno de
# los tres medios de comunicación. Por lo tanto, si determinamos que hay una
# asociación entre publicidad y ventas, entonces podemos instruir a nuestro
# cliente para que ajuste los presupuestos de publicidad, y así
# indirectamente incrementar las ventas.

# En otras palabras, nuestro objetivo es desarrollar un modelo preciso que
# pueda ser usado para predecir las ventas sobre la base de los tres 
# presupuestos de medios de comunicación. Ajuste modelos de regresión lineal 
# múltiple a los datos advertisement.csv y elija el modelo más adecuado 
# siguiendo los procedimientos vistos

# Considera:
  
# Y: Sales (Ventas de un producto)
# X1: TV (Presupuesto de publicidad en TV para el producto)
# X2: Radio (Presupuesto de publicidad en Radio para el producto)
# X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)

library(dplyr)
library(ggplot2)

adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")
str(adv)
cor(adv)

pairs(~ Sales + TV + Radio + Newspaper, data = adv, gap = 0.4, cex.labels = 1.5)

"Estimación por Mínimos Cuadrados Ordinarios (OLS)
Y = beta0 + beta1*TV + beta2*Radio + beta3*Newspaper + e"

attach(adv)
m1 <- lm(Sales ~ TV + Radio + Newspaper)
summary(m1)

"De los resultados anteriores, podemos concluir que el coeficiente de la variable 
Newspaper no es significativo. Probemos nuestro modelo sin incluir dicha variable:
Y = beta0 + beta1*TV + beta2*Radio + e"

m2 <- update(m1, ~.- Newspaper)
summary(m2)

StanRes2 <- rstandard(m2)

par(mfrow = c(2, 2))

plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")

qqnorm(StanRes2)
qqline(StanRes2)

dev.off()

# Eltérmino de error no tiene correlación significativa con las variables 
# por lo que no se tiene un problema de endogeneidad.

# Ho: La variable distribuye como una normal
# Ha: La variable no distribuye como una normal

shapiro.test(StanRes2)

# Se rechaza que el el error distrubuye como normal.

# Quitamos Radio de nuestro modelo y volvemos a pobar.

m3 <- update(m2, ~.- Radio)
summary(m3)

StanRes3 <- rstandard(m3)

par(mfrow = c(2, 2))

plot(TV, StanRes3, ylab = "Residuales Estandarizados")

qqnorm(StanRes3)
qqline(StanRes3)

dev.off()

shapiro.test(StanRes3)

# Esta vez no se rechaza que el error se distribuya como normal.


data <- data.frame(
  TV = c(25, 50, 75, 100, 125, 150)
)

predict(m3, newdata = data, interval = "confidence", level = 0.95)

modelo <- lm(Sales ~ TV)

TV.values <- data.frame(TV = sort(c(25, 50, 75, 100, 125, 150), decreasing = FALSE))
pred <- predict(modelo, newdata = TV.values, interval = "confidence", level = 0.95)

plot(TV, Sales, xlab = "TV", 
     ylab = "Sales", pch = 16)
points(TV.values$TV, pred[,1], xlab = "TV", 
       ylab = "Sales", pch = 16, col = "red")
abline(lsfit(TV, Sales))

plot(TV.values$TV, pred[,1], xlab = "TV", 
     ylab = "Sales", pch = 16, col = "red")
abline(lsfit(TV.values$TV, pred[,1]))

lines(TV.values$TV, pred[, 2], lty = 2, lwd = 2, col = "blue")
lines(TV.values$TV, pred[, 3], lty = 2, lwd = 2, col = "blue")
