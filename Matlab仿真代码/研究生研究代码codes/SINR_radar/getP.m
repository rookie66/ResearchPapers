%get the Precoding Matrix
% P=sqrt(L*P_R/M_tR)*I
function [P]=getP(P_R)
I=eye(4);
global L M_tR
P=sqrt(L*P_R/M_tR)*I;

%{
global G1 L M_tR
V=null(G1);
P=sqrt(L*P_R/M_tR)*V*conj(V');
%}
end