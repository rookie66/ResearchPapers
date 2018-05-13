%%定义变量
clear all;clc ;format compact
% 定义天线的数目
M_tR=4;M_rR=4;M_tC=4;M_rC=4;
L=8;L_PRI=32;
%噪声方法都是0.01
Sigma2_C=0.01;Sigma2_R=0.01;
angle1=-60;angle2=0;angle3=60;
delays1=6;delays=18;delays3=22;
C=24;%C=24bits/symbol
P_C=L_PRI*M_tC;
%定义信道(G1、G2为干扰信道，功率为0.01，H为通信信道,功率为1）
G1=wgn(4,4,0.01);
G2=wgn(4,4,0.01);
H=wgn(4,4,1);
%参数定义结束

%就是计算SINR

G1,G2,H


