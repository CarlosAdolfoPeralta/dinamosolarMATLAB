function [btit]=guardab(btit,m,ntit)

% Guarda Btheta en cinco indices radiales del paso de muestreo actual.
global btittaco  btittaco2 btittaco3 btittaco4 btittaco5

for j=1:ntit;
btittaco(m,j)=btit(22,j);
btittaco2(m,j)=btit(23,j);
btittaco3(m,j)=btit(30,j);
btittaco4(m,j)=btit(40,j);
btittaco5(m,j)=btit(50,j);

end

