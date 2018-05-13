%LFM-OFDM��LFM-OFDM-Comm�źŵķ���

clear,clc,close all
%Part1.1: ��ͨLFM�źŵĻ�������
Fs = 500e6;% ����Ƶ��Ϊ500MHz
Ts = 1/Fs; %�������2ns
Tp = 10e-6;%LFM�źų���Ϊ10΢��
N = round(Tp/Ts)+1; %��������
f0 = 0;  %��ʼƵ��Ϊ0
Delta_f = 5e6; %Delta_f = 10*M/Tp; %OFDMƵ�ʼ��
B = 5e6;  %�ź�Ƶ�ʴ���5MHz
k = B/Tp; %Ƶ������б��
t = 0:Ts:Tp;%��ɢʱ���ź�
f = f0 + k*t;
M = 10;   %M��ʾOFDM�����������ĸ���
%��LFM-OFDM-Signal����������Ϣ���浽LFM.mat�ļ���
save('LFM_OFDM.mat','t','Fs','Ts','Tp','M','N')

%Part1.2:����LFM-OFDM�ź�LFM_OFDM_Signal
LFM_Signals = zeros(M,N);%�����е����ز����г�ʼ��
phis = zeros(M,N);%���������ز�����λ���г�ʼ����
for i = 1:M
    f_start = f0+(i-1)*Delta_f;
    phis(i,:) = 2*pi*f_start*t+pi*k*t.^2;%LFM�ź���λ
    LFM_Signals(i,:) = exp(1j*phis(i,:));%LFM�ź�,1j���Ǳ�ʾ�鲿���ţ���ʱ��Ӱ��j��ʹ��
end
LFM_OFDM_Signal = sum(LFM_Signals);
%����LFM_OFDM_Signal��LFM_Signals�źŵ�LFM_OFDM_Signal.mat�ļ���
save('LFM_OFDM.mat','LFM_OFDM_Signal','LFM_Signals')

%Part1.3: ������ͨLFM�źŵĻ���ͼ��
% figure(1),plot(t*1e6,real(LFM_OFDM_Signal))
% xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('OFDM-LFM�ź�')

%Part2 ��LFM-OFDM�ź���Ƶ�׷���
Fft_LFM_OFDM = fftshift(fft(LFM_OFDM_Signal));
figure(2),subplot(121)
plot((-N/2:1:N/2-1)/N*Fs*1e-6,abs(Fft_LFM_OFDM)/max(abs(Fft_LFM_OFDM)))
xlabel('Ƶ��(MHz)'),ylabel('��һ��'),title('OFDM-LFM-Signal'),grid on 
axis([-50,150,0,1])

%Part3������M���У�M1��M2��+1-1��
seed1 = [1,0,0,0,1,1];
seed2 = [zeros(1,5),1];
pri = [0,1,1,0,1,1];
N_pri = 2^(length(pri))-1;
M1_Single = My_M_Seq(pri,seed1,N_pri);%����M1����
M2_Single = My_M_Seq(pri,seed2,N_pri);%����M2����
M1a = M1_Single.*2-1; %��10��M����ת��ΪֵΪ1-1��M����
M2a = M2_Single.*2-1; %��10��M����ת��ΪֵΪ1-1��M����

%Part4:�������ز������Ƶ������ͨ�ű����������ֳ�A��B��
signal_Num = 158*M; %ͨ���źŵı�����
randnum = round(rand(1,signal_Num)); %���������ͨ���ź�
randnum_a = randnum*2-1;  %��ͨ���ź�0101���б��1-11-1����
Comm_Signals = zeros(M,158);
signalAs = zeros(M,79);
signalBs = zeros(M,79);
for i = 1:M
    Comm_Signals(i,:) = randnum_a((i-1)*158+1:158*i);  %��ͨ���źŷֳ�M�Σ�ÿ���źŶ�Ӧһ���ز�
    signalAs(i,:) = Comm_Signals(i,1:end/2);  %��ÿһ��ͨ���ź��ٷֳ���������������ΪA��B
    signalBs(i,:) = Comm_Signals(i,end/2+1:end);  %����A��M1���н��н����B��M2���н��н��
end 
save('LFM_OFDM.mat','signal_Num','Comm_Signals','signalAs','signalBs')

%Part5.1:��ͨ���źŽ��е��ƣ����Ƶ�LFM�ź��У�����LFM-OFDM-Comm�ź�
S_numA = 69;
 S_numB= 69;
Phi_m = pi/12;
LFM_Comm_Signals = zeros(M,N);
for k = 1:M   %ѭ���Ը����ز����е���
    LFM_Comm_Phi = phis(k,:);
    % ���forѭ����ɵ�k���ز����ź�A�ĵ���
    signalA = signalAs(k,:);
    for i = 1:S_numA
        phi_M1_63 = signalA(i)*M1a*Phi_m;%����M1���ź�A������λ��
        LFM_n = (1+(i-1)*63):i*63; %����LFM���ź���Ҫ��λ���Ƶ�����
        LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M1_63;%������λ����
    end
    % ���forѭ����ɵ�k���ز����ź�B�ĵ���
    signalB = signalBs(k,:);
    for i = 1:S_numB
        phi_M2_63 = signalB(i)*M2a*Phi_m;%����M2���ź�A������λ��
        LFM_n = ((1+(i-1)*63):i*63) +13; %����LFM���ź���Ҫ��λ���Ƶ�����
        LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M2_63; %������λ����
    end
    %�������е�����Ϣ��LFM-OFDM-Comm�ĵ�k���ز�
    LFM_Comm_Signals(k,:) = exp(1j.*LFM_Comm_Phi);
end
LFM_OFDM_Comm = sum(LFM_Comm_Signals);%�Ը����ز�����
save('LFM_OFDM.mat','LFM_Comm_Signals','LFM_OFDM_Comm')

%Part5.2: ����LFM�źŵĻ���ͼ��
% figure(3),plot(t*1e6,real(LFM_OFDM_Comm))
% xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('OFDM-LFM-Comm�ź�-ʱ��仯')

%Part5.3 ��LFM-OFDM-Comm�ź���Ƶ�׷���
Fft_LFM_OFDM_Comm = fftshift(fft(LFM_OFDM_Comm));
figure(2),subplot(122)
plot((-N/2:1:N/2-1)/N*Fs*1e-6,abs(Fft_LFM_OFDM_Comm)/max(abs(Fft_LFM_OFDM_Comm)),'r')
xlabel('Ƶ��(MHz)'),ylabel('��һ��'),title('OFDM-LFM-Comm'),grid on 
axis([-50,150,0,1])

%Part6 ������Է���
[Corr_LFM_OFDM_Signal,x1] = xcorr(LFM_OFDM_Signal);%δ����֮ǰ��LFM-OFDM�ź������
Corr_LFM_OFDM_Signal_guiyi=abs(Corr_LFM_OFDM_Signal)/max(abs(Corr_LFM_OFDM_Signal));%��һ��
[Corr_LFM_OFDM_Comm,x2] = xcorr(LFM_OFDM_Comm);%��λ����֮���LFM-OFDM-Comm�ź������
Corr_LFM_OFDM_Comm_guiyi = abs(Corr_LFM_OFDM_Comm)/max(abs(Corr_LFM_OFDM_Comm));%��һ��
figure(4),subplot(211)
plot(10*x1/N,Corr_LFM_OFDM_Signal_guiyi)
xlabel('ʱ��\mus'),ylabel('����'),title('OFDM-LFM-Signal�źŵ�����ط���')
subplot(212),plot(10*x2/N,Corr_LFM_OFDM_Comm_guiyi)
xlabel('ʱ��\mus'),ylabel('����'),title('OFDM-LFM-Comm�źŵ�����ط���')

%Part7 ��psd�������ܶ�
R_LFM_OFDM_Corr = xcorr(LFM_OFDM_Signal);
R_LFM_OFDM_Comm_Corr = xcorr(LFM_OFDM_Comm);
N = 5001;
PSD_LFM_OFDM_Signal = fftshift(fft(R_LFM_OFDM_Corr))/N;
PSD_LFM_OFDM_Comm = fftshift(fft(R_LFM_OFDM_Comm_Corr))/N;
figure(5),
subplot(121)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,abs(PSD_LFM_OFDM_Signal)/sum(abs(PSD_LFM_OFDM_Signal))*100,'r')
xlabel('Ƶ��(MHz)'),ylabel('Power/Freq(dB/Hz)(%)'),title('PSD of OFDM-LFM-Signal'),grid on
axis([-150,150,0,0.2])
subplot(122)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,abs(PSD_LFM_OFDM_Comm)/sum(abs(PSD_LFM_OFDM_Comm))*100)
xlabel('Ƶ��(MHz)'),ylabel('Power/Freq(dB/Hz)(%)'),title('PSD of OFDM-LFM-Comm'),grid on
axis([-150,150,0,0.2])

figure(6)%ȡdB
subplot(121)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,20*log10(abs(PSD_LFM_OFDM_Signal)/sum(abs(PSD_LFM_OFDM_Signal))),'r')
xlabel('Ƶ��(MHz)'),ylabel('Power/Freq(dB/Hz)'),title('OFDM-LFM-Signal')
axis([-150,150,-150,0]),grid on
subplot(122)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,20*log10(abs(PSD_LFM_OFDM_Comm)/sum(abs(PSD_LFM_OFDM_Comm))))
% legend('PSD\_LFM\_Signal','PSD\_LFM\_OFDM\_Comm')
xlabel('Ƶ��(MHz)'),ylabel('Power/Freq(dB/Hz)'),title('OFDM-LFM-Comm��Deg=15��')
axis([-150,150,-150,0]),grid on

%Part8 ���
%close all
%clear,clc,close all  %���ڱ����Ѿ����浽LFM_OFDM.mat�ļ��У����������