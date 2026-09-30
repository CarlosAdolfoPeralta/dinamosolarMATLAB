function [br]= guardaa(br,m,ntit)
% Guarda Br en cinco indices radiales para construir historiales temporales.
global brtaco brtaco2 brtaco3 brtaco4 brtaco5 


for j=1:ntit;
brtaco(m,j)=br(25,j);
brtaco2(m,j)=br(26,j);
brtaco3(m,j)=br(30,j);
brtaco4(m,j)=br(40,j);
brtaco5(m,j)=br(50,j);
end

