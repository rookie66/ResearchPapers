% OFDM-LFMϵͳ�����в���-params
global n n_16 M k N L LN ofdmCodeNums Q Q1 U U1 papr_base EbNos p papr_th Am_th lambda
%�źű�������
n = 64*1024*4;  
% n = 256*16*4;  
%16QAM����֮�����Ԫ��Ŀ
n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
N = 256;
%��������over_samp
L = 1;  LN = L*N;
%�����yΪһ������������
ofdmCodeNums = n_16/N; %OFDM-LFM����Ԫ����
%SLM�㷨�ı�ѡ�ź�
U = 4; %��Ҫ����16
%������������Q
Q = 1j.^randi([1,4],LN,U);%һ����һ��
U1 = 4;
Q1 = 1j.^randi([1,4],LN,U1+1);%һ����һ��
Q1(:,1) = ones(LN,1);
%PAPR-CCDF������ͳ�ƻ�׼
papr_base = 3:0.3:13;
papr_th = 7;

%�����
EbNos = -10:3:30;
%DFRFT�Ľ���
p = 0.5;
%�޷����ķ�����ֵ(Clipping)
% Am_th = 70;
% �޷������޷���
lambda = 1.7;