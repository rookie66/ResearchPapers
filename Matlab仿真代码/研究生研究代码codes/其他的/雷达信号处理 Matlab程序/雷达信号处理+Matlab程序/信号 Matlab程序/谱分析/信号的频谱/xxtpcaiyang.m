clear all;
clc;
%%%%%%%%%%%%%%%%%%%
%����ϵͳ����
%%%%%%%%%%%%%%%%%%%
Tp=300e-7;            %������
B=2e6;                %����
kr=B/Tp;              %��Ƶ��
fs=10e6;              %����Ƶ��
R0=180e3;
theta=0;
c=3e8;
t=-Tp/2:1/fs:Tp/2;
echo=exp(j*0.5*kr*2*pi*t.^2);
plot(t,real(echo));
Fs=10e6;Ts=1/Fs;
n=-150:150;
echo=exp(j*0.5*kr*2*pi*(n*Ts).^2);
figure,stem(n,real(echo));
k=0:1024;
S=echo*exp(-j*2*pi/1024).^(n'*k);
w=2*pi*k*4e4/1024;
figure,plot(w,fftshift(abs(S)));
