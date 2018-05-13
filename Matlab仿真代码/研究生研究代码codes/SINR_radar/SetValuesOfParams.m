% C_avg Test
global L_total L M_tR M_rR M_tC M_rC M K
% 信号长度
L_total=32;  L=8;
% 天线数目
M_tR=4;M_rR=4;M_tC=4;M_rC=4;M=4;K=3;
% 信号矩阵
global G1 G2 H
[G1,G2,H]=getG1andG2andH();

% 雷达信号和通信信号
global S X
[S,X]=getSandX(L_total,L,M);
% 
global sigma2_C sigma2_R
sigma2_C=0.01;
sigma2_R=0.01;
