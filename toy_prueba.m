

%******** TOY MODEL ****************
% Programa principal: inicializa el modelo y avanza sus campos en el tiempo.

clear all

%set(groot,'defaultFigureVisible','off')

%set(0,'DefaultFigureVisible','off')
set(groot, 'defaultFigureColormap', jet);

clear a aini rtope rcero r tit nx ntit ur utit rem ntime x y
global a aini rtope rcero r tit nx ntit ur utit ntime timesave n
global deltr deltit
global brtaco brtaco2 brtaco3 brtaco4 brtaco5 
global btittaco  btittaco2 btittaco3 btittaco4 btittaco5

sigma=double(1);

% Carga los parametros globales, fisicos y numericos del caso.
parameter %%%%Carga los valores de las variables


%******CONSTANTES****
      pi=3.1415926535897932384626433832795;
%***************CANTIDAD DE PUNTOS****
      % Calcula el numero de puntos y crea las coordenadas de la malla.
      nx=ceil((rtope-rcero)/deltr);
      ntit=ceil((pi)/deltit)+1;
     

      r=zeros([nx 1]);
      tit=zeros([ntit 1]);
      
      aprim=zeros([nx ntit]);
      bprim=zeros([nx ntit]);
            
      
      r(1)=rcero;
      tit(1)=pi;
      

%***********CALCULO GRILLA

      
      for i=2:nx
      r(i)=r(i-1)+deltr;
      end
      
      for j=2:ntit
      tit(j)=tit(j-1)- deltit;
      end


%*************Condiciones iniciales
% Reserva campos, velocidades e historiales que se actualizaran en la corrida.

 fr=zeros(nx,1);
 g=zeros(ntit,1);
 a=zeros(nx, ntit);
 b=zeros(nx, ntit);
 btit=zeros(nx, ntit);
 br=zeros(nx, ntit);
 ataco=zeros(ntime,nx,ntit);
 brtaco=zeros(ntime, ntit);
 brtaco2=zeros(ntime, ntit);
 brtaco3=zeros(ntime, ntit);
 brtaco4=zeros(ntime, ntit);
 brtaco5=zeros(ntime, ntit);
 btittaco=zeros(ntime, ntit);
 btittaco2=zeros(ntime, ntit);
 btittaco3=zeros(ntime, ntit);
 btittaco4=zeros(ntime, ntit);
 btittaco5=zeros(ntime, ntit);
 btaco=zeros(ntime, ntit);
 btaco2=zeros(ntime, ntit);
 btaco3=zeros(ntime, ntit);
 btaco4=zeros(ntime, ntit);
 btaco5=zeros(ntime, ntit);
 
 utit3=zeros(nx, ntit);
 ur3=zeros(nx, ntit);
 urt1=zeros(ntime, ntit);
 urt2=zeros(ntime, ntit);
 urt3=zeros(ntime, ntit);
 urt4=zeros(ntime, ntit);
 urt5=zeros(ntime, ntit);
 utitt1=zeros(ntime, ntit);
 utitt2=zeros(ntime, ntit);
 utitt3=zeros(ntime, ntit);
 utitt4=zeros(ntime, ntit);
 utitt5=zeros(ntime, ntit);
 
ws=zeros(nx, ntit);
alfaguar=zeros(nx,ntit,ntime);
urtiemp2=zeros(nx,ntit,ntime);
utittiemp2=zeros(nx,ntit,ntime);
alfaguarBL=zeros(nx,ntit,ntime);
urtiemp3=zeros(nx,ntit,ntime);
utittiemp3=zeros(nx,ntit,ntime);
 
      % Inicializa el potencial poloidal con el perfil radial y angular elegido.
      for i=1:nx
      for j=1:ntit
% b(i,j)= 2*10E-12*(r(i)-rp)*cos(tit(j))*sin(tit(j));       
 a(i,j)=bcero*2*rtope/(2*rtope-rp)*(r(i)-rp)*sin(tit(j));
      end
      end
     
  
       ur=zeros(nx, ntit);
       utit=zeros(nx, ntit);

      % Construye los perfiles iniciales de rotacion, densidad y flujo de fondo.
      [omega]=omegaf(r,rtope , nx, tit,ntit);

      aini(:,:)=a(:,:);
 [ro]=densidad(r,nx,rtope);
 
 ur2=zeros(nx,ntit);
 utit2=zeros(nx,ntit);
%Inicia con velocidad meridional 
 [ur2 utit2]=velmeri4(rtope,rcero,rp,nx,ntit,r,tit,sigma,ro);  
ur=ur2;
utit=utit2;   
 
[alf]=alfan4(lamda,r,tit,ur,utit,omega,nx,ntit,deltr,deltit,rtope,...
      factalf);   
 
      alfao(:,:)=alf(:,:);
      
     m=1;
    






      % Integra el sistema hasta alcanzar la cantidad maxima de pasos.
      while m <= maxpasos 

       %*********************      comienza loop en tiempo      
       graf=1; %1 para graficar potencial vector

      % Genera graficos de diagnostico en los pasos indicados por dibu.
      if (mod(m,dibu)==0)

%Grafico velocidad completa ur utit
%    grafurut(ur,utit);
%    arch=[pwd ppath 'urutit_t_' num2str(m) '.png'];
%    saveas(gcf,arch ,'png'); 
%    close all
 %Grafico perturbacion de la velocidad ur3 utit3
      grafurut(ur3,utit3,'velocidad');
   arch=[pwd ppath 'ur3utit3_t_' num2str(m) '.png'];
      exportgraphics(gcf,arch,'Resolution',900);
   close all
%Grafico br btit
      grafurut(br,btit,'magnetico');
   arch=[pwd ppath 'brbtit_t_' num2str(m) '.png'];
      exportgraphics(gcf,arch,'Resolution',900);
   close all

%Grafico br a radio tacoclina1 y angulo fijo tit(20), en función de cantidad de años
figure
plot(linspace(1,m/timesave-1,m/timesave-1)*timesave*delttime/(3*10^7),brtaco4(1:m/timesave-1,20))
%Veo distancia entre picos
[pks, locs] = findpeaks(brtaco4(1:m/timesave-1,20),linspace(1,m/timesave-1,m/timesave-1)*timesave*delttime/(3*10^7));
% Diferencia entre los primeros dos picos
if size(locs,2)>1
diferencia_entre_picos = pks(size(locs,2))/pks(size(locs,2)-1);
tiempo_entre_picos = locs(end) - locs(end-1);
cociente_entre_picos = pks(end)/pks(end-1);
title(sprintf('Años entre picos: %.1f; Cociente entre picos: %.1f', ...
      tiempo_entre_picos,cociente_entre_picos));
end
xlabel('Años');
ylabel('$B_r$','Interpreter','latex');



  arch=[pwd ppath 'brtaco_t_' num2str(m) '.png'];
      exportgraphics(gcf,arch,'Resolution',900);
close all

 figure
  pcolor(linspace(1,m/timesave-1,m/timesave-1)*timesave*delttime/(3*10^7),cos(tit),brtaco4(1:m/timesave-1,:)')
shading interp
title('Evolución temporal de Br en la tacoclina');
xlabel('Años');
ylabel('$\cos(\theta)$','Interpreter','latex');
colorbar('eastoutside');
  arch=[pwd ppath 'brtaco2_t_' num2str(m) '.png'];
      exportgraphics(gcf,arch,'Resolution',900);
close all
  end



% Estima la difusividad turbulenta local antes de actualizar los campos.
[etau]=etauv4(nx,ntit,ur,utit,r,tit,cs,deltr,deltit,omega,br,btit,b,ro);

% En el primer paso fija delttime con limites advectivos y difusivos.
if m==1
veltotal=zeros(nx,ntit);
for i=1:nx
for j=1:ntit
veltotal(i,j)=(ur(i,j)^2+(omega(i,j)*r(i)*sin(tit(j)))^2+utit(i,j)^2)^(1/2)+(br(i,j)^2+btit(i,j)^2+b(i,j)^2)^(1/2)/(mu0*ro(i))^(1/2);
end
end
velcondicion=max(max(veltotal));
etacondicion=max(max(abs(etau)));
delttime=1*min(min(r(1)*deltit/velcondicion,(r(1)*deltit)^2/(6*etacondicion)),20000);
end
 
 
 % Actualiza el potencial poloidal y calcula sus componentes de campo.
 [a,aprim,br,btit ] = calca_1(a,ntit,nx,deltr...
  ,deltit,r,tit,ur,utit,etau,delttime,br,btit,b,alf,aprim,m,graf...
  ,rtope,omega,lamda,ppath,dibu);


% Actualiza el campo toroidal, incluida la cizalladura y el cierre subgrid.
[b , bprim]=calcb4_1(b,ntit,nx,deltr,deltit,r,tit,...
ur,utit,etau,delttime,br,btit,a,omega,bprim,m,1,lamda,ppath,dibu);

 % Avanza A y B con el esquema explicito de Euler.
 a(:,:)=a(:,:)+delttime*aprim(:,:);
 b(:,:)=b(:,:)+delttime*bprim(:,:);

  if(mod(m,suavizado)==0)
   [b]=suavixy(b,nx,ntit); 
   [a]=suavixy(a,nx,ntit);
 end

m

       m=m+1;
       
%%Agrega feed

 % Calcula la circulacion inducida y la suma al flujo meridional de fondo.
 [ur3,utit3]=leap2(r,tit,nx,ntit,rtope,mu0,omega,b,br,btit,deltr,...
                  deltit,ro);


ur(:,:)=ur2(:,:)+ur3(:,:);
utit(:,:)=utit2(:,:)+utit3(:,:);



%Agrega alfa de BL       

% 
% [ws,alfBL]=ws1alfaBL2(lamda,r,tit,ur3,utit3,nx,ntit,deltr,...
%     deltit,rtope,factalf,b,br,btit,mu0,ws,delttime,m,ppath,dibu,ro);
% Actualiza la vorticidad y el alfa de retroalimentacion.
if m>0
[ws,alfBL]=ws1alfaBL1(lamda,ur2,utit2,ur3,utit3,factalf,ws,delttime,omega);
 alf=alfao+alfBL;
 end

%Actualizo valores



 
%Error si hay inestabilidad fuerte
% Detiene la corrida si aparece un valor no definido por inestabilidad.
if isnan(ur(15,10))
    error('Inestabilidad o divergencia');
end

%Empiezo a guardar cosas
 % Guarda historiales y estado del modelo en los pasos de muestreo.
 if(mod(m,timesave)==0)
[btaco,btaco2,btaco3,btaco4,btaco5]=guardbb(b,m/timesave,ntit,btaco,btaco2,...
    btaco3,btaco4,btaco5);
 
[urt1,urt2,urt3,urt4,urt5]=guardaur(ur3,m/timesave,ntit,urt1,urt2,urt3,urt4,urt5);

[utitt1,utitt2,utitt3,utitt4,utitt5]=guardautit(utit3,m/timesave,ntit,...
    utitt1,utitt2,utitt3,utitt4,utitt5);
% [alfaguar,alfaguarBL]=guardaalfa(alf,alfao,alfBL,alfaguarBL,alfaguar,m/timesave);
% 
% [urtiemp2,utittiemp2,urtiemp3,utittiemp3]=guardvelmerid(ur2,utit2,ur3,...
%     utit3,urtiemp2,utittiemp2,urtiemp3,utittiemp3,m/timesave);
tiempototal(m/timesave)=m*delttime;
ppp=[pwd ppath];
   save([ppp 'a.mat'],'ataco');
  save ([ppp 'alf.mat'],'alfaguar','alfaguarBL')
 save ([ppp 'velmerid.mat'],'urtiemp2','utittiemp2','urtiemp3','utittiemp3');
 save([ppp 'brtaco.mat'],'tiempototal','brtaco','brtaco2','brtaco3','brtaco4','brtaco5');
        save([ppp 'btittaco.mat'],'btittaco','btittaco2','btittaco3',...
            'btittaco4','btittaco5');
        save([ppp 'b.mat'],'btaco','btaco2','btaco3','btaco4','btaco5');
save([ppp 'ur.mat'],'urt1','urt2','urt3','urt4','urt5');
  save([ppp 'utit.mat'],'utitt1','utitt2','utitt3','utitt4','utitt5');

        
        save ([ppp 'todo.mat'])
             
 end

       end