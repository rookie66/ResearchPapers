%LFM�źŻ����Ĳ�������
clear,clc,close all
%Part1.1: ��ͨLFM�źŵĻ�������
Fs = 500e6;% ����Ƶ��Ϊ500MHz
Ts = 1/Fs; %�������2ns
Tp = 10e-6;%LFM�źų���Ϊ10΢��
N = round(Tp/Ts); %��������
f0 = 0; %��ʼƵ��Ϊ0
B = 5e6;%�ź�Ƶ�ʴ���5MHz
k = B/Tp;%Ƶ������б��
t = 0:Ts:Tp;%��ɢʱ���ź�
f = f0 + k*t;
phi = 2*pi*f0*t+pi*k*t.^2;%LFM�ź���λ
LFM_Signal = exp(1j*phi);%LFM�ź�,1j���Ǳ�ʾ�鲿���ţ���ʱ��Ӱ��j��ʹ��

%Part1.2: ������ͨLFM�źŵĻ���ͼ��
figure(1)
subplot(311),plot(t*1e6,f/1e6),xlabel('ʱ�䣨΢�룩'),ylabel('Ƶ�ʣ�MHz��'),title('Ƶ��-ʱ��仯')
subplot(312),plot(t*1e6,phi/pi/2),xlabel('ʱ�䣨΢�룩'),ylabel('��λ��2*pi rad��'),title('��λ-ʱ��仯')
subplot(313),plot(t*1e6,real(LFM_Signal)),xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('��ͨLFM�ź�-ʱ��仯')

%Part2������M���У�M1��M2
seed1 = [1,0,0,0,1,1];
seed2 = [zeros(1,5),1];
pri = [0,1,1,0,1,1];
N = 2^(length(pri))-1;
M1_Single = My_M_Seq(pri,seed1,N);%����M1����
M2_Single = My_M_Seq(pri,seed2,N);%����M2����
M1a = M1_Single.*2-1; %��10��M����ת��ΪֵΪ1-1��M����
M2a = M2_Single.*2-1; %��10��M����ת��ΪֵΪ1-1��M����

%Part3:���������ͨ�ű�����
signal_Num = 158; %ͨ���źŵı�����
randnum = round(rand(1,signal_Num)); %���������ͨ���ź�
randnum_a = randnum*2-1;  %��ͨ���ź�0101���б��1-11-1����
signalA = randnum_a(1:end/2);  %��ͨ���źŷֳ���������������ΪA��B
signalB = randnum_a(end/2+1:end); %����A��M1���н��н����B��M2���н��н��
save('Comm_signal.mat','signal_Num','randnum','randnum_a','signalA','signalB')

%Part4:��ͨ���źŽ��е��ƣ����Ƶ�LFM�ź��У�����LFM-Comm�ź�
S_numA = length(signalA);
Phi_m = pi/6;
% Phi_m = pi/2;
LFM_Comm_Phi = phi;
% ���forѭ����ɶ��ź�A�ĵ���
for i = 1:S_numA
    phi_M1_63 = signalA(i)*M1a*Phi_m;%����M1���ź�A������λ��
    LFM_n = (1+(i-1)*63):i*63; %����LFM���ź���Ҫ��λ���Ƶ�����
    LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M1_63;%������λ����
end
S_numB= length(signalB);
% ���forѭ����ɶ��ź�B�ĵ���
for i = 1:S_numB
    phi_M2_63 = signalB(i)*M2a*Phi_m;%����M2���ź�A������λ��
    LFM_n = ((1+(i-1)*63):i*63) +13; %����LFM���ź���Ҫ��λ���Ƶ�����
    LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M2_63; %������λ����
end
%���е�����Ϣ��LFM-Comm�ź�
LFM_Comm = exp(1j*LFM_Comm_Phi);

%Part4.2: ����LFM�źŵĻ���ͼ��
figure(2)
subplot(211),plot(t*1e6,LFM_Comm_Phi/pi/2),xlabel('ʱ�䣨΢�룩'),ylabel('��λ��2*pi rad��'),title('��λ-ʱ��仯')
subplot(212),plot(t*1e6,real(LFM_Comm)),xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('LFM-Comm�ź�-ʱ��仯')
save('LFM_Basic.mat','t','Fs','Ts','Tp','LFM_Signal','LFM_Comm','N')%������������Ϣ���浽LFM.mat�ļ���
%LFM_Signal Ϊ��ͨ��LFM�źţ�LFM_CommΪ����ͨ���źź��LFM-Comm�ź�

%Part5 ���
clear,clc,close all  %���ڱ����Ѿ����浽Comm_signal.mat��LFM.mat�ļ��У����������