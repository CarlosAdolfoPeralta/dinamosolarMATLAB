function [ur2 utit2]=leap2(r,tit,nx,ntit,rtope,mu0,omega0,b,br,btit,deltr,...
    deltit,ro)

% Calcula el flujo meridional inducido por la fuerza magnetica.
% Obtiene una funcion de corriente, aplica simetria y deriva las velocidades.


%%% NUEVO GRILLADO
fi=zeros(nx,ntit);
fi2=zeros(nx,ntit);
ur=zeros(nx,ntit);
utit=zeros(nx,ntit);
ur2=zeros(nx,ntit);
utit2=zeros(nx,ntit);


 
    %if (r(i)<=0.90*rtope)
for j=15:-1:2
for i=2:nx-1
cte=2*mu0*omega0(5,5);
dbdr=(b(i+1,j)-b(i-1,j))/(2*deltr);
dbdtit=(b(i,j+1)-b(i,j-1))/(2*deltit);


C(i,j)=(r(i)/cte)*(btit(i,j)*(b(i,j)*cos(tit(j))+sin(tit(j))*dbdtit)...
    +br(i,j)*(b(i,j)*sin(tit(j))+r(i)*sin(tit(j))*dbdr));
A(i,j)=-r(i)*cos(tit(j));
B(i,j)=sin(tit(j));
end
end
% Integra la funcion de corriente en la mitad norte de la malla.
for j=15:-1:2
for i=2:nx-1
fi(i,j)=(A(i,j)*fi(i-1,j)/deltr+B(i,j)*fi(i,j-1)/deltit+C(i,j))/(A(i,j)/deltr+B(i,j)/deltit);
end
end


fi(:,16)=0;
% Completa la mitad sur con la simetria respecto del ecuador.
for i=1:nx

for j=17:ntit-1


fi(i,j)=-fi(i,ntit-j+1);

end
end


% fi(nx,:)=fi(nx-1,:);
% fi(1,:)=fi(2,:);
% fi(:,1)=fi(:,2);
% fi(:,ntit)=fi(:,ntit-1);

[fi]=suavixy2d(fi,nx,ntit);

% Convierte la funcion de corriente en velocidades y las escala por densidad.
for i=2:nx-1
for j=2:ntit-1
dfidr=(fi(i+1,j)-fi(i-1,j))/(2*deltr);
dfidtit=(fi(i,j+1)-fi(i,j-1))/(2*deltit);
    ur(i,j)=(1/r(i))*(cot(tit(j))*fi(i,j)+dfidtit);
    utit(i,j)=-(1/r(i))*(fi(i,j)+r(i)*dfidr);
    
    ur2(i,j)=1/(r(i)^2*sin(tit(j))*ro(i))*dfidtit;
    utit2(i,j)=-1/(r(i)*sin(tit(j))*ro(i))*dfidr;
    
end
end

[ur2]=suavixy(ur2,nx,ntit);
[utit2]=suavixy(utit2,nx,ntit);

end

