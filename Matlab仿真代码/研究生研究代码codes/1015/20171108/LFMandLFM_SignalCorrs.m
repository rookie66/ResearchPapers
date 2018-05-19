%% 文档介绍
% Part 1 LFM_Signal与LFM-Comm信号的相关性;
% Part 2 离散法合并：LFM信号与LFM-Comm信号相关分析合并;
% Part 3 利用离散积分仿真相关性，不考虑多普勒频移，LFM信号离散积分结果使用trapz和cumtrapz函数实现;
% Part 4 利用离散积分仿真相关性，不考虑多普勒频移，LFM-Comm信号离散积分结果使用trapz和cumtrapz函数实现;
%% Part1  LFM_Signal与LFM-Comm信号的相关性
clear,clc,close all
LFM_Basic  %执行LFM_Basic 文件程序
load('LFM_Basic.mat'),load('Comm_signal.mat')
[Corr_LFM_Signal,x1] = xcorr(LFM_Signal);%未调制之前的LFM信号自相关
[Corr_LFM_Comm,x2] = xcorr(LFM_Comm);%相位调制之后的LFM-Comm信号自相关
N = 5001;figure(1)
subplot(211),plot(10*x1/N,abs(Corr_LFM_Signal)/max(abs(Corr_LFM_Signal)))
xlabel('时间\mus'),ylabel('幅度'),title('LFM-Signal信号的自相关分析')
subplot(212),plot(10*x2/N,abs(Corr_LFM_Comm)/max(abs(Corr_LFM_Comm)))
xlabel('时间\mus'),ylabel('幅度'),title('LFM-Comm信号的自相关分析')
%% Part2 离散法合并：LFM信号与LFM-Comm信号相关分析合并
clear,clc,close all
LFM_Basic  %执行LFM_Basic 文件程序
load('LFM_Basic.mat'),load('Comm_signal.mat')
tao = -10e-6:Ts:10e-6; %延迟时间
% tao = -10e-6:20*Ts:10e-6; %延迟时间
Corr_LFM_Discrete = zeros(1,length(tao));
Corr_LFM_Comm_Discrete = zeros(1,length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
     else 
            int_region = tao(i):Ts:Tp;
     end
     tt = int_region;
     y_LFM =  LFM_Signal(floor(tt/Ts+1)).*conj(LFM_Signal(floor((tt-tao(i))/Ts+1)));
     y_Comm =  LFM_Comm(floor(tt/Ts+1)).*conj(LFM_Comm(floor((tt-tao(i))/Ts+1)));
     if  length(tt) ~= 1
         Corr_LFM_Discrete(i) = trapz(tt,y_LFM); 
         Corr_LFM_Comm_Discrete(i) = trapz(tt,y_Comm);
     else
         Corr_LFM_Discrete(i) = 0;
         Corr_LFM_Comm_Discrete(i) = 0;
     end
end
Corr_LFM_Discrete = Corr_LFM_Discrete/max(Corr_LFM_Discrete);                %归一化
Corr_LFM_Comm_Discrete = Corr_LFM_Comm_Discrete/max(Corr_LFM_Comm_Discrete); %归一化
figure(2),subplot(211),plot(tao*1e6,abs(Corr_LFM_Discrete));
xlabel('时间\mus'),ylabel('归一化幅值'),title('LFM信号的自相关分析（利用离散方法）')
subplot(212),plot(tao*1e6,abs(Corr_LFM_Comm_Discrete));
xlabel('时间\mus'),ylabel('归一化幅值'),title('LFM-Comm信号的自相关分析（利用离散方法）')
%% Part3 利用离散积分仿真相关性，不考虑多普勒频移，LFM信号离散积分结果使用trapz和cumtrapz函数实现
clear,clc,close all
LFM_Basic  %执行LFM_Basic 文件程序
load('LFM_Basic.mat'),load('Comm_signal.mat')
tao = -10e-6:Ts:10e-6; %延迟时间
Corr_LFM_Discrete = zeros(1,length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
     else 
            int_region = tao(i):Ts:Tp;
     end
     tt = int_region;
     y_LFM =  LFM_Signal(floor(tt/Ts+1)).*conj(LFM_Signal(floor((tt-tao(i))/Ts+1)));
     if  length(tt) ~= 1
         Corr_LFM_Discrete(i) = trapz(tt,y_LFM); 
     else
         Corr_LFM_Discrete(i) = 0;
     end
end
Corr_LFM_Discrete = Corr_LFM_Discrete/max(Corr_LFM_Discrete);  %归一化
figure(3),plot(tao*1e6,abs(Corr_LFM_Discrete));
xlabel('时间\mus'),ylabel('归一化幅值'),title('LFM信号的自相关分析（利用离散方法）')
%% Part4 利用离散积分仿真相关性，不考虑多普勒频移，LFM-Comm信号离散积分结果使用trapz和cumtrapz函数实现
clear,clc,close all
load('LFM.mat');
tao = -10e-6:Ts:10e-6; %延迟时间
Corr_LFM_Comm_Discrete = zeros(1,length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
     else 
            int_region = tao(i):Ts:Tp;
     end
     tt = int_region;
     y_Comm =  LFM_Comm(floor(tt/Ts+1)).*conj(LFM_Comm(floor((tt-tao(i))/Ts+1)));
     if  length(tt) ~= 1
         Corr_LFM_Comm_Discrete(i) = trapz(tt,y_Comm); 
     else
         Corr_LFM_Comm_Discrete(i) = 0;
     end
end
Corr_LFM_Comm_Discrete = Corr_LFM_Comm_Discrete/max(Corr_LFM_Comm_Discrete);
figure(4),plot(tao*1e6,abs(Corr_LFM_Comm_Discrete));
xlabel('时间\mus'),ylabel('归一化幅值'),title('LFM-Comm信号的自相关分析（利用离散方法）')