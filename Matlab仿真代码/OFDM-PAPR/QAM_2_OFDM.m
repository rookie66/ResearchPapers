% �����ܣ�
%   ��QAM_2.m�����ϣ�������IFFT��FFT���ƣ�ʵ��OFDM�ź�

%��16QAM�����˵��ƺͽ�����棬�õ�BER-SNR����
close all;clear;clc
%�źű�������n
n = 1024*128*16;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
N = 64;
%��������
L = 1;%over_samp
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
colums_num = length(y)/N;
y_para = reshape(y,N,colums_num);
%x_ofdm ��ŵ��ƺ������
x_ofdm = zeros(N,colums_num);
for i = 1:colums_num
       x_ofdm(:,i) = ifft(y_para(:,i),N);%Ĭ��Ҳ��N��ifft
end
%���䴮
y_Serial_ifft = reshape(x_ofdm,1,N*length(x_ofdm));

j_index = 0;EbNos = -10:1:30;
rates = zeros(1,length(EbNos));
for EbNo= EbNos 
snr = EbNo+10*log10(k)-10*log10(L);%�����
yn=awgn(y_Serial_ifft,snr,'measured');%�����˹������
%���䲢
colums_num_R = length(yn)/N;
y_para_R = reshape(yn,N,colums_num_R);
%fft�任
y_fft = zeros(N,colums_num_R);
for i = 1:colums_num_R
    y_fft(:,i) = fft(y_para_R(:,i),N);
end
yd = demodulate(modem.qamdemod(M),y_fft);%��ʱ�����������16�����ź�
z=de2bi(yd,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����?
z=reshape(z,1,n);
[number_of_errors,bit_error_rate]=biterr(x,z);
j_index = j_index+1;
rates(j_index) = bit_error_rate;
end 
disp('������ʣ�');rates
figure,semilogy(EbNos,rates),grid on;
xlabel('SNR/dB');ylabel('BER');title('BER-SNRͼ���������')
