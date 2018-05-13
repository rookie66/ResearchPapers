
%Kraniauskas通过在时域和分数阶傅里叶域直接采样得到DFRFT
clear;clc,close

%1. DFRFT的基本参数
p = 1;          %FRFT的阶数
alpha = p*pi/2; %旋转角度
beta = csc(alpha);
gama = cot(alpha);
A_alpha = sqrt(1-1i*cot(alpha));%核函数的Aa
T = 10e-6; %观察时间
B = 50e6;
Fs = 100e6;
Ts = 1/Fs;%采样间隔
N = round(T/Ts); %载波个数
nn = linspace(0,T,N);
mu = B/T;
x = exp(1i*pi*mu*(nn*Ts).^2);
Fss = 2*pi/(N*Ts*beta);%分数阶傅里叶域采样间隔
X_alpha = zeros(1,N);
for k = 1:N
    X_before = A_alpha*exp(1i/2*gama*(k*Fss)^2);
    for n=1:N
        X_alpha(1,k) = X_alpha(1,k) + x(n)*exp(1i/2*gama*(n*Ts)^2-1i*(2*pi/N)*n*k);
        X_alpha(1,k) = X_before*X_alpha(1,k);
    end
end
X_alpha
figure(1)
plot(abs(abs(X_alpha)))

figure(2)
X_fft = fft(x);
plot(abs(abs(X_fft)))
figure(3)
plot(abs(x))
