clear all,clc
% 仿真参数
Fs = 500E6;%采样频率500MHz
Tp = 10E-6;%10微秒
B = 2.5E11;%2.5MHz% 为了观察明显选择B = 2.5E11
%B = 2.5E6;%2.5MHz
A = 1; %信号幅值1
F0 = 0;% 如果为了作图清晰，需要选择F0 = 0
%F0 = 5E6;%中心频率为5MHz
% 1. 根据仿真参数计算其他参数
Ts = 1/Fs;%采样间隔
Np = Tp/Ts;%采样点数

% 2. 生成LFM信号
ni= 1:1:Np;
Phi = (B/2)*((ni/Fs).^2)+F0*(ni/Fs);
LFM_Signal =A*exp(j*2*pi*Phi);
figure(1)
plot(ni/500,LFM_Signal)

% 3. 自相关函数
[Auto_Corr,Tao] = xcorr(LFM_Signal,'coeff');
figure(2)
plot(linspace(-1,1,length(Auto_Corr)),abs(Auto_Corr)*5000);
grid on
save 'LFM.mat'






