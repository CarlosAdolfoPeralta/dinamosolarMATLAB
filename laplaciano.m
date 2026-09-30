function    [atercer]=laplaciano(atercer,lamda)
% Regulariza el termino subgrid con un laplaciano esferico discreto.
% El stencil se calcula lejos de los bordes para disponer de vecinos validos.
    global nx ntit deltr deltit r tit

sosuav=zeros(nx,ntit);


for j=4:ntit-3
for i=4:nx-3
d2sodr2=(atercer(i+1,j)-2*atercer(i,j)+atercer(i-1,j))/deltr^2;
dsodr=(atercer(i+1,j)-atercer(i-1,j))/(2*deltr);
dsodtit=(atercer(i,j+1)-atercer(i,j-1))/(2*deltit);
d2sodtit2=(atercer(i,j+1)-2*atercer(i,j)+atercer(i,j-1))/deltit^2;



sosuav(i,j)=d2sodr2+(2/r(i))*dsodr+(1/r(i)^2)*d2sodtit2+...
    (cos(tit(j))/(sin(tit(j))*r(i)^2))*dsodtit;
end
end

atercer(:,:)=atercer(:,:)+ sosuav(:,:)*lamda^2/24*10^(-1);


end

