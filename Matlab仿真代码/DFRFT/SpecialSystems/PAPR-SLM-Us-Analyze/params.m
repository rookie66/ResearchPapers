% OFDM-LFMϵͳ�����в���-params
global n n_16 M k N L LN ofdmCodeNums Q U papr_base EbNos p Us
%��ͬ��Uֵ
Us = [2,4,6,8,10];
%�źű�������
n = 1024*16;   
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
U = 15; %��Ҫ����16
%������������Q
Q = 1j.^randi([1,4],LN,U);%һ����һ��
Q(:,1) = ones(LN,1);
%PAPR-CCDF������ͳ�ƻ�׼
papr_base = 4:0.2:11;
%�����
EbNos = -10:3:30;
%DFRFT�Ľ���
p = 0.5;