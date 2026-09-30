# MODELO AXISIMÉTRICO DE DINAMO SOLAR - MATLAB

=============================================

## PROPÓSITO

---

Este programa implementa un modelo axisimétrico de dinamo a gran escala en coordenadas esféricas. El modelo evoluciona los campos magnéticos poloidal y toroidal, incluye la generación de campo debida a la rotación diferencial y al efecto alfa, y permite que la fuerza magnética modifique el flujo meridional.

La implementación de esta carpeta sigue el modelo descrito por Sraibman y Minotti (2019). Este resumen proporciona una descripción general del programa y no reemplaza la derivación completa presentada en el artículo.

## EJECUCIÓN

---

1. Abra MATLAB y establezca como carpeta actual aquella en la que se encuentra el programa.

2. Ejecute `toy_prueba.m` desde el Editor de MATLAB o escriba `toy_prueba` en la ventana de comandos. El script llama a `parameter.m` y al resto de las rutinas, que deben permanecer en la misma carpeta o estar incluidas en el *path* de MATLAB.

3. La simulación puede requerir un tiempo considerable. El parámetro `maxpasos` está configurado inicialmente en 500000. Para realizar una prueba corta, reduzca este valor en `parameter.m`.

## ORGANIZACIÓN DEL CÁLCULO

---

* `toy_prueba.m` crea las mallas, inicializa los campos y coordina la integración temporal, la generación de gráficos, las comprobaciones y el guardado de resultados.

* `parameter.m` define los parámetros físicos, la resolución espacial, los intervalos de salida y prepara el directorio de resultados.

* `omegaf.m`, `densidad.m` y `velmeri4.m` calculan los perfiles de rotación, densidad y flujo meridional impuesto, respectivamente.

* `alfan4.m` obtiene el coeficiente alfa cinemático. `ws1alfaBL1.m` evoluciona la vorticidad de retroalimentación y calcula el alfa asociado al mecanismo BL.

* `etauv4.m` estima la difusividad turbulenta local a partir del flujo, la rotación y el campo magnético.

* `calca_1.m` calcula la evolución del potencial poloidal `A` y las componentes `Br` y `Btheta`. `calcanx.m` trata los términos evaluados en el borde radial.

* `calcb4_1.m` integra el campo toroidal `Bphi`, incluyendo los términos de transporte, difusión y cizalladura, junto con el cierre subgrid definido en `Scero3.m`.

* `leap2.m` calcula el flujo meridional inducido por la fuerza magnética.

* `laplaciano.m`, `suavixy.m`, `suavixy2.m`, `suavixy2d.m` y `suavixy2dbl.m` regularizan campos o términos subgrid y aplican las simetrías utilizadas en la malla.

* `guardaa.m`, `guardab.m`, `guardbb.m`, `guardaur.m` y `guardautit.m` extraen y almacenan historiales en índices radiales seleccionados.

* `creaxyb.m`, `grafico.m`, `graficoa.m` y `grafurut.m` preparan las coordenadas y generan gráficos de diagnóstico.

## PARÁMETROS PRINCIPALES

---

Los valores de los parámetros se definen en `parameter.m`. Se recomienda revisar este archivo antes de iniciar una simulación de larga duración.

* `factalf`: amplitud relativa del efecto alfa. Valor inicial: 0.35.

* `cs`: coeficiente de Smagorinsky. Valor inicial: 0.1.

* `suavizado`: intervalo utilizado para suavizar los campos `A` y `B`. Valor inicial: 200 pasos.

* `n`: multiplicador de la rotación `omega`. Valor inicial: 1.

* `dibu`: intervalo entre gráficos de diagnóstico. Valor inicial: 50000 pasos.

* `timesave`: intervalo de muestreo de los historiales. Valor inicial: 1000 pasos.

* `maxpasos`: número máximo de pasos de la simulación. Valor inicial: 500000 pasos.

* `delttime`: paso temporal inicial. Se ajusta al comienzo de la simulación de acuerdo con los límites advectivos y difusivos.

* `rtope`: radio externo. Valor inicial: `7e8 m`.

* `rcero`: radio interno. Valor inicial: `0.55*rtope`.

* `rp`: límite radial del flujo impuesto. Valor inicial: `0.69*rtope`.

* `lamda`: longitud característica del cierre subgrid. Valor inicial: `0.1*rcero`.

* `puntostit` y `puntosr`: número de puntos de la resolución angular y radial, respectivamente.

* `mu0`: permeabilidad magnética del vacío.

* `sigma`: amplitud del flujo meridional impuesto.

## SALIDAS

---

El programa prepara una carpeta cuyo nombre incluye los valores de `factalf`, `cs` y `n`.

En los pasos definidos por `timesave`, se guardan distintas variables en archivos MATLAB `.mat`, entre ellos `a.mat`, `brtaco.mat`, `btittaco.mat`, `b.mat`, `ur.mat`, `utit.mat` y `todo.mat`.

También se generan archivos `.png` cuando se alcanza el intervalo definido por `dibu`.

Algunas salidas auxiliares, como `alf.mat` y `velmerid.mat`, se guardan en la carpeta de trabajo actual, de acuerdo con las instrucciones `save` utilizadas en el código.

Los historiales generados por `guardaa`, `guardab`, `guardbb`, `guardaur` y `guardautit` registran perfiles angulares en determinados índices radiales. Por lo tanto, estos archivos no representan una malla radial completa.

Los archivos `.mat` pueden inspeccionarse directamente desde MATLAB. Por ejemplo:

```matlab
load('ur.mat')
```

## REQUISITOS

---

Se requiere MATLAB con soporte para gráficos.

El script utiliza `findpeaks` para analizar los picos de una serie temporal. Esta función requiere **Signal Processing Toolbox**.

## REFERENCIA

---

Sraibman, L., & Minotti, F. (2019). *Large-scale model of the axisymmetric dynamo with feedback effects*. Solar Physics, 294(1), 14.

DOI: https://doi.org/10.1007/s11207-018-1350-1


