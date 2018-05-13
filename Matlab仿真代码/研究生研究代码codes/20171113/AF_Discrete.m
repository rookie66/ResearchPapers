% AF_Discrete仿真
% 分成三部分：第一部分利用离散求解普通LFM信号的模糊函数；
%           Part1.1是根据公式计算模糊函数，Part1.2是根据离散方法计算模糊函数。
% 第二部分利用离散求解OFDM-LFM的模糊函数；
% 第三部分利用离散求解OFDM-LFM-Comm的模糊函数。
 %% Part 1.1 利用公式求解LFM信号的模糊函数（Ambiguity Function）
clear,clc,close all
LFM_Basic                 %执行LFM_Basic 文件程序
load('LFM_Basic.mat')
tao = -10e-6:10*Ts:10e-6; %延迟时间
B_range = B/50;  %多普勒频移的范围
fd = linspace(-B_range,B_range,length(tao));  %多普勒频移的范围
[tao_New,fd_New]=meshgrid(tao,fd);
%根据公式计算模糊函数值
AF_LFM_gongshi = sinc((fd_New-k*tao_New).*(Tp-abs(tao_New))).*(Tp-abs(tao_New))/Tp;  %模糊函数
%下面作图
figure(1),colormap jet;
mesh(tao*1e6,fd_New/1e3,abs(AF_LFM_gongshi))      %做三维模糊图
title('LFM信号Ambiguity Function图'),xlabel('时间(\mus)'),ylabel('多普勒频移(kHz)'),zlabel('幅值')
%取dB，做dB图像
AF_dB = 20*log10(abs(AF_LFM_gongshi)*10000+eps);
figure(2),colormap jet;
AF_dB(find(AF_dB<0))=0;
mesh(tao*1e6,fd_New/1e3,AF_dB)                    %做三维模糊图
title('LFM信号模糊函数图'),xlabel('时间(\mus)'),ylabel('多普勒频移(kHz)'),zlabel('幅值（dB）')

%% Part 1.2 LFM信号离散积分结果
clear,clc,close all
LFM_Basic  %执行LFM_Basic 文件程序
load('LFM_Basic.mat')
tao = -10e-6:10*Ts:10e-6;%延迟时间
B_range = B/50;
fd = -B_range:1e4:B_range;%多普勒频移
AF_LFM = zeros(length(fd),length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
        else 
            int_region = tao(i):Ts:Tp;
    end
    for k = 1:length(fd)
        for tt = int_region
            AF_LFM(k,i)= AF_LFM(k,i)+ LFM_Signal(floor(tt/Ts+1))*conj(LFM_Signal(floor((tt-tao(i))/Ts+1)))*exp(1j*2*pi*fd(k)*tt)*Ts;
        end
    end
 end
AF_LFM = AF_LFM/max(max(AF_LFM));
%开始作图：模糊函数图
figure(3),colormap jet
mesh(tao*1e6,fd/1e3,abs(AF_LFM));
xlabel('时间\mus'),ylabel('多普勒频移(kHz)'),zlabel('归一化幅值'),title('LFM-Signal信号的模糊函数图分析（利用离散方法）')
%做dB图
AF_LFM_dB = 20*log10(abs(AF_LFM)*1e4);
AF_LFM_dB(find(AF_LFM_dB<0))=0;
figure(4),colormap jet
mesh(tao*1e6,fd/1e3,AF_LFM_dB);
xlabel('时间\mus'),ylabel('多普勒频移(kHz)'),zlabel('幅值(dB)'),title('LFM-Signal信号的模糊函数图分析（利用离散方法）')

 %% Part 2 OFDM-LFM信号离散积分结果
clear,clc,close all
LFM_OFDM  %执行LFM_OFDM 文件程序
load('LFM_OFDM.mat')
tao = -10e-6:10*Ts:10e-6;%延迟时间
B_range = B/50;
fd = -B_range:1e3:B_range;%多普勒频移
AF_OFDM_LFM = zeros(length(fd),length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
        else 
            int_region = tao(i):Ts:Tp;
    end
    for k = 1:length(fd)
        for tt = int_region
            AF_OFDM_LFM(k,i)= AF_OFDM_LFM(k,i)+ LFM_OFDM_Signal(floor(tt/Ts+1))*conj(LFM_OFDM_Signal(floor((tt-tao(i))/Ts+1)))*exp(1j*2*pi*fd(k)*tt)*Ts;
        end
    end
 end
AF_OFDM_LFM = AF_OFDM_LFM/max(max(AF_OFDM_LFM));
figure(5),colormap jet
mesh(tao*1e6,fd/1e3,abs(AF_OFDM_LFM));
xlabel('时间\mus'),ylabel('多普勒频移(kHz)'),zlabel('归一化幅值'),title('OFDM-LFM信号的模糊函数图分析')
figure(6),colormap jet
AF_OFDM_LFM_dB = 20*log10(abs(AF_OFDM_LFM)*1e4);
AF_OFDM_LFM_dB(find(AF_OFDM_LFM_dB<0))=0;
mesh(tao*1e6,fd/1e3,AF_OFDM_LFM_dB);
xlabel('时间\mus'),ylabel('多普勒频移(kHz)'),zlabel('幅值(dB)'),title('OFDM-LFM信号的模糊函数图分析')

 %% Part 3 OFDM-LFM-Comm信号离散积分结果
clear,clc,close all
LFM_OFDM  %执行LFM_OFDM 文件程序
load('LFM_OFDM.mat')
tao = -10e-6:10*Ts:10e-6;%延迟时间
B_range = B/50;
fd = -B_range:1e3:B_range;%多普勒频移
AF_OFDM_LFM_Comm = zeros(length(fd),length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
        else 
            int_region = tao(i):Ts:Tp;
    end
    for k = 1:length(fd)
        for tt = int_region
            AF_OFDM_LFM_Comm(k,i)= AF_OFDM_LFM_Comm(k,i)+ LFM_OFDM_Comm(floor(tt/Ts+1))*conj(LFM_OFDM_Comm(floor((tt-tao(i))/Ts+1)))*exp(1j*2*pi*fd(k)*tt)*Ts;
        end
    end
 end
AF_OFDM_LFM_Comm = AF_OFDM_LFM_Comm/max(max(AF_OFDM_LFM_Comm));
figure(7),colormap jet
mesh(tao*1e6,fd/1e3,abs(AF_OFDM_LFM_Comm));
xlabel('时间\mus'),ylabel('多普勒频移(kHz)'),zlabel('归一化幅值'),title('LFM-Signal信号的模糊函数图分析（利用离散方法）')
figure(8),colormap jet
AF_OFDM_LFM_Comm_dB = 20*log10(abs(AF_OFDM_LFM_Comm)*1e4);
AF_OFDM_LFM_Comm_dB(find(AF_OFDM_LFM_Comm_dB<0))=0;
mesh(tao*1e6,fd/1e3,AF_OFDM_LFM_Comm_dB);
xlabel('时间\mus'),ylabel('多普勒频移(kHz)'),zlabel('幅值(dB)'),title('LFM-Signal信号的模糊函数图分析（利用离散方法）')
  