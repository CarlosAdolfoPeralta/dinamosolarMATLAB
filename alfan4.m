function [alfa] =alfan4(lamda,r,tit,ur,utit,omega,nx,ntit,deltr,...
    deltit,rtope,factalf)

% Calcula el coeficiente alfa cinematico a partir de los gradientes de omega.
% La amplitud se escala con lamda y factalf; los bordes quedan en cero.
alfa=zeros(nx,ntit);
aux1=zeros(nx,ntit);
aux2=zeros(nx,ntit);
%aux3=zeros(nx,ntit);


for i=2:nx-1
for j=2:ntit-1

    domegadtit=(omega(i,j+1)-omega(i,j-1))/(2*deltit);
    domegadr=(omega(i+1,j)-omega(i-1,j))/(2*deltr);
    
    
    
aux1(i,j)=((lamda)^2)/(24*(r(i)))*factalf;

aux2(i,j)=sin(tit(j))*domegadtit-r(i)*cos(tit(j))*domegadr;

alfa(i,j)=aux1(i,j)*aux2(i,j);
end    
end

    




end
