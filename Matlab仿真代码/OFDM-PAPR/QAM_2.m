% �������ܣ�
%   ��QAM_1.m�����ϣ������forѭ�����ڲ�ͬEbNo�£�������Ե�������ʣ�������BER-SNR����
close all;clear;clc
%�źű�������n
n = 1024*128;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%��������
L = 1; %over_samp
%������������Ʊ�����(��������
x = randi([0 1],1,n); 
%ת������ά�ȣ�ÿk��bitһ��
x_4 = reshape(x,length(x)/k,k);
%���16����
x_16 = bi2de(x_4,'right-msb');%right-msb������ʾ��һ��Ϊ���λ��
figure(1);
stem(x_16(1:n_16));%������Ӧ��16�����ź�����
xlabel('�ź�����'); ylabel('16����--�źŷ���');title('16��������ź�');
%��16QAM���������źŽ��е���
y = modulate(modem.qammod(M),x_16);
%y�����yΪһ����������
%h = modem.qammod('M', 16, 'SymbolOrder', 'Gray'); 
scatterplot(y);%����16QAM�źŵ�����ͼ
i = 0;
EbNos = -10:1:30;
rates = zeros(1,length(EbNos));
for EbNo= EbNos 
snr=EbNo+10*log10(k)-10*log10(L);%�����
yn=awgn(y,snr,'measured');%�����˹������
%h=scatterplot(yn,L,0,'b.');%�����ŵ�����յ��ĺ����������ź�
%����ͼ
%hold on;scatterplot(y,1,0,'k+',h);%���벻�����������ź�����ͼ?
%title('�����ź���ԭ���ź�����ͼ');legend('�����������ź�','���������ź�');
%axis([-5 5 -5 5]);
%scatterplot(yn);%����16QAM�źŵ�����ͼ
%axis([-5 5 -5 5]);
yd=demodulate(modem.qamdemod(M),yn);%��ʱ�����������16�����ź�?
z=de2bi(yd,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����?
z=reshape(z,1,n);
[number_of_errors,bit_error_rate]=biterr(x,z);
i = i+1;
rates(i) = bit_error_rate;
end 
figure,semilogy(EbNos,rates),grid on
xlabel('SNR/dB');ylabel('BER');title('BER-SNRͼ���������')
