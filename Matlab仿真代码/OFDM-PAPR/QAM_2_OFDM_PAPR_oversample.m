% �ó����ܸĽ���
%       ��QAM_2_OFDM_PAPR.m������,����˹���������
%       �����������޸���
close all;clear;clc
%�źű�������n
n = 1024*128*16;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
N = 64;
%��������over_samp
L = 1; LN = L*N;
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
%-------��ӹ���������-------------
y_para_oversample = [y_para(1:N/2,:);zeros((L-1)*N,colums_num);y_para(N/2+1:end,:)];
%-----------��QAM���ƺ�����ݽ���IFFT������PAPR---------
x_ofdm = zeros(LN,colums_num);%x_ofdm ��ŵ��ƺ������
papr = zeros(1,colums_num);
for i = 1:colums_num
        %ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
       x_ofdm(:,i) = L*ifft(y_para_oversample(:,i),LN);%Ĭ��Ҳ��LN��ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2);%���������N
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
percent_papr
figure
semilogy(papr_baseS,percent_papr),grid on
xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF����');
%----------PAPR��������---------------
%-------������з��͵��ŵ�����������fft��ȥ��������dQAM,�����������----------
%���䴮
y_Serial_ifft = reshape(x_ofdm,1,LN*length(x_ofdm));
j_index = 0;EbNos = -10:1:30;
rates = zeros(1,length(EbNos));
for EbNo= EbNos 
    %snr = EbNo+10*log10(k)-10*log10(L);%�����
    snr = EbNo;
    % yn = y_Serial_ifft;
    yn=awgn(y_Serial_ifft,snr,'measured');%�����˹������
    %���䲢
    colums_num_R = length(yn)/LN;
    y_para_R = reshape(yn,LN,colums_num_R);
    %fft�任
    y_fft = zeros(LN,colums_num_R);
    for i = 1:colums_num_R
        y_fft(:,i) = fft(y_para_R(:,i),LN);
    end
    %---------ȥ��������-------------
    y_fft_quoversample = [y_fft(1:N/2,:);y_fft(end-N/2+1:end,:)];
    %-----------------------------------------
    yd = demodulate(modem.qamdemod(M),y_fft_quoversample);%��ʱ�����������16�����ź�
    z=de2bi(yd,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
    z=reshape(z,1,n);
    [number_of_errors,bit_error_rate]=biterr(x,z);
    j_index = j_index+1;
    rates(j_index) = bit_error_rate;
end 
disp('������ʣ�');rates
figure,semilogy(EbNos,rates),grid on;
xlabel('SNR/dB');ylabel('BER');title('������PAPR�����㷨��BER-SNRͼ���������');
