% compare with the transmit power of Radar £¬P_R
function [L_Tr_Phi]=getL_Tr_Phi(P_R)
P=getP(P_R);
Phi = getPhi(P);
global L
L_Tr_Phi=L*trace(Phi);
end
