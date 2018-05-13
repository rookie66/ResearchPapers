% �ó����ܸĽ���
%     ��QAM_2_OFDM_PAPR.m������,����˹���������
%     �����������޸���
%     SLM�㷨���ô��벢���Ƿ���SLM�㷨
%     SLM�㷨Ӧ���ǶԸ����Ŷ�����ɸѡ���Ӷ�ѡ���PAPR��͵��Ǹ���
%     �Ľ����㷨��
close all;clear;clc
%�źű�������n
n = 1024*128*64;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%�ز�����
N = 256;
%��������over_samp
L = 1; LN = L*N;
%SLM�㷨�ı�ѡ�ź�
U = 4;%��Ҫ����16
%������������Ʊ�����(��������
x = randi([0 1],1,n); 
%ת������ά�ȣ�ÿk��bitһ��
x_4 = reshape(x,length(x)/k,k);
%���16����
x_16 = bi2de(x_4,'right-msb'); %right-msb������ʾ��һ��Ϊ���λ��
%��16QAM���������źŽ��е���
y = modulate(modem.qammod(M),x_16);
%�����yΪһ����������
colums_num = length(y)/N;
%���䲢
y_para = reshape(y,N,colums_num);
%������������Q
Q = 1j.^randi([1,4],U,N);
%�������SLM�㷨����PAPR
y_slm_para = zeros(LN+1,colums_num);%�����͵��ź�
paprs = zeros(1,colums_num);
for i = 1:colums_num
   [y_slm_para(:,i), paprs(i)]= Func_PAPR_SLM_0430(conj(y_para(:,i)'),Q,L,M);
end
% ��ͨOFDM��PAPR-CCDF����
%-------��ӹ���������-------------
y_para_oversample = [y_para(1:N/2,:);zeros((L-1)*N,colums_num);y_para(N/2+1:end,:)];
%-----------��QAM���ƺ�����ݽ���IFFT������PAPR---------
x_ofdm = zeros(LN,colums_num);%x_ofdm ��ŵ��ƺ������
paprs_ofdm = zeros(1,colums_num);
for i = 1:colums_num
      %ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
       x_ofdm(:,i) = L*ifft(y_para_oversample(:,i),LN);%Ĭ��Ҳ��LN��ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2);%���������N
       p_peak = max(abs(x_ofdm(:,i)).^2);
       paprs_ofdm(i) = 10*log10(p_peak/p_av);
end
% ����ͳ��PAPR��CCDF,����ͼ
papr_baseS = 5:0.3:13;
percent_papr_ofdm = zeros(1,length(papr_baseS)); 
percent_papr_slm = zeros(1,length(papr_baseS));i = 0;
for papr_base = papr_baseS
    i = i + 1;  
    percent_papr_ofdm(i) = length(find(paprs_ofdm > papr_base))/length(paprs_ofdm);
    percent_papr_slm(i) = length(find(paprs > papr_base))/length(paprs);
end
figure
semilogy(papr_baseS,percent_papr_ofdm,'-r*'); hold on;
semilogy(papr_baseS,percent_papr_slm,'-.b^'); 
legend(' OFDM',' SLM')
grid on;xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF����');
%%%-------------��ʼSLM�������BER------------------------------------
y_slm_serial = reshape(y_slm_para,1,colums_num*(LN+1));%���䴮
j_index = 0;EbNos = -10:3:30;
rates = zeros(1,length(EbNos));
for EbNo = EbNos 
%�������
y_slm_serial_noise = awgn(y_slm_serial,EbNo,'measured');
%���䲢
y_slm_para_noise = reshape(y_slm_serial_noise,LN+1,colums_num);
%-------------------��ʼ���-------------------
y_slm_after_fft_over = zeros(LN,colums_num); 
for i = 1:colums_num
    %��SNR�ϵ�ʱ������q���ش���
    q = round(demodulate(modem.qamdemod(M),y_slm_para_noise(LN+1,i)));
    if ( q>U || q<1 )
        q = randi([1,4]);
    end
    %q_No_noise = demodulate(modem.qamdemod(M), y_slm_para(LN+1,i));
    y_slm_after_fft_over(:,i) = fft(y_slm_para_noise(1:LN,i),LN)./conj(Q(q,:)');
end
 %---------ȥ��������-------------
y_slm_after_fft_quover = [y_slm_after_fft_over(1:N/2,:); y_slm_after_fft_over(end-N/2+1:end,:)];
y_slm_after_fft = demodulate(modem.qamdemod(M),y_slm_after_fft_quover);
z = de2bi(y_slm_after_fft,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
z = reshape(z,1,n);
[number_of_errors,bit_error_rate] = biterr(x,z);
j_index = j_index + 1;
rates(j_index) = bit_error_rate;
end
%%-------------��ͨOFDM-------------
j_index_ofdm = 0;
rates_ofdm = zeros(1,length(EbNos));
y_ofdm_serial = reshape(x_ofdm,1,colums_num*LN);
for EbNo = EbNos 
%�������
y_ofdm_serial_noise = awgn(y_ofdm_serial,EbNo,'measured');
%���䲢
y_ofdm_para_noise = reshape(y_ofdm_serial_noise,LN,colums_num);
%��ʼ���
y_ofdm_after_fft_over = zeros(LN,colums_num);
for i = 1:colums_num
    y_ofdm_after_fft_over(:,i) =  fft(y_ofdm_para_noise(1:LN,i),LN);
end
%---------ȥ��������-------------
y_ofdm_after_fft_quover = [y_ofdm_after_fft_over(1:N/2,:);y_ofdm_after_fft_over(end-N/2+1:end,:)];
y_ofdm_after_fft = demodulate(modem.qamdemod(M),y_ofdm_after_fft_quover);
z = de2bi(y_ofdm_after_fft,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
z = reshape(z,1,n);
[number_of_errors,bit_error_rate_ofdm] = biterr(x,z);
j_index_ofdm = j_index_ofdm + 1;
rates_ofdm(j_index_ofdm) = bit_error_rate_ofdm;
end
disp('������ʣ�')
rates
rates_ofdm
figure,semilogy(EbNos,rates),grid on;
hold on ;semilogy(EbNos,rates_ofdm);
xlabel('SNR/dB');ylabel('BER');title('BER-SNRͼ���������');
legend(' SLM',' OFDM')



