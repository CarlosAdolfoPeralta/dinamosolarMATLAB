function [btaco,btaco2,btaco3,btaco4,btaco5]=guardbb(b,m,ntit,btaco,...
    btaco2,btaco3,btaco4,btaco5)

% Guarda Bphi en cinco indices radiales para seguir su evolucion temporal.

for j=1:ntit;
btaco(m,j)=b(22,j);
btaco2(m,j)=b(23,j);
btaco3(m,j)=b(30,j);
btaco4(m,j)=b(40,j);
btaco5(m,j)=b(50,j);
end

