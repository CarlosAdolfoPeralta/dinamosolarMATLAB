function [b , bprim]=calcb4(b,ntit,nx,deltr,deltit,r,tit,...
ur,utit,etat,delttime,br,btit,a,omega,bprim,m,graf,lamda,ppath,dibu)

% Calcula la derivada temporal del campo toroidal Bphi.
% Incluye transporte, difusion, cizalladura por omega y el cierre Scero3.


bprimer=zeros(nx,ntit);
bsegundo=zeros(nx,ntit);
btercer=zeros(nx,ntit);
bcuarto=zeros(nx,ntit);
scero=zeros(nx,ntit);



%%%%%%%%%Condiciones de borde


%cond en tita
b(:,1)=0;
b(:,ntit)=0;

% cond en r
b(1,:)=0;
b(nx,:)=0;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      for i=2:nx-1
      for j=2:ntit-1
          
          %Primer termino
          
          durdr=(ur(i+1,j)-ur(i-1,j))/(2*deltr);
          dutitdtit=(utit(i,j+1)-utit(i,j-1))/(2*deltit);
                 
          dbdr=(b(i+1,j)-b(i-1,j))/(2*deltr);
          dbdtit=(b(i,j+1)-b(i,j-1))/(2*deltit);
         
                 
    bprimer(i,j)=-(1/r(i))*(ur(i,j)*b(i,j)+r(i)*durdr*b(i,j)+...
              r(i)*ur(i,j)*dbdr+dutitdtit*b(i,j)+utit(i,j)*dbdtit);
          
          
          %segundo termino
          
          d2bdr2=(b(i+1,j)-2*b(i,j)+b(i-1,j))/(deltr^2);
          d2bdtit2=(b(i,j+1)-2*b(i,j)+b(i,j-1))/(deltit^2);
          
    bsegundo(i,j)=(2*dbdr/r(i)+d2bdr2+cot(tit(j))*dbdtit/(r(i)^2)+...
            d2bdtit2/(r(i)^2)-b(i,j)/(r(i)^2*(sin(tit(j))^2)))*etat(i,j);
          
          
         
          %Tercer termino
          dadtit=(a(i,j+1)-a(i,j-1))/(2*deltit);
          dadr=(a(i+1,j)-a(i-1,j))/(2*deltr);
          
          %prueba 
         % domegadr=0;
          domegadr=(omega(i+1,j)-omega(i-1,j))/(2*deltr);
          domegadtit=(omega(i,j+1)-omega(i,j-1))/(2*deltit);
          
    btercer(i,j)=(cos(tit(j))*a(i,j)+sin(tit(j))*dadtit)*domegadr+...
              (-r(i)*dadr-a(i,j))*(sin(tit(j))/r(i))*domegadtit;
      
          %Cuarto termino
          
          detadr=(etat(i+1,j)-etat(i-1,j))/(2*deltr);
          dbdr=(b(i+1,j)-b(i-1,j))/(2*deltr);
          detadtit=(etat(i,j+1)-etat(i,j-1))/(2*deltit);
          
    bcuarto(i,j)=1/r(i)*detadr*b(i,j)+detadr*dbdr+detadtit/r(i)^2*(dbdtit+b(i,j)*cot(tit(j)));
          
       end
      end
        
          
                   
    
      
%         %%%%Nuevo subgrilla
        if (m>1)
%       
       [scero] = Scero3(b,lamda,ur,utit,omega,br,btit);
       

        end
% 

     %Bprima
      
      for i=2:nx-1
      for j=2:ntit-1
           bprim(i,j)=bprimer(i,j)+bsegundo(i,j)+btercer(i,j)+...
               bcuarto(i,j)+ scero(i,j);
      
      end
      end
      
      
   

%%%%Grafico algunos terminos!!!!!!!!!

        if((mod(m,dibu)==0) && (graf==1))
       name={'Campo magnético toroidal', ...
             'Derivada temporal del campo magnético toroidal', ...
             'Término disipativo', ...
             '$(\nabla \times \mathbf{A}) \cdot \Omega$', ...
             '$\nabla \times (\eta \, \nabla \times \mathbf{B})$', ...
             'Término de subgrilla'};
       grafico(b,bprim,bsegundo,btercer,bcuarto,scero,name)
arch=[pwd ppath 'b2_t_' num2str(m) '.png'];
             exportgraphics(gcf,arch,'Resolution',900);
%        name={'B' ,'bprim','convec','disip','rotA.omeg','detadr'};
%  grafico(b,bprim,bprimer,bsegundo,btercer,bcuarto,name)          
% arch=[pwd ppath 'b_t_' num2str(m) '.png'];
%              saveas(gcf,arch ,'png');

        
        close all
        end

end

          
          
          
          
          
          
          
          
          
          
          
          
          