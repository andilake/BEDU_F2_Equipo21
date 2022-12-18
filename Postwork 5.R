# Postwork Sesión 5


#### Instrucciones

# El data frame iris contiene información recolectada por Anderson sobre 50 
# flores de 3 especies distintas (setosa, versicolor y virginca), incluyendo 
# medidas en centímetros del largo y ancho del sépalo así como de los pétalos.

# Estudios recientes sobre las mismas especies muestran que:
  
#  I. En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es 
# igual a 5.7 cm

#  II. En promedio, el ancho del pétalo de la especie virginica (Petal.Width) 
# es menor a 2.1 cm

# III. En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más 
# grande que el promedio del largo del pétalo de la especie versicolor.

# IV. En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies.

# Utilizando pruebas de inferencia estadística, concluye si existe evidencia 
# suficiente para concluir que los datos recolectados por Anderson están en 
# línea con los nuevos estudios.

# Utiliza 99% de confianza para todas las pruebas, en cada caso realiza el 
# planteamiento de hipótesis adecuado y concluye

# 1. Largo del sépalo de la especie setosa
# Ho: Sepal.Length = 5.7
# Ha: Sepal.Length != 5.7

t.test(iris[iris$Species == 'setosa', "Sepal.Length"], 
       alternative = 'two.sided', mu=5.7, conf.level = 0.99)

# Se rechaza que la longitud del sépalo de la especie setosa sea 5.7 cm en los
# datos de Anderson.

# 2. Ancho del pétalo de la especie virginica
# Ho: Petal.Width => 2.1 
# Ha: Petal.Width < 2.1

t.test(iris[iris$Species == 'virginica', "Petal.Width"], 
       alternative = 'less', mu=2.1, conf.level = 0.99)

# Se rechaza que el ancho de pétalo sea menor a 2.1.

# 3. Largo del pétalo de la especie virgínica comparado con el de la especie versicolor.
# Ho: Petal.Length.virg - Petal.Length.vers = 1.1 
# Ha: Petal.Length.virg - Petal.Length.vers != 1.1

t.test(iris[iris$Species == 'virginica', "Petal.Length"] - iris[iris$Species == 'versicolor', "Petal.Length"], 
       alternative = 'two.sided', mu=1.1, conf.level = 0.99)

# Se rechaza que la diferencia del largo del pétalo de la especie virginica
# y el de la versicolor sea diferente a 1.1cm.

# 4. En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies.

# Ho: La media del ancho del sépalo es igual en las 3 especies
# Ha: Al menos un promedio es diferente del resto

anova <- aov(Sepal.Width ~ Species, data = iris)
summary(anova)

# Se rechaza la hipótesis nula, es decir, el ancho del sépalo no es igual en
# las 3 especies. 

boxplot(Sepal.Width ~ Species, data = iris)