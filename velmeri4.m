function [ur utit]=velmeri4(rtope,rcero,rp,nx,ntit,r,tit,sigma,ro)  
%%vel merid con estratificacion
% Construye el flujo meridional impuesto para radios mayores que rp.
% La densidad local y sigma controlan su amplitud.

ur=zeros(nx,ntit);
utit=zeros(nx,ntit);

 
for i=1:nx
    if (r(i)> rp)
for j=1:ntit

 ur(i,j)=(sigma/(r(i)*ro(i)))*(rtope-r(i))*(r(i)-rp)*...
     (3*(cos(tit(j)))^2-1);
 
 utit(i,j)=(1/ro(i))*sigma*(sin(tit(j)))^3*cos(tit(j))...
     *(r(i)-(rtope+rp)/2);

end
    end
end

end
