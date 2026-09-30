
function [ro]=densidad(r,nx,rtope)

% Calcula el perfil radial de densidad usado para escalar el flujo meridional.
for i=1:nx
%x=r(i)/rtope;
%ro(i)=27372.75-123736.68*x+213347.65*x^2-165232.98*x^3+48256.18*x^4+10;
ro(i)=2.3*10^3*(1-r(i)/rtope)^2;
end
end