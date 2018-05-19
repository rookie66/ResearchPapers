%LFM-OFDM与LFM-OFDM-Comm信号的分析

clear,clc,close all
%Part1.1: 普通LFM信号的基本参数
Fs = 500e6;% 采样频率为500MHz
Ts = 1/Fs; %采样间隔2ns
Tp = 10e-6;%LFM信号长度为10微秒
N = round(Tp/Ts)+1; %采样点数
f0 = 0;  %起始频率为0
Delta_f = 5e6; %Delta_f = 10*M/Tp; %OFDM频率间隔
B = 5e6;  %信号频率带宽5MHz
k = B/Tp; %频率上升斜率
t = 0:Ts:Tp;%离散时间信号
f = f0 + k*t;
M = 10;   %M表示OFDM的正交波束的个数
%将LFM-OFDM-Signal基本参数信息保存到LFM.mat文件中
save('LFM_OFDM.mat','t','Fs','Ts','Tp','M','N')

%Part1.2:产生LFM-OFDM信号LFM_OFDM_Signal
LFM_Signals = zeros(M,N);%对所有的子载波进行初始化
phis = zeros(M,N);%对所有子载波的相位进行初始化；
for i = 1:M
    f_start = f0+(i-1)*Delta_f;
    phis(i,:) = 2*pi*f_start*t+pi*k*t.^2;%LFM信号相位
    LFM_Signals(i,:) = exp(1j*phis(i,:));%LFM信号,1j就是表示虚部符号，此时不影响j的使用
end
LFM_OFDM_Signal = sum(LFM_Signals);
%保存LFM_OFDM_Signal、LFM_Signals信号到LFM_OFDM_Signal.mat文件中
save('LFM_OFDM.mat','LFM_OFDM_Signal','LFM_Signals')

%Part1.3: 做出普通LFM信号的基本图像
% figure(1),plot(t*1e6,real(LFM_OFDM_Signal))
% xlabel('时间（微秒）'),ylabel('幅值'),title('OFDM-LFM信号')

%Part2 对LFM-OFDM信号作频谱分析
Fft_LFM_OFDM = fftshift(fft(LFM_OFDM_Signal));
figure(2),subplot(121)
plot((-N/2:1:N/2-1)/N*Fs*1e-6,abs(Fft_LFM_OFDM)/max(abs(Fft_LFM_OFDM)))
xlabel('频率(MHz)'),ylabel('归一化'),title('OFDM-LFM-Signal'),grid on 
axis([-50,150,0,1])

%Part3：产生M序列：M1与M2（+1-1）
seed1 = [1,0,0,0,1,1];
seed2 = [zeros(1,5),1];
pri = [0,1,1,0,1,1];
N_pri = 2^(length(pri))-1;
M1_Single = My_M_Seq(pri,seed1,N_pri);%产生M1序列
M2_Single = My_M_Seq(pri,seed2,N_pri);%产生M2序列
M1a = M1_Single.*2-1; %将10的M序列转化为值为1-1的M序列
M2a = M2_Single.*2-1; %将10的M序列转化为值为1-1的M序列

%Part4:产生各载波呆调制的随机的通信比特流，并分成A、B组
signal_Num = 158*M; %通信信号的比特数
randnum = round(rand(1,signal_Num)); %产生随机的通信信号
randnum_a = randnum*2-1;  %将通信信号0101序列变成1-11-1序列
Comm_Signals = zeros(M,158);
signalAs = zeros(M,79);
signalBs = zeros(M,79);
for i = 1:M
    Comm_Signals(i,:) = randnum_a((i-1)*158+1:158*i);  %将通信信号分成M段，每段信号对应一个载波
    signalAs(i,:) = Comm_Signals(i,1:end/2);  %将每一段通信信号再分成两个比特流，分为A、B
    signalBs(i,:) = Comm_Signals(i,end/2+1:end);  %对于A用M1序列进行解调，B用M2序列进行解调
end 
save('LFM_OFDM.mat','signal_Num','Comm_Signals','signalAs','signalBs')

%Part5.1:对通信信号进行调制，调制到LFM信号中，生成LFM-OFDM-Comm信号
S_numA = 69;
 S_numB= 69;
Phi_m = pi/12;
LFM_Comm_Signals = zeros(M,N);
for k = 1:M   %循环对各个载波进行调制
    LFM_Comm_Phi = phis(k,:);
    % 这个for循环完成第k个载波对信号A的调制
    signalA = signalAs(k,:);
    for i = 1:S_numA
        phi_M1_63 = signalA(i)*M1a*Phi_m;%利用M1对信号A生成相位差
        LFM_n = (1+(i-1)*63):i*63; %调整LFM中信号需要相位调制的索引
        LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M1_63;%进行相位调制
    end
    % 这个for循环完成第k个载波对信号B的调制
    signalB = signalBs(k,:);
    for i = 1:S_numB
        phi_M2_63 = signalB(i)*M2a*Phi_m;%利用M2对信号A生成相位差
        LFM_n = ((1+(i-1)*63):i*63) +13; %调整LFM中信号需要相位调制的索引
        LFM_Comm_Phi(LFM_n) = LFM_Comm_Phi(LFM_n) + phi_M2_63; %进行相位调制
    end
    %产生具有调制信息的LFM-OFDM-Comm的第k个载波
    LFM_Comm_Signals(k,:) = exp(1j.*LFM_Comm_Phi);
end
LFM_OFDM_Comm = sum(LFM_Comm_Signals);%对各个载波叠加
save('LFM_OFDM.mat','LFM_Comm_Signals','LFM_OFDM_Comm')

%Part5.2: 做出LFM信号的基本图像
% figure(3),plot(t*1e6,real(LFM_OFDM_Comm))
% xlabel('时间（微秒）'),ylabel('幅值'),title('OFDM-LFM-Comm信号-时间变化')

%Part5.3 对LFM-OFDM-Comm信号作频谱分析
Fft_LFM_OFDM_Comm = fftshift(fft(LFM_OFDM_Comm));
figure(2),subplot(122)
plot((-N/2:1:N/2-1)/N*Fs*1e-6,abs(Fft_LFM_OFDM_Comm)/max(abs(Fft_LFM_OFDM_Comm)),'r')
xlabel('频率(MHz)'),ylabel('归一化'),title('OFDM-LFM-Comm'),grid on 
axis([-50,150,0,1])

%Part6 作相关性分析
[Corr_LFM_OFDM_Signal,x1] = xcorr(LFM_OFDM_Signal);%未调制之前的LFM-OFDM信号自相关
Corr_LFM_OFDM_Signal_guiyi=abs(Corr_LFM_OFDM_Signal)/max(abs(Corr_LFM_OFDM_Signal));%归一化
[Corr_LFM_OFDM_Comm,x2] = xcorr(LFM_OFDM_Comm);%相位调制之后的LFM-OFDM-Comm信号自相关
Corr_LFM_OFDM_Comm_guiyi = abs(Corr_LFM_OFDM_Comm)/max(abs(Corr_LFM_OFDM_Comm));%归一化
figure(4),subplot(211)
plot(10*x1/N,Corr_LFM_OFDM_Signal_guiyi)
xlabel('时间\mus'),ylabel('幅度'),title('OFDM-LFM-Signal信号的自相关分析')
subplot(212),plot(10*x2/N,Corr_LFM_OFDM_Comm_guiyi)
xlabel('时间\mus'),ylabel('幅度'),title('OFDM-LFM-Comm信号的自相关分析')

%Part7 作psd功率谱密度
R_LFM_OFDM_Corr = xcorr(LFM_OFDM_Signal);
R_LFM_OFDM_Comm_Corr = xcorr(LFM_OFDM_Comm);
N = 5001;
PSD_LFM_OFDM_Signal = fftshift(fft(R_LFM_OFDM_Corr))/N;
PSD_LFM_OFDM_Comm = fftshift(fft(R_LFM_OFDM_Comm_Corr))/N;
figure(5),
subplot(121)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,abs(PSD_LFM_OFDM_Signal)/sum(abs(PSD_LFM_OFDM_Signal))*100,'r')
xlabel('频率(MHz)'),ylabel('Power/Freq(dB/Hz)(%)'),title('PSD of OFDM-LFM-Signal'),grid on
axis([-150,150,0,0.2])
subplot(122)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,abs(PSD_LFM_OFDM_Comm)/sum(abs(PSD_LFM_OFDM_Comm))*100)
xlabel('频率(MHz)'),ylabel('Power/Freq(dB/Hz)(%)'),title('PSD of OFDM-LFM-Comm'),grid on
axis([-150,150,0,0.2])

figure(6)%取dB
subplot(121)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,20*log10(abs(PSD_LFM_OFDM_Signal)/sum(abs(PSD_LFM_OFDM_Signal))),'r')
xlabel('频率(MHz)'),ylabel('Power/Freq(dB/Hz)'),title('OFDM-LFM-Signal')
axis([-150,150,-150,0]),grid on
subplot(122)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,20*log10(abs(PSD_LFM_OFDM_Comm)/sum(abs(PSD_LFM_OFDM_Comm))))
% legend('PSD\_LFM\_Signal','PSD\_LFM\_OFDM\_Comm')
xlabel('频率(MHz)'),ylabel('Power/Freq(dB/Hz)'),title('OFDM-LFM-Comm（Deg=15）')
axis([-150,150,-150,0]),grid on

%Part8 完成
%close all
%clear,clc,close all  %由于变量已经保存到LFM_OFDM.mat文件中，所以清除掉