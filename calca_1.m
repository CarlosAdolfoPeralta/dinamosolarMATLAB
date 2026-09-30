


function [a, aprim ,br,btit ]=calca(a,ntit,nx,deltr...
,deltit,r,tit,ur,utit,eta,delttime,br,btit,b,alfa,aprim,m,graf...
,rtope,omega,lamda,ppath,dibu)

% Calcula la evolucion del potencial poloidal y sus componentes Br y Btheta.
% Combina transporte, difusion, cierre subgrid y la fuente alfa por B.
global brtaco brtaco2 brtaco3 brtaco4 brtaco5 timesave
global btittaco  btittaco2 btittaco3 btittaco4 btittaco5

rt=0.72*rtope;
aprimer=zeros(nx,ntit);
asegundo=zeros(nx,ntit);
atercer=zeros(nx,ntit);
acuarto=zeros(nx,ntit);
aquinto=zeros(nx,ntit);

%%%%%%%%%Condiciones de borde


%cond en tita
a(:,1)=0;
a(:,floor(ntit))=0;

% cond en r
a(1,:)=0;
%la cond de borde superior de r esta en aprim


%*************Br y Btits*********
  
      for i=2:nx-1
      for j=2:ntit-1
          if (r(i)>rt)
           dadr=(a(i+1,j)-a(i-1,j))/(2*deltr);
           dadtit=(a(i,j+1)-a(i,j-1))/(2*deltit);
      
      
           btit(i,j)=(-1./r(i))*a(i,j)-dadr;
           br(i,j)=(1/r(i))*dadtit+(cot(tit(j))/r(i))*a(i,j);
          end
      end
      end
      
             % write(10,*)'ahora calculo'
      
      
      for i=2:nx-1
      for j=2:ntit-1
%**Primer termino

          if (r(i)>rt)
      au1=ur(i,j)*btit(i,j)-utit(i,j)*br(i,j);
aprimer(i,j)=au1;

          
          

%**Segunfor termino

      dadr=(a(i+1,j)-a(i-1,j))/(2*deltr);
      dadtit=(a(i,j+1)-a(i,j-1))/(r(i)*2*deltit);
      d2adr2=(a(i+1,j)-2*a(i,j)+a(i-1,j))/(deltr^2);
      d2adtit2=(a(i,j+1)-2*a(i,j)+a(i,j-1))/(deltit^2);
      
      au21=1/r(i);
      au22=1/(sin(tit(j)));


      au2=d2adr2+2*au21*dadr+(au21^2)*d2adtit2+...
     (au21^2)*au22*cos(tit(j))*dadtit-...
      ((au21*au22)^2)*a(i,j);
      
      au2=au2*eta(i,j);
      asegundo(i,j)=au2;
          end
%**Tercer termino
      durdr=(ur(i+1,j)-ur(i-1,j))/(2*deltr);
      durdtit=(ur(i,j+1)-ur(i,j-1))/(r(i)*2*deltit);

      dutitdr=(utit(i+1,j)-utit(i-1,j))/(2*deltr);
      dutitdtit=(utit(i,j+1)-utit(i,j-1))/(r(i)*2*deltit);


      dbrdr=(br(i+1,j)-br(i-1,j))/(2*deltr);
      dbrdtit=(br(i,j+1)-br(i,j-1))/(r(i)*2*deltit);

      dbtitdr=(btit(i+1,j)-btit(i-1,j))/(2*deltr);
      dbtitdtit=(btit(i,j+1)-btit(i,j-1))/(r(i)*2*deltit);


      
      au31= durdr*dbtitdr+durdtit*dbtitdtit;
      au32=dutitdr*dbrdr+dutitdtit*dbrdtit;
      au33=(ur(i,j)+dutitdtit*r(i))*btit(i,j)/(r(i)^2);
      au34=durdtit*br(i,j)/r(i);
      au35=dbrdtit*ur(i,j)/r(i);
      au36=(br(i,j)+r(i)*dbtitdtit)*utit(i,j)/(r(i)^2);
     
%     lamda=0;%%%sin subgrilla
      au3=(au31-au32+au33+au34-au35-au36)*(lamda^2/24);
      atercer(i,j)=au3;
%       atercer(i,j)=0;
      %*****Cuarto termino
      
      au4=alfa(i,j)*b(i,j);
      
      acuarto(i,j)=au4;
  

      end
      end
  %atercer(nx-1,:)=atercer(nx-2,:);
%[atercer]=suavixy(atercer,nx,ntit);
 for v=1:10
 
 [atercer]=laplaciano(atercer,lamda);
 end
      
      for i=2:nx-1
      for j=2:ntit-1
  
   aprim(i,j)=aprimer(i,j)+asegundo(i,j)+...
       atercer(i,j)+acuarto(i,j)+aquinto(i,j);
   
if (i == nx-1)
[aprimer atercer acuarto]= calcanx(a,ntit,nx,deltr,deltit...
,r,tit,ur,utit,eta,delttime,br,btit,b, alfa,aprimer,atercer,acuarto,...
lamda);


aprim(nx,j)=aprimer(nx,j)+atercer(nx,j)+acuarto(nx,j)...
    +aquinto(nx,j);
      end
      end
      end
     
      
    
if (m>1)
    if (mod(m,timesave)==0)
            [br]=guardaa(br,m/timesave,ntit);
            [btit]=guardab(btit,m/timesave,ntit);
    end
    
    else 
            brtaco(1,:)=0;
            brtaco2(1,:)=0;
            btittaco(1,:)=0;
            btittaco2(1,:)=0;
            btittaco3(1,:)=0;
            btittaco4(1,:)=0;
            btittaco5(1,:)=0;
            brtaco3(1,:)=0;
            brtaco4(1,:)=0;
            brtaco5(1,:)=0;
    end

   
      for i=1:nx
      for j=1:ntit
      psi(i,j)=a(i,j)*r(i)*sin(tit(j));
      end
      end            
            
       
           %%%Grafico potencial vector
name={'Líneas de campo magnético', ...
      'Derivada temporal del potencial vector', ...
      'Término convectivo', ...
      'Término disipativo', ...
      'Término de dínamo', ...
      'Difusividad magnética'};
% %            
% %            
if((mod(m,dibu)==0) && (graf==1))
     
 graficoa(psi,aprim,aprimer,asegundo,acuarto,eta,name)
% % 
arch=[pwd ppath 'a_t_' num2str(m) '.png'];
exportgraphics(gcf,arch,'Resolution',900);
close all
end
end