% OFDM-LFMϵͳ�����в���-params
global n n_16 M k  L LN ofdmCodeNums papr_base EbNos p 
% global Ns 
%�źű�������
n = 64*1024*4;  
%16QAM����֮�����Ԫ��Ŀ
n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
% %�ز�����
% N = 256;
% Ns = [32,64,128,256];
%��������over_samp
L = 1;  LN = L*N;
%�����yΪһ������������
ofdmCodeNums = n_16/N; %OFDM-LFM����Ԫ����
%PAPR-CCDF������ͳ�ƻ�׼
papr_base = 5:0.3:13;
%�����
EbNos = -10:1:30;
%DFRFT�Ľ���
p = 0.5;