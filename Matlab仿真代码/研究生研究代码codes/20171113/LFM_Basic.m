%LFM信号基本的参数设置
clear,clc,close all
%Part1.1: 普通LFM信号的基本参数
Fs = 500e6;% 采样频率为500MHz
Ts = 1/Fs; %采样间隔2ns
Tp = 10e-6;%LFM信号长度为10微秒
N = round(Tp/Ts); %采样点数
f0 = 0; %起始频率为0
B = 5e6;%信号频率带宽5MHz
k = B/Tp;%频率上升斜率
t = 0:Ts:Tp;%离散时间信号
f = f0 + k*t;
phi = 2*pi*f0*t+pi*k*t.^2;%LFM信号相位
LFM_Signal = exp(1j*phi);%LFM信号,1j就是表示虚部符号，此时不影响j的使用

%Part1.2: 做出普通LFM信号的基本图像
figure(1)
subplot(311),plot(t*1e6,f/1e6),xlabel('时间（微秒）'),ylabel('频率（MHz）'),title('频率-时间变化')
subplot(312),plot(t*1e6,phi/pi/2),xlabel('时间（微秒）'),ylabel('相位（2*pi rad）'),title('相位-时间变化')
subplot(313),plot(t*1e6,real(LFM_Signal)),xlabel('时间（微秒）'),ylabel('幅值'),title('普通LFM信号-时间变化')

%Part2：产生M序列：M1与M2
seed1 = [1,0,0,0,1,1];
seed2 = [zeros(1,5),1];
pri = [0,1,1,0,1,1];
N = 2^(length(pri))-1;
M1_Single = My_M_Seq(pri,seed1,N);%产生M1序列
M2_Single = My_M_Seq(pri,seed2,N);%产生M2序列
M1a = M1_Single.*2-1; %将10的M序列转化为值为1-1的M序列
M2a = M2_Single.*2-1; %将10的M序列转化为值为1-1的M序列

%Part3:产生随机的通信比特流
signal_Num = 158; %通信信号的比特数
randnum = round(rand(1,signal_Num)); %产生随机的通信信号
randnum_a = randnum*2-1;  %将通信信号0101序列变成1-11-1序列
signalA = randnum_a(1:end/2);  %将通信信号分成两个比特流，分为A、B
signalB = randnum_a(end/2+1:end); %对于A用M1序列进行解调，B用M2序列进行解调
save('Comm_signal.mat','signal_Num','randnum','randnum_a','signalA','signalB')

%Part4:对通信信号进行调制，调制到LFM信号中，生成LFM-Comm信号
S_numA = length(signalA);
Phi_m = pi/6;
% Phi_m = pi/2;
LFM_Comm_Phi = phi;
% 这个for循环完成对信号A的调制
for i = 1:S_numA
    phi_M1_63 = signalA(i)*M1a*Phi_m;%利用M1对信号A生成相位差
    LFM_n = (1+(i-1)*63):i*63; %调整LFM中信号需要相位调制的索引
    LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M1_63;%进行相位调制
end
S_numB= length(signalB);
% 这个for循环完成对信号B的调制
for i = 1:S_numB
    phi_M2_63 = signalB(i)*M2a*Phi_m;%利用M2对信号A生成相位差
    LFM_n = ((1+(i-1)*63):i*63) +13; %调整LFM中信号需要相位调制的索引
    LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M2_63; %进行相位调制
end
%具有调制信息的LFM-Comm信号
LFM_Comm = exp(1j*LFM_Comm_Phi);

%Part4.2: 做出LFM信号的基本图像
figure(2)
subplot(211),plot(t*1e6,LFM_Comm_Phi/pi/2),xlabel('时间（微秒）'),ylabel('相位（2*pi rad）'),title('相位-时间变化')
subplot(212),plot(t*1e6,real(LFM_Comm)),xlabel('时间（微秒）'),ylabel('幅值'),title('LFM-Comm信号-时间变化')
save('LFM_Basic.mat','t','Fs','Ts','Tp','LFM_Signal','LFM_Comm','N')%将基本参数信息保存到LFM.mat文件中
%LFM_Signal 为普通的LFM信号；LFM_Comm为调制通信信号后的LFM-Comm信号

%Part5 完成
clear,clc,close all  %由于变量已经保存到Comm_signal.mat与LFM.mat文件中，所以清除掉