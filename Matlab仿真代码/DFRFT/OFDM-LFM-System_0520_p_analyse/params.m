% OFDM-LFMϵͳ�����в���-params

global n n_16 M k N L LN U ofdmCodeNums Q papr_base EbNos p

%�źű�������
%n = 64*1024*128*16;  
n = 64*16*256;  
%16QAM����֮�����Ԫ��Ŀ
n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
%N = 256;
N = 16;
%��������over_samp
L = 1;  LN = L*N;
%SLM�㷨�ı�ѡ�ź�
U = 4; %��Ҫ����16
%�����yΪһ������������
ofdmCodeNums = n_16/N; %OFDM-LFM����Ԫ����
%������������Q
Q = 1j.^randi([1,4],LN,U);%һ����һ��
%PAPR-CCDF������ͳ�ƻ�׼
papr_base = 5:0.3:13;
%�����
EbNos = -10:3:30;
%DFRFT�Ľ���
p = 0.5;
