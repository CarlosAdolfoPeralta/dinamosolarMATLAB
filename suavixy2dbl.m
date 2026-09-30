function [var]=suavixy2dbl(var,nx,ntit)

% Filtra el campo alfa BL y completa el hemisferio sur segun su paridad.
%a1=zeros(nx,ntit, nphi);

a1(:,:)=var(:,:);
   FACSUU=0.45;
for I=2:nx-1
for J=2:ceil(ntit/2)-1
 var(I,J)=(1-FACSUU)^2*a1(I,J)+(1-FACSUU)*FACSUU*...
   (a1(I+1,J)+a1(I-1,J)+a1(I,J+1)+a1(I,J-1))/2+FACSUU^2*...
   (a1(I+1,J+1)+a1(I-1,J-1)+a1(I+1,J-1)+a1(I-1,J+1))/4;


var(I,16)=0;



end
end
for I=2:nx-1
for J=ceil(ntit/2)+1:ntit-1
var(I,J)=var(I,ntit-J+1)*sign(a1(30,3))*sign(a1(30,ntit-2));
end
end
end
