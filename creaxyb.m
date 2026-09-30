function [x y]= creaxyb

% Reconstruye las coordenadas esfericas y las proyecta al plano cartesiano x-y.
global  r tit nx ntit x y deltr deltit rcero



r=zeros([nx 1]);
tit=zeros([ntit 1]);
      
      
      
         
      r(1)=rcero;
      tit(1)=pi;

%***********CALCULO GRILLAfor
      
      for i=2:nx
      r(i)=r(i-1)+deltr;
      end
      
      for j=2:ntit
      tit(j)=tit(j-1)- deltit;
      end


x=zeros(nx,ntit);
y=zeros(nx,ntit);

for i=1:nx
    for j=1:ntit
        x(i,j)=r(i)*sin(tit(j));
        y(i,j)=r(i)*cos(tit(j));
    end
end
