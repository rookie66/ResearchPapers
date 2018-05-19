% �ó����ܸĽ���(Deprecated)
%     ��QAM_2_OFDM_PAPR.m������,����˹���������
%     �����������޸���
%     SLM�㷨���ô��벢���Ƿ���SLM�㷨
%     SLM�㷨Ӧ���ǶԸ����Ŷ�����ɸѡ���Ӷ�ѡ���PAPR��͵��Ǹ���
%     �Ľ����㷨��QAM_2_OFDM_PAPR_SLM.m
close all;clear;clc
%�źű�������n
n = 1024*128*16;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
N = 512;
%��������over_samp
L = 1; LN = L*N;
%SLM�㷨�ı�ѡ�ź�
U = 10;
%������������Ʊ�����(��������
x = randi([0 1],1,n); 
%ת������ά�ȣ�ÿk��bitһ��
x_4 = reshape(x,length(x)/k,k);
%���16����
x_16 = bi2de(x_4,'right-msb');%right-msb������ʾ��һ��Ϊ���λ��
%��16QAM���������źŽ��е���
y = modulate(modem.qammod(M),x_16);
%�����yΪһ����������
colums_num = length(y)/N;
%���䲢
y_para = reshape(y,N,colums_num);
%������������Q
Q = 1j.^randi([1,4],U,N);
%PAPR��CCDF�ڵ�
papr_baseS = 5:0.5:15;
%�����
EbNos = -10:1:30;
%�������SLM�㷨����PAPR
percent_papr_SLM = zeros(U,length(papr_baseS));
bers_SLM = zeros(U,length(EbNos));
for u = 1:U
   [percent_papr,ber] = Func_PAPR_SLM_old(y_para,Q(u,:),N,L,M,n,colums_num,papr_baseS,EbNos,x);
   percent_papr_SLM(u,:) = percent_papr;
   bers_SLM(u,:) = ber;
end
%-----������PAPR�����㷨�ĵ�PAPR����------
[percent_papr_ofdm,ber_ofdm] = Func_PAPR_SLM_old(y_para,ones(1,N),N,L,M,n,colums_num,papr_baseS,EbNos,x);
%------��PAPRͼ����-----------
figure(1);
semilogy(papr_baseS,percent_papr_SLM(1,:)); hold on;
semilogy(papr_baseS,percent_papr_SLM(2,:)); hold on;
semilogy(papr_baseS,percent_papr_SLM(3,:)); hold on;
semilogy(papr_baseS,percent_papr_SLM(4,:)); hold on;
semilogy(papr_baseS,percent_papr_ofdm); hold on;
grid on;xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF����');
legend(['q = 1';'q = 2';'q = 3';'q = 4';'OFDM ']);
%------��BERͼ����-----------
figure(2);  
semilogy(EbNos,ber_ofdm);hold on;
semilogy(EbNos,bers_SLM(1,:));hold on;
semilogy(EbNos,bers_SLM(2,:));hold on;
semilogy(EbNos,bers_SLM(3,:));hold on;
semilogy(EbNos,bers_SLM(4,:));hold on;grid on;
xlabel('SNR/dB');ylabel('BER');title('������PAPR�����㷨��BER-SNRͼ���������')
legend(['OFDM ';'q = 1';'q = 2';'q = 3';'q = 4']);

