function [ur1,ur2,ur3,ur4,ur5]=guardaur(ur,m,ntit,ur1,ur2,ur3,ur4,ur5)

% Almacena cinco perfiles angulares de la componente radial de velocidad.

for j=1:ntit;
ur1(m,j)=ur(22,j);
ur2(m,j)=ur(23,j);
ur3(m,j)=ur(30,j);
ur4(m,j)=ur(40,j);
ur5(m,j)=ur(50,j);
end



