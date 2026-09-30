%%% Paramtros del modelo
% Define parametros fisicos, resolucion y frecuencias de salida.

factalf=0.35; %% valor entre 0 y 1 para el alfa (0.35 originalmente)
cs=0.1;  %Coeficiente de Smagorinsky normalmente 0.1
suavizado=200; %Cantidad de pasos para hacer suavizado, esta en 200, 100 era el normal anterior
n=1;  %Multiplicador de omega, 1 originalmente

%%%%%% tiempo de guardado, dibujo, corrida y deltat
% Estos valores fijan la duracion de la corrida y los intervalos de diagnostico.
    dibu=50000;   %%%Cada cuantos pasos de tiempo grafica resultados
    timesave=1000;  %%%% Cada cuantos pasos de tiempo guarda los valores de todas las variables en disco
    maxpasos=500000;%% tiempo de corrida  
    ntime=maxpasos/timesave;
    delttime= 1; %cada paso de 8640 segundos originalmente

%%%Campo magnético ecuatorial en radio externo inicial, en Tesla
    bsol=1*10^(-4); 
    bcero= 1*bsol;

  %%%Parametros de estrella
      
    rtope=7E8;   %% Rsolar es 7E8 metros
    rcero=0.55*rtope;   %% Radio donde comienza los calculos el modelo (en lo que seria el nucleo)
    rp=0.69*rtope; %%% Hasta que radio permito la penetracion del flujo meridional
    lamda=0.1*rcero; %%%Longitud de promedio de la subgrilla  
   
    t=1;

%%%%%Paramtros de GRilla
% Define los espaciados de las mallas radial y angular.

    puntostit=30; 
    deltit=pi/puntostit;%usa puntostit+1 puntos en tita
   
    puntosr=63;
    deltr=(rtope-rcero)/puntosr;

 
       

%%%%Constantes    
% Establece constantes fisicas y la amplitud del flujo meridional impuesto.
    mu0=4*pi*1E-7;
    sigma=-7E-8; %era -7E-8

%%%%%% Nombro carpeta de guardado 
% Prepara el directorio donde el programa principal escribe los resultados.
    
    %Nombre automatico usando factalf y cs  
    dirName = ['factalf_' num2str(factalf) '_cs_' num2str(cs) '_' num2str(n) 'w' ];     
    mkdir(dirName) 
    ppath = ['/' dirName '/'];
  %Nombre manual
   % mkdir fa45cs15  
    %ppath='\fa45cs15\';

  
    
