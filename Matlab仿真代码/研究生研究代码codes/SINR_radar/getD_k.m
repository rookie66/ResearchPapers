% ªÒ»°D_k
function [D_k]=getD_k(theta_k,k)
[Vr_theta,Vt_theta]=getVrandVt(theta_k);
sigemas=[0.1 0.11 0.12 0.13];
D_k=sigemas(k)*Vr_theta*conj(Vt_theta');
end