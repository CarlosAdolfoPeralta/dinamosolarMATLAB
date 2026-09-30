function [ws,alfBL]=ws1alfaBL1(lamda,ur2,utit2,ur3,utit3,factalf,ws,delttime,omega)
% Evoluciona la vorticidad de retroalimentacion y calcula el alfa BL asociado.
% La rotacion y las perturbaciones del flujo aportan los terminos fuente.
global r tit nx ntit deltr deltit 

ws0=zeros(nx,ntit);
ws1=zeros(nx,ntit);
alfBL=zeros(nx,ntit);
k1=zeros(nx,ntit);
k2=zeros(nx,ntit);
k3=zeros(nx,ntit);
k4=zeros(nx,ntit);
q1=zeros(nx,ntit);
q2=zeros(nx,ntit);
q3=zeros(nx,ntit);
q4=zeros(nx,ntit);
dws1dtit=zeros(nx,ntit);
dws1dr=zeros(nx,ntit);
dws0dtit=zeros(nx,ntit);
dws0dr=zeros(nx,ntit);
dur0dtit=zeros(nx,ntit);
dur0dr=zeros(nx,ntit);
dutit0dtit=zeros(nx,ntit);
dutit0dr=zeros(nx,ntit);
dur1dtit=zeros(nx,ntit);
dur1dr=zeros(nx,ntit);
dutit1dtit=zeros(nx,ntit);
dutit1dr=zeros(nx,ntit);

ur0=ur2;
utit0=utit2;

ur1=ur3;
utit1=utit3;
ws1=ws;

for i=2:nx-1
for j=2:ntit-1
ws0(i,j)=sin(tit(j))*(sin(tit(j))*(omega(i,j+1)-omega(i,j-1))/(2*deltit)-r(i)*cos(tit(j))*(omega(i+1,j)-omega(i-1,j))/(2*deltr));
end
end

for i=2:nx-1
for j=2:ntit-1

dws1dtit(i,j)=(ws1(i,j+1)-ws1(i,j-1))/(2*deltit);
dws1dr(i,j)=(ws1(i+1,j)-ws1(i-1,j))/(2*deltr);
    
dws0dtit(i,j)=(ws0(i,j+1)-ws0(i,j-1))/(2*deltit);
dws0dr(i,j)=(ws0(i+1,j)-ws0(i-1,j))/(2*deltr);

dur1dtit(i,j)=(ur1(i,j+1)-ur1(i,j-1))/(2*deltit);
dur1dr(i,j)=(ur1(i+1,j)-ur1(i-1,j))/(2*deltr);
    
dur0dtit(i,j)=(ur0(i,j+1)-ur0(i,j-1))/(2*deltit);
dur0dr(i,j)=(ur0(i+1,j)-ur0(i-1,j))/(2*deltr);

dutit1dtit(i,j)=(utit1(i,j+1)-utit1(i,j-1))/(2*deltit);
dutit1dr(i,j)=(utit1(i+1,j)-utit1(i-1,j))/(2*deltr);
    
dutit0dtit(i,j)=(utit0(i,j+1)-utit0(i,j-1))/(2*deltit);
dutit0dr(i,j)=(utit0(i+1,j)-utit0(i-1,j))/(2*deltr);

end
end

for i=2:nx-1
for j=2:ntit-1
k1(i,j)=2*omega(i,j)*(cos(tit(j))*sin(tit(j))*dur1dr(i,j)+cos(tit(j))^2*dutit1dr(i,j)-sin(tit(j))^2/r(i)*dur1dtit(i,j)-ur1(i,j)/r(i)*sin(tit(j))*cos(tit(j))+utit1(i,j)/r(i)*sin(tit(j))^2-sin(tit(j))/r(i)*cos(tit(j))*dutit1dtit(i,j));

k2(i,j)=ws0(i,j)*(cos(tit(j))^2*dur1dr(i,j)-cos(tit(j))*sin(tit(j))*dutit1dr(i,j)-sin(tit(j))/r(i)*cos(tit(j))*dur1dtit(i,j)+sin(tit(j))^2/r(i)*ur1(i,j)+sin(tit(j))*cos(tit(j))/r(i)*utit1(i,j)+sin(tit(j))^2/r(i)*dutit1dtit(i,j));

k3(i,j)=(ur1(i,j)*sin(tit(j))+utit1(i,j)*cos(tit(j)))*(ws0(i,j)/(r(i)*sin(tit(j)))+sin(tit(j))*dws0dr(i,j)+cos(tit(j))/r(i)*dws0dtit(i,j));

k4(i,j)=(ur1(i,j)*cos(tit(j))-utit1(i,j)*sin(tit(j)))*(cos(tit(j))*dws0dr(i,j)-1/r(i)*sin(tit(j))*dws0dtit(i,j));

q1(i,j)=(ur0(i,j)*sin(tit(j))+utit0(i,j)*cos(tit(j)))*(sin(tit(j))*dws1dr(i,j)+1/r(i)*cos(tit(j))*dws1dtit(i,j)+ws1(i,j)/(r(i)*sin(tit(j))));

q2(i,j)=(ur0(i,j)*cos(tit(j))-utit0(i,j)*sin(tit(j)))*(cos(tit(j))*dws1dr(i,j)-sin(tit(j))/r(i)*dws1dtit(i,j));

q3(i,j)=ws1(i,j)*(cos(tit(j))^2*dur0dr(i,j)-cos(tit(j))*sin(tit(j))*dutit0dr(i,j)-sin(tit(j))/r(i)*cos(tit(j))*dur0dtit(i,j)+sin(tit(j))^2/r(i)*ur0(i,j)+sin(tit(j))*cos(tit(j))/r(i)*utit0(i,j)+sin(tit(j))^2/r(i)*dutit0dtit(i,j));

end
end

k=k1-k2-k3-k4;
q=-q1-q2-q3;


ws1=(k-q)*delttime+ws1;
ws=ws1;

for i=2:nx-1
for j=2:ntit-1
alfBL(i,j)=lamda^2/(24*r(i)*sin(tit(j)))*factalf*ws1(i,j);
end
end

%alfBL(nx-2,:)=alfBL(nx-3,:);
%alfBL(nx-1,:)=alfBL(nx-2,:);
%alfBL(nx,:)=alfBL(nx-1,:);

ws=suavixy2dbl(ws,nx,ntit);
alfBL=suavixy2dbl(alfBL,nx,ntit);

end