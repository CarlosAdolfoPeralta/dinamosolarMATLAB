function [var]=suavixy2(var,nx,ntit)

% Aplica un filtro local ponderado a los puntos interiores de la malla.
%a1=zeros(nx,ntit, nphi);

a1(:,:)=var(:,:);
   FACSUU=0.5;

for I=2:nx-1
for J=2:ntit-1

%
 %   var(I,J)=(aa(I,J)+(aa(I+1,J)+aa(I-1,J)+aa(I,J+1)+...
 %   aa(I,J-1))/4)/2;
    
var(I,J)=(1-FACSUU)^2*a1(I,J)+(1-FACSUU)*FACSUU*...
  (a1(I+1,J)+a1(I-1,J)+a1(I,J+1)+a1(I,J-1))/2+FACSUU^2*...
  (a1(I+1,J+1)+a1(I-1,J-1)+a1(I+1,J-1)+a1(I-1,J+1))/4;


end
end
end
