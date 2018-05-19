function [SINR_k]=getSINR_k(k,theta_k,P_R)
global  L 
P=getP(P_R);
Phi=getPhi(P);
D_k=getD_k(theta_k,k);
Sum=0;
l_ks=[8 18 22];
l_k=l_ks(k);
for l=l_k:l_k+L-1
    R_Rinl=getR_Rinl(l);
    Sum = Sum + trace(inv(R_Rinl)*D_k*Phi*D_k');
end
SINR_k=Sum/L;
end