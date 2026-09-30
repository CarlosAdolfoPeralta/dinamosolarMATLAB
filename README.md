MODELO AXISIMETRICO DE DINAMO SOLAR - MATLAB
============================================

PROPOSITO
---------
Este programa integra un modelo axisimetrico de dinamo a gran escala en 
coordenadas esféricas. Evoluciona los campos magneticos poloidal y toroidal,
 incluye la produccion de campo por rotacion diferencial y un efecto alfa, y 
permite que la fuerza magnetica modifique el flujo meridional. La implementacion de
esta carpeta sigue el modelo descrito por Sraibman y Minotti (2019); este
resumen no reemplaza la derivacion completa del articulo.

EJECUCION
---------
1. Abra MATLAB y establezca como carpeta actual aquella en la que está el programa.
2. Ejecute `toy_prueba.m` desde el Editor o escriba `toy_prueba` en la ventana
    de comandos. El script llama a `parameter.m` y al resto de las rutinas, que
    deben permanecer en la misma carpeta o en el path de MATLAB.
3. La simulacion puede ser extensa: `maxpasos` esta configurado inicialmente
    en 500000. Para una prueba corta, reduzca este valor en `parameter.m`.

ORGANIZACION DEL CALCULO
------------------------
- `toy_prueba.m` crea las mallas, inicializa los campos y coordina la
   integracion temporal, los graficos, las comprobaciones y el guardado.
- `parameter.m` define parametros fisicos, resolucion, intervalos de salida y
   prepara el directorio de resultados.
- `omegaf.m`, `densidad.m` y `velmeri4.m` calculan los perfiles de rotacion,
   densidad y flujo meridional impuesto.
- `alfan4.m` obtiene el coeficiente alfa cinematico. `ws1alfaBL1.m` evoluciona
   la vorticidad de retroalimentacion y calcula el alfa BL asociado.
- `etauv4.m` estima la difusividad turbulenta local a partir del flujo, la
   rotacion y el campo magnetico.
- `calca_1.m` calcula la evolucion del potencial poloidal A y las componentes
   Br y Btheta. `calcanx.m` trata los terminos evaluados en el borde radial.
- `calcb4_1.m` integra el campo toroidal Bphi con transporte, difusion,
   cizalladura y el cierre subgrid `Scero3.m`.
- `leap2.m` calcula el flujo meridional inducido por la fuerza magnetica.
- `laplaciano.m`, `suavixy.m`, `suavixy2.m`, `suavixy2d.m` y `suavixy2dbl.m`
   regularizan campos o terminos subgrid y aplican las simetrias usadas en la
   malla.
- `guardaa.m`, `guardab.m`, `guardbb.m`, `guardaur.m` y `guardautit.m`
   extraen historiales en indices radiales seleccionados.
- `creaxyb.m`, `grafico.m`, `graficoa.m` y `grafurut.m` preparan coordenadas
   y graficos de diagnostico.

PARAMETROS PRINCIPALES
----------------------
Los valores se definen en `parameter.m`; revise ese archivo antes de iniciar
una corrida larga.

- `factalf`: amplitud relativa del efecto alfa; valor inicial 0.35.
- `cs`: coeficiente de Smagorinsky; valor inicial 0.1.
- `suavizado`: intervalo para suavizar A y B; valor inicial 200 pasos.
- `n`: multiplicador de la rotacion omega; valor inicial 1.
- `dibu`: intervalo entre graficos de diagnostico; valor inicial 50000 pasos.
- `timesave`: intervalo de muestreo de historiales; valor inicial 1000 pasos.
- `maxpasos`: duracion maxima; valor inicial 500000 pasos.
- `delttime`: paso temporal inicial; se ajusta al inicio con limites
   advectivos y difusivos.
- `rtope`: radio externo, 7e8 m; `rcero`: radio interno, 0.55 `rtope`.
- `rp`: limite radial del flujo impuesto, 0.69 `rtope`.
- `lamda`: longitud del cierre subgrid, 0.1 `rcero`.
- `puntostit` y `puntosr`: resolucion angular y radial.
- `mu0`: permeabilidad magnetica del vacio; `sigma`: amplitud del flujo
   meridional impuesto.

SALIDAS
-------
El programa prepara una carpeta cuyo nombre incluye `factalf`, `cs` y `n`.
En los pasos definidos por `timesave`, guarda variables en archivos MATLAB
`.mat`, entre ellos `a.mat`, `brtaco.mat`, `btittaco.mat`, `b.mat`, `ur.mat`,
`utit.mat` y `todo.mat`. Tambien genera archivos `.png` cuando se alcanza el
intervalo `dibu`. Algunas salidas auxiliares, como `alf.mat` y `velmerid.mat`,
se guardan en la carpeta de trabajo actual segun las instrucciones `save` del
script.

Los historiales `guardaa`, `guardab`, `guardbb`, `guardaur` y `guardautit`
registran perfiles angulares en indices radiales seleccionados; no representan
una malla radial completa. Los archivos `.mat` se pueden inspeccionar desde
MATLAB, por ejemplo con `load('ur.mat')`.

REQUISITOS
----------
MATLAB con soporte para graficos. El script usa `findpeaks` para analizar los
picos de una serie; esa funcion requiere Signal Processing Toolbox.

REFERENCIA
----------
Sraibman, L., & Minotti, F. (2019). Large-scale model of the axisymmetric
dynamo with feedback effects. Solar Physics, 294(1), 14.
DOI: https://doi.org/10.1007/s11207-018-1350-1

