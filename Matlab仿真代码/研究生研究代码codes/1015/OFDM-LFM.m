%门函数频谱分析
clear,clc,close all
Fs = 100e6;
t = -0.01:1/Fs:0.01;
N = length(t);
y = zeros(1,N);
y(ceil(N/4):ceil(3*N/4))=1;
figure(1),subplot(121)
plot(t,y);
F = fftshift(fft(y));
subplot(122)
plot((((-N/2+1):1:N/2)-0.5)*Fs/N,abs(F)/max(F))
axis([-1000,1000,0,1])
%% 门函数周期延拓
clear,clc,close all
Fs = 1e6;
t = -0.1:1/Fs:0.1;
N = length(t)-1;
y = zeros(1,N);
M = 10;%载波数目
N1 = ceil(N/M);
for i = 1:M
    index = (i-1)*N1+(N1/4:3*N1/4);
    y(index)=1;
end
figure(2),subplot(121)
t = t(1:end-1);
plot(t,y);
F = fftshift(fft(y));
subplot(122)
plot((((-N/2+1):1:N/2))*Fs/N,abs(F)/max(F))
axis([-1000,1000,0,1])
%% OFDM信号
Fs = 1e6;
f0 = 0;
T = 10e-6;
Df = 1/T;
N = 10;%载波个数
j = sqrt(-1);
t = -T/2:1/Fs:T/2;
M = length(t);
y = zeros(1,M);
for i = 1:N
    fn = f0 + (i-1)*Df; 
    y = y + exp(j*2*pi*fn*t);
end
figure(3),subplot(121)
plot(t*1e6,y)
xlabel('时间（\mu s)')
F = fftshift(fft(y));
subplot(122)
plot(abs(F))
%plot((((-M/2+1):1:M/2))*Fs/M,abs(F)/max(F))

%% OFDM-LFM
Fs = 1e6;
f0 = 0;
T = 10e-6;
Df = 1/T;
N = 10;%载波个数
j = sqrt(-1);
t = -T/2:1/Fs:T/2;
M = length(t);
y = zeros(1,M);
B = 5e6;
k = B/T;
for i = 1:N
    fn = f0 + (i-1)*Df; 
    y = y + exp(1j*2*pi*fn*t+1j*pi*k.*t.^2);
end
figure(3),subplot(121)
plot(t*1e6,y)
xlabel('时间（\mu s)')
F = fftshift(fft(y));
subplot(122)
plot(abs(F))
%plot((((-M/2+1):1:M/2))*Fs/M,abs(F)/max(F))

