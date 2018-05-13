clear all,clc
% �������
Fs = 500E6;%����Ƶ��500MHz
Tp = 10E-6;%10΢��
B = 2.5E11;%2.5MHz% Ϊ�˹۲�����ѡ��B = 2.5E11
%B = 2.5E6;%2.5MHz
A = 1; %�źŷ�ֵ1
F0 = 0;% ���Ϊ����ͼ��������Ҫѡ��F0 = 0
%F0 = 5E6;%����Ƶ��Ϊ5MHz
% 1. ���ݷ������������������
Ts = 1/Fs;%�������
Np = Tp/Ts;%��������

% 2. ����LFM�ź�
ni= 1:1:Np;
Phi = (B/2)*((ni/Fs).^2)+F0*(ni/Fs);
LFM_Signal =A*exp(j*2*pi*Phi);
figure(1)
plot(ni/500,LFM_Signal)

% 3. ����غ���
[Auto_Corr,Tao] = xcorr(LFM_Signal,'coeff');
figure(2)
plot(linspace(-1,1,length(Auto_Corr)),abs(Auto_Corr)*5000);
grid on
save 'LFM.mat'






