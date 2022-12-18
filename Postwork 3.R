# Postwork Sesión 3

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")
str(df)
summary(df)

df$Grupo <- factor(df$Grupo)
df$Categoria <- factor(df$Categoria, levels = c("C1", "C2", "C3"), ordered = TRUE)

complete.cases(df)
sum(complete.cases(df))

df.clean <- df[complete.cases(df),]
str(df.clean)
summary(df.clean)


#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`

library(DescTools)
library(moments)

mean(df.clean$Mediciones) # La media es de 62.88
mean(df.clean$Mediciones, trim = 0.20) # La media acotada al 20% es de 50.78

median(df.clean$Mediciones) # La mediana es de 49.3

Mode(df.clean$Mediciones) # La moda es 23.3 y se repite 6 veces

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?

" Las medidas de tendencia central no se encuentran de manera simétrica alrededor de la media
lo que indica que hay un sesgo"

skewness(df.clean$Mediciones) # El sesgo es a la derecha

#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`

var(df.clean$Mediciones)
sd(df.clean$Mediciones) 
'Hay una desviación estándar o variabilidad de 53.77, lo que indica que existe una dispersión muy
grande de los datos.'

cuartiles <- quantile(df.clean$Mediciones, probs = c(0.25, 0.50, 0.75))
cuartiles
'El 25% de las mediciones es menor o igual a 23.45, el 50% es menor o igual a 49.30
y el 75% es menor o igual a 82.85.'

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"

library(ggplot2)

k = ceiling(sqrt(length(df.clean$Mediciones)))
ac = (max(df.clean$Mediciones)-min(df.clean$Mediciones))/k
bins <- seq(min(df.clean$Mediciones), max(df.clean$Mediciones), by = ac)

hist(df.clean$Mediciones, breaks = bins, main = "Histograma de Medidas")

ggplot(df.clean, aes(x = Mediciones)) + geom_histogram(aes(color = Categoria, fill = Categoria), position = "identity", breaks = bins, alpha = 0.4) + theme_minimal() + labs(title = "Histograma de Medidas por Categoría")

# El sesgo ocurre para las tres categorías.

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"

ggplot(df.clean, aes(x = Mediciones)) + geom_boxplot(aes(fill = Categoria, color = Grupo), alpha = 0.2)

# El sesgo a la derecha parece estar dado por las mediciones del grupo 1.
