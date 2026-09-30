function [var]=suavixy2d(var,nx,ntit)

% Suaviza el hemisferio norte y refleja el resultado con paridad ecuatorial.
%a1=zeros(nx,ntit, nphi);

aa(:,:)=var(:,:);
   FACSUU=0.25;
for I=2:nx-1
for J=2:ceil(ntit/2)-1

    
    var(I,J)=(aa(I,J)+aa(I+1,J-1)+aa(I+1,J)+aa(I+1,J+1)+...
                      aa(I,J-1)+aa(I,J)+aa(I,J+1)...
                     +aa(I-1,J-1)+aa(I-1,J)+aa(I-1,J+1))/10;

var(I,16)=0;



end
end
for I=2:nx-1
for J=ceil(ntit/2)+1:ntit-1
var(I,J)=var(I,ntit-J+1)*sign(aa(30,3))*sign(aa(30,ntit-2));
end
end
end

