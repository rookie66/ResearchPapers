% OFDM-LFMϵͳ�����в���-params
global n n_16 M k N L LN ofdmCodeNums Q Q1 U U1 papr_base EbNos p papr_th lambda
%�źű�������
n = 1024*4;  
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
Q(:,1) = ones(LN,1);
U1 = 8;
Q1 = 1j.^randi([1,4],LN,U1+1);%һ����һ��
if U1+1 == U
   Q1 = Q;%Q1��QӦ�ñ���һ�£������Ż���пɱ��ԡ�
else if U1+1 > U
     Q1(:,1:U) = Q;%��ǰU����ͬ
    else%U1+1<U
        Q1 = Q(:,1:U1);
    end
end
%PAPR-CCDF������ͳ�ƻ�׼
papr_base = 4:0.2:11;
papr_th = 7.2;

%�����
EbNos = -10:3:30;
%DFRFT�Ľ���
p = 0.5;
% �޷������޷���
lambda = 2.1;