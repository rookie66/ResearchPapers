%%�������
clear all;clc ;format compact
% �������ߵ���Ŀ
M_tR=4;M_rR=4;M_tC=4;M_rC=4;
L=8;L_PRI=32;
%������������0.01
Sigma2_C=0.01;Sigma2_R=0.01;
angle1=-60;angle2=0;angle3=60;
delays1=6;delays=18;delays3=22;
C=24;%C=24bits/symbol
P_C=L_PRI*M_tC;
%�����ŵ�(G1��G2Ϊ�����ŵ�������Ϊ0.01��HΪͨ���ŵ�,����Ϊ1��
G1=wgn(4,4,0.01);
G2=wgn(4,4,0.01);
H=wgn(4,4,1);
%�����������

%���Ǽ���SINR

G1,G2,H


