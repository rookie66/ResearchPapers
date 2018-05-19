

clc
clear all
close all
%常量设置
f0=7000;
B=2000;
fs=4*f0;

ts=0.5;

alfa=pi/6;
alfa11=30;


t=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据
point=ts*fs+1;
a=atan(-1/(S*S*B/ts))*2/pi+4;
SNR=-20;
signal=exp(i*2*pi*(f0-B/2)*t+i*pi*(B/ts)*t.*t);
% signal=exp(i*2*pi*(f0-B/2)*tt*S+i*pi*(B/ts)*tt.*tt*S*S);%chirp(t,700*S,ts/2,900);
noise=normrnd(0,1,1,point);
nx=normrnd(0,1,1,point);
ny=normrnd(0,1,1,point);

snr_lin=10^(SNR/10);
noise_std=sqrt(std(signal)/snr_lin);
noise=noise_std*randn(1,length(signal));


p=signal+noise;
N=length(p);
vx=signal*cos(alfa)+nx;
vy=signal*sin(alfa)+ny;
pa=0.9:0.01:1.1;
u=1:1:length(t);
Pp3=zeros(length(u),length(pa));
for k=1:1:length(pa)
    p3=frft(p,pa(k));
    %vx3=frft(vx,a);
    %vy3=frft(vy,a);
    Pp3(:,k)=p3.*conj(p3)/point;
end
figure(1);surf(pa,u,Pp3);
[CX,CI]=max(max(Pp3));
pa(CI)
 p3=frft(p,a);
 figure(2);plot(p3.*conj(p3)/N);

