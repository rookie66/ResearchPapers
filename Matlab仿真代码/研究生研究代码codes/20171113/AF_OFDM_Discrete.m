% 对FLM-OFDM信号做模糊函数分析（利用离散方法）
 %% Part 1 LFM信号离散积分结果
 clear,close all,clc
 LFM_OFDM%执行LFM_OFDM文件
 load('LFM_OFDM.mat')
%  AF_Func_Discrete(LFM_OFDM_Signal)
close all
 LFM_Signal = LFM_OFDM_Comm;
tic
tao = -10e-6:10*Ts:10e-6;%延迟时间
fd = 0:1:100;%多普勒频移
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
figure(7),colormap jet
mesh(tao*1e6,fd,abs(AF_LFM));
xlabel('时间\mus'),ylabel('多普勒频移(Hz)'),zlabel('归一化幅值'),title('LFM-Signal信号的模糊函数图分析（利用离散方法）')
figure(8),colormap jet
AF_LFM_dB = 20*log10(abs(AF_LFM)*1e4);
AF_LFM_dB(find(AF_LFM_dB<0))=0;
mesh(tao*1e6,fd,AF_LFM_dB);
xlabel('时间\mus'),ylabel('多普勒频移(Hz)'),zlabel('幅值(dB)'),title('LFM-Signal信号的模糊函数图分析（利用离散方法）')
toc