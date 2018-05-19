
%Kraniauskasͨ����ʱ��ͷ����׸���Ҷ��ֱ�Ӳ����õ�DFRFT
clear;clc,close

%1. DFRFT�Ļ�������
p = 1;          %FRFT�Ľ���
alpha = p*pi/2; %��ת�Ƕ�
beta = csc(alpha);
gama = cot(alpha);
A_alpha = sqrt(1-1i*cot(alpha));%�˺�����Aa
T = 10e-6; %�۲�ʱ��
B = 50e6;
Fs = 100e6;
Ts = 1/Fs;%�������
N = round(T/Ts); %�ز�����
nn = linspace(0,T,N);
mu = B/T;
x = exp(1i*pi*mu*(nn*Ts).^2);
Fss = 2*pi/(N*Ts*beta);%�����׸���Ҷ��������
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
