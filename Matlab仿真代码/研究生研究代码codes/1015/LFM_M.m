clear,clc,close all
Fs = 500e6;% 采样频率为500MHz
Ts = 1/Fs;%采样间隔2ns
Tp = 10e-6;%LFM信号长度为10微秒
N = round(Tp/Ts);%采样点数
f0 = 0;%起始频率为0
B = 10e6;%信号频率带宽10MHz
k = B/Tp;%频率上升斜率
t = 0:Ts:Tp;%离散时间信号
phi = 2*pi*f0*t+pi*k*t.^2;
u = cos(phi);
%***************************以下是利用M序列进行相位改变*******************************************************

phi_deta = pi/12;
M1 = My_M_Seq([0,1,1,0,1,1],[1,0,0,0,1,1]);
M2 = My_M_Seq([0,1,1,0,1,1],[0,0,0,0,0,1]);
for i = 1:length(M1)
    if M1(i)==0
        M1(i)=-1;
    end
end
for i = 1:length(M1)
    if M2(i)==0
        M2(i)=-1;
    end
end
message = zeros(1,158);
for i = 1:158
    if mod(i,3)==1
         message(i)= 1;
    end
    if mod(i,5)==1
         message(i)= 1;
    end
end
message1 = message(1:79);
message2 = message(80:158);
N_Ms = length(M1);
phiM = phi;
for i = 1:length(message1)
    if message1(i)==1
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)+M1*phi_deta;
    else if message1(i)==0
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)-M1*phi_deta;   
        end
    end
end
for i = 1:length(message2)
    if message2(i)==1
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)+M1*phi_deta;
    else if message2(i)==0
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)-M1*phi_deta;   
        end
    end
end

%#################相位-时间图像比照#################################
figure(1)%相位-时间图像比照
subplot(211)
plot(t*1e6,phi);
xlabel('时间（微秒）'),ylabel('相位'),title('相位-时间变化（LFM）')
subplot(212)
plot(t*1e6,phiM)
xlabel('时间（微秒）'),ylabel('相位'),title('相位-时间变化（LFM-M）')

%#################LFM信号-时间图像比照#############################
u2 = cos(phiM);
figure(2)%LFM信号-时间图像比照
subplot(211)
plot(t*1e6,u)
xlabel('时间（微秒）'),ylabel('幅值'),title('LFM信号-时间变化（LFM）')
subplot(212)
plot(t*1e6,u2)
xlabel('时间（微秒）'),ylabel('幅值'),title('LFM信号-时间变化（LFM-M）')


%**********************自相关函数******************************************
%[Ru Rt] = xcorr(u,'unbiased');%重叠几个，分母就是几
%[Ru Rt] = xcorr(u,'biased');%除以的都是N
[Ru,Rt] = xcorr(u,'coeff');%重叠几个，分母就是几
[Ru2,Rt2] = xcorr(u2,'coeff');%重叠几个，分母就是几
Rt = Rt*Ts;
Rt2 = Rt2*Ts;
figure(3)
subplot(211)
plot(Rt*1e6,abs(Ru))
xlabel('时间（微秒）'),ylabel('Ru'),title('LFM信号自相关函数(利用xcorr函数)');
subplot(212)
plot(Rt2*1e6,abs(Ru2))
xlabel('时间（微秒）'),ylabel('Ru'),title('LFM信号自相关函数(利用xcorr函数)');
%#############LFM信号频谱分析###########################
figure(4) %LFM信号频谱分析
F = fft(u(1:N))/N*2;
F2 = fft(u2(1:N))/N*2;
F = fftshift(F);
F2 = fftshift(F2);
f = -Fs/2:Fs/N-1:Fs/2;
subplot(211)
plot(f(1:N)/1e6,abs(F(1:N)))
xlabel('频率（MHz）'),ylabel('幅值'),title('LFM频谱分析(LFM)')
axis([-50,50,0,0.2])
subplot(212)
plot(f(1:N)/1e6,abs(F2(1:N)))
xlabel('频率（MHz）'),ylabel('幅值'),title('LFM频谱分析(LFM-M)')
axis([-50,50,0,0.2])

%######################LFM信号的PSD分析与比照##############################


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
mesh(tao*1e6,v/1e6,abs(AF3))%做三维模糊图
title('LFM信号Ambiguity Function图'),xlabel('时间(\mus)'),ylabel('多普勒频移(MHz)'),zlabel('幅值')
%view(2)

figure(13)  % 距离模糊图与速度模糊图
subplot(211)%做距离模糊图
plot(tao2*1e6,abs(AF_range))
axis([-2,2,0,1])

title('LFM信号的距离模糊图'),xlabel('时间(\mus)'),ylabel('幅值')
subplot(212)
plot(v2/1e6,abs(AF_v)) %做速度模糊图
title('LFM信号的速度模糊图'),xlabel('频率(MHz)'),ylabel('幅值')
axis([-2,2,0,1])
%view(2)%就可以看到x-y平面投影




