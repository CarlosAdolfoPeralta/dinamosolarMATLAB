function [etauv]=etauv4(nx,ntit,ur,utit,r,tit,cs,deltr,deltit,omega,br,btit,b,ro)

% Estima la difusividad turbulenta local con el flujo, omega y el campo.
% Las diferencias angulares se orientan hacia el ecuador en cada hemisferio.
etauv=zeros(nx,ntit);
dutitdr=zeros(nx,ntit);
dutitdtit=zeros(nx,ntit);
durdr=zeros(nx,ntit);
durdtit=zeros(nx,ntit);
domegadr=zeros(nx,ntit);
domegadtit=zeros(nx,ntit);


mu0=4*pi*10^(-7);
for i=1:nx
for j=1:ntit
b2(i,j)=b(i,j)/(mu0*ro(i))^(1/2);
br2(i,j)=b(i,j)/(mu0*ro(i))^(1/2);
btit2(i,j)=b(i,j)/(mu0*ro(i))^(1/2);
end
end

for i=2:nx-1
for j=2:ntit-1
dbdtit(i,j)=(b2(i,j+1)-b2(i,j-1))/(2*deltit);
dbdr(i,j)=(b2(i+1,j)-b2(i-1,j))/(2*deltr);
dbrdtit(i,j)=(br2(i,j+1)-br2(i,j-1))/(2*deltit);
dbtitdr(i,j)=(btit2(i+1,j)-btit2(i-1,j))/(2*deltr);
end
end

for i=2:nx-1
for j=2:ntit-1
val2(i,j)=((1/(r(i)*sin(tit(j)))*(cos(tit(j))*b(i,j)+sin(tit(j))*dbdtit(i,j)))^2+...
(1/r(i)*(b(i,j)+r(i)*dbdr(i,j)))^2+...
(1/r(i)*(btit(i,j)+r(i)*dbtitdr(i,j)-dbrdtit(i,j)))^2)*5/7;
end
end



for i=2:nx-1
      
    for j=ceil(ntit/2):-1:2
       durdr(i,j)=(ur(i+1,j)-ur(i-1,j))/(2*deltr);
       durdtit(i,j)=(ur(i,j)-ur(i,j-1))/(r(i)*2*deltit);

      dutitdr(i,j)=(utit(i+1,j)-utit(i-1,j))/(2*deltr);
      dutitdtit(i,j)=(utit(i,j)-utit(i,j-1))/(r(i)*2*deltit);
      
      domegadr(i,j)=(omega(i+1,j)-omega(i,j))/deltr;
      domegadtit(i,j)=(omega(i,j)-omega(i,j-1))/deltit;
      
      end
    for j=ceil(ntit/2):ntit-1
       durdr(i,j)=(ur(i+1,j)-ur(i-1,j))/(2*deltr);
       durdtit(i,j)=(ur(i,j)-ur(i,j+1))/(r(i)*2*deltit);

      dutitdr(i,j)=(utit(i+1,j)-utit(i-1,j))/(2*deltr);
      dutitdtit(i,j)=(utit(i,j)-utit(i,j+1))/(r(i)*2*deltit);
      
      domegadr(i,j)=(omega(i+1,j)-omega(i,j))/deltr;
      domegadtit(i,j)=(omega(i,j)-omega(i,j+1))/deltit;
      
    
    end
    for j=2:ntit-1
       
val=2*durdr(i,j)^2+2*((1/r(i))*dutitdtit(i,j)+ur(i,j)/r(i))^2+...
    (durdtit(i,j)/r(i)+dutitdr(i,j)-utit(i,j)/r(i))^2+...
    2*(ur(i,j)/r(i)+utit(i,j)*cot(tit(j))/r(i))^2+...
    (sin(tit(j))*domegadtit(i,j))^2+(r(i)*sin(tit(j))*domegadr(i,j))^2;
etauv(i,j)=(cs^2)*deltr*r(i)*deltit*sqrt(val+val2(i,j));
        end
    end

end



