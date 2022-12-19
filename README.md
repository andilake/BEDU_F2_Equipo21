# Postworks del Equipo 21
## Andrea Lagunes Kern

En este repositorio se encuentran los postworks del módulo Programación y estadística con R.

A continuación se explica el análisis realizado para el último postwork.

# Descripción del problema:

Un centro de salud nutricional está interesado en analizar estadísticamente y probabilísticamente los patrones de gasto en alimentos saludables y no saludables en los hogares mexicanos con base en su nivel socioeconómico, en si el hogar tiene recursos financieros extras al ingreso y en si presenta o no inseguridad alimentaria. Además, está interesado en un modelo que le permita identificar los determinantes socioeconómicos de la inseguridad alimentaria.

La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición (2012) levantada por el Instituto Nacional de Salud Pública en México. La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria.

La base de datos contiene las siguientes variables:  
- nse5f (Nivel socioeconómico del hogar): 1 "Bajo", 2 "Medio bajo", 3 "Medio", 4 "Medio alto", 5 "Alto"
- area (Zona geográfica): 0 "Zona urbana", 1 "Zona rural"
- numpeho (Número de persona en el hogar)
- refin (Recursos financieros distintos al ingreso laboral): 0 "no", 1 "sí"
- edadjef (Edad del jefe/a de familia)
- sexoje (Sexo del jefe/a de familia): 0 "Hombre", 1 "Mujer"
- añosedu (Años de educación del jefe de familia)
- ln_als (Logaritmo natural del gasto en alimentos saludables)
- ln_alns (Logaritmo natural del gasto en alimentos no saludables)
- IA (Inseguridad alimentaria en el hogar): 0 "No presenta IA", 1 "Presenta IA"

# Planteamiento del problema:

Se necesita encontrar si existe relación entre el nivel socioeconómico de las personas, el gasto que hacen en productos saludables y no saludables y la inseguridad alimentaria.

# Resolución del problema

Se crea el dataframe desde el archivo CSV inseguridad_alimentaria_bedu.csv. Usando las funciones class, str y dim se analiza la estructura de este y se concluye que debe ser limpiado.

Se seleccionan únicamente las variables que interesan usando la función select, las cuales son nse5f, refin, ln_als, ln_alns e IA. Posteriormente, se eliminan los casos incompletos.

Usando la función factor, se etiquetan los valores de nse5f, refin e IA para poder usarlos correctamente.

Se calculan los porcentajes y las medidas de tendencia central:

Nivel socioeconómico:
- 16.96% Bajo
- 19.05% Medio bajo
- 20.46% Medio
- 21.58% Medio alto
- 21.95% Alto

Recursos financieros distintos al ingreso laboral:
- 80.97 No
- 19.03 Sí

Inseguridad alimentaria
- 29.37% No
- 70.63% Sí

Medidas de tendencia central para gasto en alimentos saludables:

- Media: 6.205
- Moda: 6.31
- Mediana: 6.288

Medidas de tendencia central para gasto en alimentos no saludables:

- Media: 4.125
- Moda: 3.401
- Mediana: 4.025

Se crean histogramas de gasto en alimentos y se descubre que la distribución parece ser normal, por lo que se genera su gráfica de distribución normal. También se crean gráficos de barras del nivel socioeconómico, los recursos financieros distintos al ingreso y la inseguridad alimentaria).

Se generan las gráficas de correlación de nse5f, refin, ln_als, ln_alns e IA, pero al ser variables discretas es difícil ver la correlación. Se crea entonces el modelo lineal donde se compara el nivel socioeconómico con el resto de las variables y queda de la siguiente forma:

- Estimate Std. Error t value Pr(>|t|)
- (Intercept) -0.850697   0.077422 -10.988  < 2e-16
- refin       -0.148547   0.020800  -7.142 9.49e-13
- ln_als       0.573267   0.012628  45.397  < 2e-16
- ln_alns      0.224713   0.008303  27.065  < 2e-16
- IA          -0.680080   0.018087 -37.600  < 2e-16

Con esto descartamos que los recursos financieros distintos al ingreso laboral estén relacionados con el nivel socioeconómico, por lo que lo quitamos del modelo y posteriormente comprobamos que el error del modelo distribuye como una normal.

Finalmente, usando valores aleatorios generamos una predicción. Y se concluye que al utilizar un gasto elevado en comida no saludable e inseguridad alimenticia se obtiene un nivel socioeconómico cercano a 1 (Bajo), y en el caso contrario, se obtiene un nivel cercano a 5 (Alto), por lo que el modelo cumple con la hipótesis planteada en un inicio de que un nivel socioeconómico bajo se relaciona con un gasto más elevado de comida no saludable y por tanto inseguridad alimenticia.
