function [R_Ci] = getR_Ci(P_R)
global G1
P=getP(P_R);
Phi=getPhi(P);
R_Ci=G1*Phi*G1';
end
