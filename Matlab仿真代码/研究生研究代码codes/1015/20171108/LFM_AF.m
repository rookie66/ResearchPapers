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
phi = 2*pi*f0*t+pi*k*t.^2;
%u1 = exp(j*phi);
u = cos(phi);

%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%LFM信号的模糊函数（Ambiguity Function）
tao = -Tp:10*Ts:Tp;%时间延迟范围
tao3 = -Tp:10*Ts:Tp;%时间延迟范围
v_range = B/1e5;  
v_range3 = B;  
v = linspace(0,v_range,length(tao));%多普勒频移的范围
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
mesh(tao*1e6,v/1e6,abs(AF))  %做三维模糊图
title('LFM信号Ambiguity Function图'),xlabel('时间(\mus)'),ylabel('多普勒频移(MHz)'),zlabel('幅值')
AF_New = 20*log10(abs(AF)*10000+eps);
view(3)
figure(13)
colormap jet;
AF_New(find(AF_New<0))=0;
mesh(tao*1e6,v,AF_New)%做三维模糊图
title('LFM信号Ambiguity Function图'),xlabel('时间(\mus)'),ylabel('多普勒频移(MHz)'),zlabel('幅值')
axis([-10,10,0,100,0,100])

%%
figure(13)  % 距离模糊图与速度模糊图
subplot(211)%做距离模糊图
plot(tao2*1e6,abs(AF_range))
title('LFM信号的距离模糊图'),xlabel('时间(\mus)'),ylabel('幅值')
AF_range_dB = 20*log10(abs(AF_range*10000+eps));

subplot(212)
plot(v2/1e6,abs(AF_v)) %做速度模糊图
title('LFM信号的速度模糊图'),xlabel('频率(MHz)'),ylabel('幅值')
% view(2)就可以看到x-y平面投影