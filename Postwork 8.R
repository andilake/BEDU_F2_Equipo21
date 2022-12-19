# Postwork sesión 8
# Andrea Lagunes Kern
# Equipo 21

#### Desarrollo

# Un centro de salud nutricional está interesado en analizar estadísticamente y
# probabilísticamente los patrones de gasto en alimentos saludables y no
# saludables en los hogares mexicanos con base en su nivel socioeconómico, en
# si el hogar tiene recursos financieros extras al ingreso y en si presenta o
# no inseguridad alimentaria. Además, está interesado en un modelo que le
# permita identificar los determinantes socioeconómicos de la inseguridad
# alimentaria.

# La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición
# (2012) levantada por el Instituto Nacional de Salud Pública en México. La
# mayoría de las personas afirman que los hogares con menor nivel socioeconómico
# tienden a gastar más en productos no saludables que las personas con mayores
# niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un
# hogar presente cierta inseguridad alimentaria.

# La base de datos contiene las siguientes variables:
  
# nse5f (Nivel socioeconómico del hogar): 1 "Bajo", 2 "Medio bajo", 3 "Medio", 4 "Medio alto", 5 "Alto"
# area (Zona geográfica): 0 "Zona urbana", 1 "Zona rural"
# numpeho (Número de persona en el hogar)
# refin (Recursos financieros distintos al ingreso laboral): 0 "no", 1 "sí"
# edadjef (Edad del jefe/a de familia)
# sexoje (Sexo del jefe/a de familia): 0 "Hombre", 1 "Mujer"
# añosedu (Años de educación del jefe de familia)
# ln_als (Logaritmo natural del gasto en alimentos saludables)
# ln_alns (Logaritmo natural del gasto en alimentos no saludables)
# IA (Inseguridad alimentaria en el hogar): 0 "No presenta IA", 1 "Presenta IA"

# Plantea el problema del caso
# Realiza un análisis descriptivo de la información
# Calcula probabilidades que nos permitan entender el problema en México
# Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México
# Estima un modelo de regresión, lineal o logístico, para identificar los determinantes de la inseguridad alimentaria en México
# Escribe tu análisis en un archivo README.MD y tu código en un script de R y publica ambos en un repositorio de Github.

"Se necesita encontrar si existe relación entre el nivel socioeconómico de las
personas, el gasto que hacen en productos saludables y no saludables y la
inseguridad alimentaria."

"Creación del data frame"

df<-read.csv("https://raw.githubusercontent.com/andilake/BEDU_F2_Equipo21/main/inseguridad_alimentaria_bedu.csv")

"Análisis de estructura del data frame"

class(df)
str(df)
dim(df)

View(df)

"Para empezar, hay que limpiar el data frame quitando los datos que son
irrelevantes para nuestro análisis."

library(DescTools)
CountCompCases(df)

library(dplyr)

df.select <- select(df, nse5f, numpeho, refin, ln_als, ln_alns, IA)
str(df.select)
CountCompCases(df.select)

df.clean <- df.select[complete.cases(df.select),]

str(df.clean)
summary(df.clean)

"Buscar si hay relación entre el gasto alimentario y el número de personas."

ln_altot <- df.clean$ln_als + df.clean$ln_alns

pairs(~df.clean$numpeho + ln_altot)
m1 <- lm(df.clean$numpeho ~ ln_altot)

summary(m1)

StanRes1 <- rstandard(m1)

plot(ln_altot, StanRes1, ylab = "Residuales Estandarizados")

shapiro.test(head(StanRes1,500))

"La distribución no es normal, por lo que no se cumple con el segundo supuesto
del modelo de regresión lineal y descartamos que haya relación entre el gasto
alimentario y el número de personas."

df.select <- select(df, nse5f, refin, ln_als, ln_alns, IA)
str(df.select)
CountCompCases(df.select)

df.clean <- df.select[complete.cases(df.select),]

str(df.clean)
summary(df.clean)

nse5f.factor <- factor(df.clean$nse5f, levels = c(1 = "Bajo", 2 = "Medio bajo", 3 = "Medio", 4 = "Medio alto", 5 = "Alto"), ordered = TRUE)
refin.factor <- factor(df.clean$refin, labels = c("No", "Sí"))
IA.factor <- factor(df.clean$IA, labels = c("No presenta IA", "Presenta IA"))

summary(nse5f.factor)
summary(refin.factor)
summary(IA.factor)

attach(df.clean)

"Nivel socioeconómico:"
3935/23201 #16.96% Bajo
4419/23201 #19.05% Medio bajo
4748/23201 #20.46% Medio
5007/23201 #21.58% Medio alto
5092/23201 #21.95% Alto

"Recursos financieros distintos al ingreso laboral"
18787/23201 #80.97 No
4414/23201  #19.03 Sí

"Inseguridad alimentaria"
6815/23201  #29.37% No
16386/23201 #70.63% Sí

"Medidas de tendencia central para gasto en alimentos saludables"

mean(ln_als) # Media: 6.205
Mode(ln_als)[1] # Moda: 6.31
median(ln_als) # Mediana: 6.288

"Medidas de tendencia central para gasto en alimentos no saludables"

mean(ln_alns) # Media: 4.125
Mode(ln_alns)[1] # Moda: 3.401
median(ln_alns) # Mediana: 4.025

"Histogramas"

par(mfrow=c(2,1))

hist(ln_als, main = "Gasto en alimentos saludables", xlab = "Gasto", ylab = "Frecuencia")
hist(ln_alns, main = "Gasto en alimentos no saludables", xlab = "Gasto", ylab = "Frecuencia")

dev.off()

"Gráficas de frecuencias"

par(mfrow=c(2,2))

barplot(table(nse5f), main = "Nivel socioeconómico", xlab = "Nivel socioeconómico", ylab = "Frecuencia")
barplot(table(refin), main = "Recursos financieros distintos al ingreso laboral", xlab = "Recursos financieros distintos al ingreso laboral", ylab = "Frecuencia")
barplot(table(IA), main = "Inseguridad alimentaria", xlab = "Inseguridad alimentaria", ylab = "Frecuencia")

dev.off()

"Gráficas de distribución normal"

ln_als.mean <- mean(ln_als)
ln_als.sd <- sd(ln_als)

ln_alns.mean <- mean(ln_alns)
ln_alns.sd <- sd(ln_alns)

{curve(dnorm(x, mean = ln_als.mean, sd = ln_als.sd), from = 0, to = 10, 
      col='blue', main = "Gasto alimentario", sub = "Saludable (Azul), No saludable (Rojo)",
      ylab = "f(x)", xlab = "X") 
  curve(dnorm(x, mean = ln_alns.mean, sd = ln_alns.sd), from = 0, to = 10, 
      col='red', add = TRUE)}

pairs(~ nse5f + refin + ln_als + ln_alns + IA, 
            data = df.clean, gap = 0.4, cex.labels = 1.5)

m2 <- lm(nse5f ~ refin + ln_als + ln_alns + IA)
summary(m2)

"Los recursos financieros distintos al ingreso no parecen tener relevancia por 
lo que se omiten del modelo."

m3 <- update(m2, ~.-refin)
summary(m3)

StanRes3 <- rstandard(m3)

par(mfrow=c(2,2))

plot(ln_als, StanRes3, ylab = "Residuales Estandarizados")
plot(ln_alns, StanRes3, ylab = "Residuales Estandarizados")
plot(IA, StanRes3, ylab = "Residuales Estandarizados")

dev.off()

"Ho: La variable distribuye como una normal
Ha: La variable no distribuye como una normal"

shapiro.test(head(StanRes3))

"Con un nivel de confianza de 95% se acepta Ho, es decir, que el error distribuye
como una normal."

data <- data.frame(
  ln_als = c(0, 3, 6, 10),
  ln_alns = c(10, 6, 3, 0),
  IA = c(1, 0, 1, 0)
)

predict(m3, newdata = data, interval = "confidence", level = 0.95)

"Al utilizar un gasto elevado en comida no saludable e inseguridad alimenticia
se obtiene un nivel socioeconómico cercano a 1 (Bajo), y en el caso contrario,
se obtiene un nivel cercano a 5 (Alto), por lo que el modelo cumple con la
hipótesis planteada en un inicio de que un nivel socioeconómico bajo se
relaciona con un gasto más elevado de comida no saludable y por tanto inseguridad
alimenticia."


