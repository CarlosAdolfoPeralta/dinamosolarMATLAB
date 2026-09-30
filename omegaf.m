
 function [omega]=omegaf(r,rtope , nx, tit,ntit)
  % Construye la rotacion diferencial con una transicion radial suavizada.
  global n
  alfa2=-62.69*pi*2E-9;
  alfa4=-67.15*pi*2E-9;
 
  omegaEQ=n*460.7*pi*2E-9;
  omegaRZ=n*432.8*pi*2E-9;
  dt=0.05*rtope;%%%Forma original 0.05*rtope
  rt=0.7*rtope;
  
  omega=zeros(nx,ntit);
  
  
  for j=1:ntit
  omegaSCZ= omegaEQ+alfa2*(cos(tit(j)))^2+alfa4*(cos(tit(j)))^4;
  
  for i=1:nx
      omega(i,j)=omegaRZ+0.5*(1+erf(2*((r(i)-rt)/dt)))*(omegaSCZ-omegaRZ);
  
  end
  end
omega=n*omega;
 end
  
