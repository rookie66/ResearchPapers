clear,clc,close all
Fs = 500e6;% 采样频率为500MHz
Ts = 1/Fs;%采样间隔2ns
Tp = 10e-6;%LFM信号长度为10微秒
N = round(Tp/Ts);%采样点数
f0 = 0;%起始频率为0
B = 10e6;%信号频率带宽10MHz
k = B/Tp;%频率上升斜率
t = 0:Ts:Tp;%离散时间信号
f = f0 + k*t;
figure(1)
plot(t*1e6,f/1e6)
xlabel('时间（微秒）'),ylabel('频率（MHz）'),title('频率-时间变化')
phi = 2*pi*f0*t+pi*k*t.^2;
figure(2)
plot(t*1e6,phi/pi/2)
xlabel('时间（微秒）'),ylabel('相位（2*pi rad）'),title('相位-时间变化')
%u1 = exp(j*phi);
u = cos(phi);
figure(3)
plot(t*1e6,u)
xlabel('时间（微秒）'),ylabel('幅值'),title('LFM信号-时间变化')
figure(4)
F = fft(u(1:N))/N*2;
F = fftshift(F);
f = -Fs/2:Fs/N-1:Fs/2;
plot(f(1:N)/1e6,abs(F(1:N)))
xlabel('频率（MHz）'),ylabel('幅值'),title('LFM频谱分析')
axis([-50,50,0,0.2])
%[Ru Rt] = xcorr(u,'unbiased');%重叠几个，分母就是几
%[Ru Rt] = xcorr(u,'biased');%除以的都是N
[Ru,Rt] = xcorr(u,'coeff');%重叠几个，分母就是几
Rt = Rt*Ts;
figure(5)
plot(Rt*1e6,abs(Ru))
xlabel('时间（微秒）'),ylabel('Ru'),title('LFM信号自相关函数(利用xcorr函数)');
tao = -Tp:Ts:Tp;
Rtao = sinc(k*pi*tao.*(Tp-abs(tao))).*(Tp-abs(tao))/Tp;
%fclo([1,2,3,4])
figure(6)
plot(tao*1e6,abs(Rtao))
xlabel('时间（\mu秒）'),ylabel('Rtao'),title('LFM信号自相关函数(利用公式）');

Ntao = 2500;
t2 = [zeros(1,Ntao),t];%离散时间信号
t3 = [t,zeros(1,Ntao)];%离散时间信号
phi2 = 2*pi*f0*t2+pi*k*t2.^2;
phi3 = 2*pi*f0*t3+pi*k*t3.^2;
u2 = cos(phi2);
u3 = cos(phi3);
[Ru2,Rt2] = xcorr(u2,u3);%重叠几个，分母就是几
Rt2 = Rt2(Ntao+1:end)*Ts;
figure(7)
plot(Rt2*1e6,abs(Ru2(Ntao+1:end)))
xlabel('时间（微秒）'),ylabel('Ru2'),title('LFM信号互相关函数(利用xcorr函数)');
axis([-5,15,0,3000])
xlabel('时间（\mu秒）'),ylabel('Ru23'),title('利用xcorr做互相关匹配，延迟5\mu s')

[Ru23,N]=CroCorr(u2,u3);%%调用FFT实现u2与u3的互相关
figure(8)
t8 = ((0:(N-1))-N/2)*Ts;
plot(t8*1e6,abs(Ru23))
axis([-5,15,0,3000])
xlabel('时间（\mu秒）'),ylabel('Ru23'),title('利用FFT做互相关匹配，延迟5\mu s')
%PSD
figure(9)
[PSD,F_psd] = periodogram(u,[],[-50e6,50e6],Fs);
plot(F_psd,PSD)
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%LFM信号的模糊函数（Ambiguity Function）
tao = -Tp:10*Ts:Tp;%时间延迟范围
tao3 = -Tp:10*Ts:Tp;%时间延迟范围
v_range = B/1e2;  
v_range3 = B;  
v = linspace(-v_range,v_range,length(tao));%多普勒频移的范围
v3 = linspace(-v_range3,v_range3,length(tao));%多普勒频移的范围3
[tao,v]=meshgrid(tao,v);
[tao3,v3]=meshgrid(tao3,v3);
% LFM信号的Ambiguity Function 模糊函数
AF = sinc((v-k*tao).*(Tp-abs(tao))).*(Tp-abs(tao))/Tp;%模糊函数
AF3 = sinc((v3-k*tao3).*(Tp-abs(tao3))).*(Tp-abs(tao3))/Tp;%模糊函数
%LFM信号的距离模糊函数
tao2 = -Tp:10*Ts:Tp;%时间延迟范围
AF_range = sinc(-k*pi*tao2.*(Tp-abs(tao2))/pi).*(Tp-abs(tao2))/Tp;
%LFM信号的速度模糊函数
v2 = -B:100:B;%多普勒频移的范围
AF_v = sinc(Tp*v2);


figure(11)
colormap jet;
mesh(tao*1e6,v/1e6,abs(AF))%做三维模糊图
title('LFM信号Ambiguity Function图'),xlabel('时间(\mus)'),ylabel('多普勒频移(MHz)'),zlabel('幅值')

%view(2)
figure(12)
colormap jet;
mesh(tao3*1e6,v3/1e6,abs(AF3))%做三维模糊图
title('LFM信号Ambiguity Function图'),xlabel('时间(\mus)'),ylabel('多普勒频移(MHz)'),zlabel('幅值')
view(2)
figure(13)  % 距离模糊图与速度模糊图
subplot(211)%做距离模糊图
plot(tao2*1e6,abs(AF_range))
title('LFM信号的距离模糊图'),xlabel('时间(\mus)'),ylabel('幅值')
subplot(212)
plot(v2/1e6,abs(AF_v)) %做速度模糊图
title('LFM信号的速度模糊图'),xlabel('频率(MHz)'),ylabel('幅值')
% view(2)就可以看到x-y平面投影


%% 利用FFT做功率谱密度分析PSD（函数periodogram)
close all

x = u;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;
plot(freq*1e-6,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (MHz)')
ylabel('Power/Frequency (dB/Hz)')
axis([0,50,-150,0])

