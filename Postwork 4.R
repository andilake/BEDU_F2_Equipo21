# Postwork Sesión 4

#### Objetivo

# - Realizar un análisis probabilístico del total de cargos internacionales de
# una compañía de telecomunicaciones

#### Requisitos

# R, RStudio
# Haber trabajado con el prework y el work

#### Desarrollo

# Utilizando la variable total_intl_charge de la base de datos telecom_service.csv
# de la sesión 3, realiza un análisis probabilístico. Para ello, debes determinar
# la función de distribución de probabilidad que más se acerque el comportamiento
# de los datos. Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización

library(DescTools)
library(ggplot2)

df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
str(df)
summary(df$total_intl_charge)

Mode(df$total_intl_charge)
mean(df$total_intl_charge)
median(df$total_intl_charge)

hist(df$total_intl_charge, main="Histograma de cargos internacionales")

# Los datos siguen una distribución normal.


# Una vez que hayas seleccionado el modelo, realiza lo siguiente:
#  1. Grafica la distribución teórica de la variable aleatoria total_intl_charge

media <- mean(df$total_intl_charge)
ds <- sd(df$total_intl_charge) 

curve(dnorm(x, mean = media, sd = ds), from=0, to=5, 
      col='blue', main = "Densidad de Probabilidad Normal",
      ylab = "f(x)", xlab = "X")


#  2. ¿Cuál es la probabilidad de que el total de cargos internacionales sea
#  menor a 1.85 usd?

pnorm(q = 1.85, mean = media, sd = ds)

# La probabilidad es de 11.25%

x <- seq(-4, 4, 0.01)*ds + media
y <- dnorm(x, mean = media, sd = ds) 
plot(x, y, type = "l", xlab = "", ylab = "") +
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 2.764, " y ", sigma == 0.754))) +
polygon(c(min(x), x[x<=1.85], 1.85), c(0, y[x<=1.85], 0), col="red")


#  3. ¿Cuál es la probabilidad de que el total de cargos internacionales sea
#  mayor a 3 usd?

pnorm(q = 3, mean = media, sd = ds, lower.tail = FALSE)

# La probabilidad es de 37.74%

plot(x, y, type = "l", xlab = "", ylab = "") +
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 2.764, " y ", sigma == 0.754))) +
polygon(c(3, x[x>=3], max(x)), c(0, y[x>=3], 0), col="red")


#  4. ¿Cuál es la probabilidad de que el total de cargos internacionales esté
#  entre 2.35usd y 4.85 usd?

pnorm(q = 4.85, mean = media, sd = ds) - pnorm(q = 2.35, mean = media, sd = ds)

# La probabilidad es de 70.60%

plot(x, y, type = "l", xlab = "", ylab = "") +
  title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 2.764, " y ", sigma == 0.754))) +
  polygon(c(2.35, x[x>=2.35 & x<=4.85], 4.85), c(0, y[x>=2.35 & x<=4.85], 0), col="red")

#  5. Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales
#  más alto que podría esperar?

qnorm(p=0.48, mean = media, sd = ds)

# El valor más alto es de 2.73

#  6. ¿Cuáles son los valores del total de cargos internacionales que dejan
#  exactamente al centro el 80% de probabilidad?

qnorm(p=0.10, mean=media, sd=ds)
qnorm(p=0.90, mean=media, sd=ds)

# El 80% de los cargos está entre 1.80 y 3.73