function [var]=suavixy(var,nx,ntit)

% Suaviza el campo y conserva su paridad ecuatorial al reflejar la malla.


a1(:,:)=var(:,:);
   FACSUU=0.27;


if sign(a1(30,3))*sign(a1(30,ntit-2))==-1
for I=1:nx
var(I,ceil(ntit/2))=0;
end
else
for I=1:nx
var(I,ceil(ntit/2))=(var(I,ceil(ntit/2)+1)+var(I,ceil(ntit/2)-1))/2;
end
end

for I=2:nx-1
for J=2:ceil(ntit/2)-1

%
%    var(I,J)=(aa(I,J)+(aa(I+1,J)+aa(I-1,J)+aa(I,J+1)+...
%    aa(I,J-1))/4)/2;
    
 var(I,J)=(1-FACSUU)^2*a1(I,J)+(1-FACSUU)*FACSUU*...
   (a1(I+1,J)+a1(I-1,J)+a1(I,J+1)+a1(I,J-1))/2+FACSUU^2*...
   (a1(I+1,J+1)+a1(I-1,J-1)+a1(I+1,J-1)+a1(I-1,J+1))/4;





end
end
for I=2:nx-1
for J=ceil(ntit/2)+1:ntit-1
var(I,J)=var(I,ntit-J+1)*sign(a1(30,3))*sign(a1(30,ntit-2));
end
end

if sign(a1(30,3))*sign(a1(30,ntit-2))==-1
for I=1:nx
var(I,ceil(ntit/2))=0;
end
else
var(I,ceil(ntit/2))=(var(I,ceil(ntit/2)+1)+var(I,ceil(ntit/2)-1))/2;
end

end
