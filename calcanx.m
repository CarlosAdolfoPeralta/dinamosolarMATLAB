function [aprimer atercer acuarto]=calcanx(a,ntit,nx,deltr,deltit...
,r,tit,ur,utit,eta,delttime,br,btit,b, alfa,aprimer,atercer,acuarto,...
lamda);
% Evalua en el borde radial externo los terminos que requieren derivadas.
% Usa diferencias unilaterales para no consultar puntos fuera de la malla.
i=nx;
for j=2:ntit-1;
    
        

%**Primer termino
      au1=ur(i,j)*btit(i,j)-utit(i,j)*br(i,j);
aprimer(i,j)=au1;



%**Tercer termino
      durdr=(ur(i,j)-ur(i-1,j))/(deltr);
      durdtit=(ur(i,j+1)-ur(i,j-1))/(r(i)*2*deltit);

      dutitdr=(utit(i,j)-utit(i-1,j))/(deltr);
      dutitdtit=(utit(i,j+1)-utit(i,j-1))/(r(i)*2*deltit);


      dbrdr=(br(i,j)-br(i-1,j))/(deltr);
      dbrdtit=(br(i,j+1)-br(i,j-1))/(r(i)*2*deltit);

      dbtitdr=(btit(i,j)-btit(i-1,j))/(deltr);
      dbtitdtit=(btit(i,j+1)-btit(i,j-1))/(r(i)*2*deltit);


      
      au31= durdr*dbtitdr+durdtit*dbtitdtit;
      au32=dutitdr*dbrdr+dutitdtit*dbrdtit;
      au33=(ur(i,j)+dutitdtit*r(i))*btit(i,j)/(r(i)^2);
      au34=durdtit*br(i,j)/r(i);
      au35=dbrdtit*ur(i,j)/r(i);
      au36=(br(i,j)+r(i)*dbtitdtit)*utit(i,j)/(r(i)^2);
      
      au3=2*(au31-au32+au33+au34-au35-au36);
      atercer(i,j)=au3;
      
      %*****Cuarto termino
      
      au4=alfa(i,j)*b(i,j);
      
      acuarto(i,j)=au4;
    
end
end
