% ������Ľ���
%       ��QAM_2_OFDM.m������,����˼���PAPR-CCDF�Ĺ���,������PAPR-CCDFͼ��;
%       ȥ����16����ԭ�ź�ͼ�������ͼ;���ǹ�������Ȼû��ʵ��
close all;clear;clc
%�źű�������n
n = 1024*128;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
N = 64;
%��������
L = 1;  LN = L*N;
%������������Ʊ�����(��������
x = randi([0 1],1,n); 
%ת������ά�ȣ�ÿk��bitһ��
x_4 = reshape(x,length(x)/k,k);
%���16����
x_16 = bi2de(x_4,'right-msb');%right-msb������ʾ��һ��Ϊ���λ��
%��16QAM���������źŽ��е���
y = modulate(modem.qammod(M),x_16);
%y�����yΪһ����������
colums_num = length(y)/N;
y_para = reshape(y,N,colums_num);

%-----------��QAM���ƺ�����ݽ���IFFT������PAPR---------
x_ofdm = zeros(N,colums_num);%x_ofdm ��ŵ��ƺ������
papr = zeros(1,colums_num);
for i = 1:colums_num
     %ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
       x_ofdm(:,i) = L*ifft(y_para(:,i),LN);%Ĭ��Ҳ��LN��ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2);
       p_peak = max(abs(x_ofdm(:,i)).^2);
       papr(i) = 10*log10(p_peak/p_av);
end
papr_baseS = 5:0.5:15;
percent_papr = zeros(1,length(papr_baseS));
i = 0;
for papr_base = papr_baseS
    i = i + 1;
    percent_papr(i) = length(find(papr > papr_base))/length(papr);
end
figure
semilogy(papr_baseS,percent_papr),grid on
xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF����');
%-------PAPR��������---------------
%-------������з��͵��ŵ�����������fft��dQAM,�����������----------
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
z = de2bi(yd,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����?
z = reshape(z,1,n);
[number_of_errors,bit_error_rate] = biterr(x,z);
j_index = j_index + 1;
rates(j_index) = bit_error_rate;
end 
disp('������ʣ�')
rates
figure,semilogy(EbNos,rates),grid on;
xlabel('SNR/dB');ylabel('BER');title('������PAPR�����㷨��BER-SNRͼ���������')
