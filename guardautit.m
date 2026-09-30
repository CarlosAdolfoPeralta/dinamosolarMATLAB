function [utit1,utit2,utit3,utit4,utit5]=guardautit(utit,m,ntit,utit1,...
    utit2,utit3,utit4,utit5)

% Almacena cinco perfiles angulares de la componente theta de velocidad.

for j=1:ntit;
utit1(m,j)=utit(22,j);
utit2(m,j)=utit(23,j);
utit3(m,j)=utit(30,j);
utit4(m,j)=utit(40,j);
utit5(m,j)=utit(50,j);
end

