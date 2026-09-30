function [scero] =Scero3(bphi,lamda,ur,utit,omega,br,btit)
% Calcula el cierre subgrid de la ecuacion toroidal en la malla esferica.
% Separa el aporte de omega del aporte asociado al flujo meridional.
global r tit nx ntit deltr deltit 

dutitdtit=zeros(nx,ntit);
durdtit=zeros(nx,ntit);
durdr=zeros(nx,ntit);
dutitdr=zeros(nx,ntit);
d2urd2r=zeros(nx,ntit);
d2utitd2t=zeros(nx,ntit);
d2urd2rt=zeros(nx,ntit);
d2utitd2rt=zeros(nx,ntit);

dbtitdtit=zeros(nx,ntit);
dbrdtit=zeros(nx,ntit);
dbrdr=zeros(nx,ntit);
dbtitdr=zeros(nx,ntit);

dbphidr=zeros(nx,ntit);
dbphidtit=zeros(nx,ntit);
d2bphid2r=zeros(nx,ntit);
d2bphid2t=zeros(nx,ntit);
d2bphid2rt=zeros(nx,ntit);

domegadtit=zeros(nx,ntit);
domegadr=zeros(nx,ntit);
d2omegad2r=zeros(nx,ntit);
d2omegad2t=zeros(nx,ntit);
d2omegad2rt=zeros(nx,ntit);


gr=zeros(nx,ntit);
gtit=zeros(nx,ntit);
grr=zeros(nx,ntit);
gtittit=zeros(nx,ntit);
grtit=zeros(nx,ntit);


sceroom=zeros(nx,ntit);
scerou=zeros(nx,ntit);
scero=zeros(nx,ntit);




for i=2:nx-1
  
for j=2:ntit-1
                 
    domegadtit(i,j)=(omega(i,j+1)-omega(i,j-1))/(2*deltit);
    domegadr(i,j)=(omega(i+1,j)-omega(i-1,j))/(2*deltr);
    d2omegad2r(i,j)= (omega(i+1,j)+omega(i-1,j)-2*omega(i,j))/deltr^2;
    d2omegad2t(i,j)= (omega(i,j+1)+omega(i,j-1)-2*omega(i,j))/deltit^2;
    d2omegad2rt(i,j)= (omega(i+1,j+1)+omega(i-1,j-1)-omega(i-1,j+1)-...
    omega(i+1,j-1))/(4*deltit*deltr);
          
    
    durdtit(i,j)=(ur(i,j+1)-ur(i,j-1))/(2*deltit);
    durdr(i,j)=(ur(i+1,j)-ur(i-1,j))/(2*deltr);
    d2urd2r(i,j)= (ur(i+1,j)+ur(i-1,j)-2*ur(i,j))/deltr^2;
    d2urd2rt(i,j)= (ur(i+1,j+1)+ur(i-1,j-1)-ur(i-1,j+1)-...
    ur(i+1,j-1))/(4*deltit*deltr);
    
    dutitdtit(i,j)=(utit(i,j+1)-utit(i,j-1))/(2*deltit);
    dutitdr(i,j)=(utit(i+1,j)-utit(i-1,j))/(2*deltr);
    d2utitd2t(i,j)= (utit(i,j+1)+utit(i,j-1)-2*utit(i,j))/deltit^2;
    d2utitd2rt(i,j)= (utit(i+1,j+1)+utit(i-1,j-1)-utit(i-1,j+1)-...
    utit(i+1,j-1))/(4*deltit*deltr);

    dbtitdtit(i,j)=(btit(i,j+1)-btit(i,j-1))/(2*deltit);
    dbrdtit(i,j)=(br(i,j+1)-br(i,j-1))/(2*deltit);
    dbtitdr(i,j)=(btit(i+1,j)-btit(i-1,j))/(2*deltr);
    dbrdr(i,j)=(br(i+1,j)-br(i-1,j))/(2*deltr);

    dbphidtit(i,j)=(bphi(i,j+1)-bphi(i,j-1))/(2*deltit);
    dbphidr(i,j)=(bphi(i+1,j)-bphi(i-1,j))/(2*deltr);
    d2bphid2r(i,j)= (bphi(i+1,j)+bphi(i-1,j)-2*bphi(i,j))/deltr^2;
    d2bphid2t(i,j)= (bphi(i,j+1)+bphi(i,j-1)-2*bphi(i,j))/deltit^2;
    d2bphid2rt(i,j)= (bphi(i+1,j+1)+bphi(i-1,j-1)-bphi(i-1,j+1)-bphi(i+1,j-1))...
             /(4*deltit*deltr);      

end
 
end




for i=1:nx
for j=2:ntit-1
          
  
aux1=(((lamda)^2)/(24*(r(i)^2)));
co=fix(cos(tit(j))*1000)/1000;
cs=fix(csc(tit(j))*1000)/1000;
sen=fix(sin(tit(j))*1000)/1000;
ct=fix(cot(tit(j))*1000)/1000;

fr(i,j)=3*co*domegadtit(i,j)+sen*(d2omegad2t(i,j)+r(i)*...
    domegadr(i,j)-2*r(i)^2*d2omegad2r(i,j));

ftit(i,j)=(3+cos(2*tit(j)))/2*cs*domegadtit(i,j)-r(i)*sen*d2omegad2rt(i,j)...
    -r(i)^2*co*d2omegad2r(i,j);

frtit(i,j)=r(i)^2*sen*d2omegad2rt(i,j);

ftitr(i,j)=r(i)*co*domegadr(i,j)+ r(i)*sen*d2omegad2rt(i,j)-sen*domegadtit(i,j);

ftittit(i,j)=co*domegadtit(i,j)+sen*d2omegad2t(i,j)-r(i)^2*sen*d2omegad2r(i,j);


sceroom(i,j)=aux1*(btit(i,j)*ftit(i,j) + br(i,j)*fr(i,j) + dbtitdr(i,j)*frtit(i,j) ...
    +ftitr(i,j)*dbrdtit(i,j)+ftittit(i,j)*dbtitdtit(i,j));


gr(i,j)=(ur(i,j)+utit(i,j)*ct+r(i)*durdr(i,j)+r(i)^2*d2urd2r(i,j)+...
    r(i)*d2utitd2rt(i,j))*dbphidr(i,j);

gtit(i,j)=(ur(i,j)*ct+utit(i,j)*cs^2+d2utitd2t(i,j)-r(i)*dutitdr(i,j)+...
    r(i)*d2urd2rt(i,j))/r(i)*dbphidtit(i,j);

grtit(i,j)=(-utit(i,j)+durdtit(i,j)+r(i)*dutitdr(i,j))*d2bphid2rt(i,j);
grr(i,j)=r(i)^2*durdr(i,j)*d2bphid2r(i,j);
gtittit(i,j)=(ur(i,j)+dutitdtit(i,j))/r(i)*d2bphid2t(i,j);


scerou(i,j)=-aux1*(gr(i,j)+gtit(i,j)+grtit(i,j)+grr(i,j)+gtittit(i,j));


scero(i,j)=sceroom(i,j)+scerou(i,j);


end
end

[scero]=suavixy2(scero,nx,ntit);
%Simetrizo para que sea antisimetrico

% for i=1:nx
% for j=2:5
% scero(i,ntit-j+1)=-scero(i,j);
% end
% end



end








