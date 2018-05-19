%chirp example:  a chirp of 200ms pulse_width with 300Hz bandwidth at
%centered aroud 1000Hz;
clc;
close all;
clear;

v=50;
c=1500;
r=600;
theta1=135;
theta=theta1*pi/180;

f0=2500;
fs=4*f0;

ts=1;
t=0:1/fs:ts;
alfa=pi/6;
alfa11=30;


ft=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据

point=ts*fs+1;

SN=5;
SS=20;
Np=sqrt(10^(SN/10)*fs/point);

Sp=sqrt(10^(SS/10)*4/point);
noise=Np*randn(1,point);

w=2*pi*f0;
signal_c=cos(w*t);
signal_v=cos(c*w*t/(c+v*cos(theta))-c*c*v*v*w*sin(theta)^2*t.*t/(2*r*(c+v*cos(theta))^3));
signal_vr=cos(c*w*tt*S/(c+v*cos(theta))-c*c*v*v*w*sin(theta)^2*tt.*tt*S*S/(2*r*(c+v*cos(theta))^3));
signal1 =Sp*signal_v;
B=c*c*v*v*sin(theta)^2*w*ts/(r*(c+v*cos(theta))^3);
signal2=Sp*signal_vr;
% signal=exp(i*2*pi*(f0-B/2)*tt*S+i*pi*(B/ts)*tt.*tt*S*S);
% s1=cos(2*pi*(f0-B/2)*tt*S+pi*(B/ts)*tt.*tt*S*S);

psn1=signal1+noise;
psn2=signal2+noise;
fftpsn=fft(psn1);
power_fft=fftpsn.*conj(fftpsn)/point;
figure,plot((1:point)*fs/point-fs/2,10*log10(power_fft));title('FFT')



 a=atan(1/(S*S*B/ts))*2/pi;
 frt1=frft(psn2,a);
% [C,I]=max(frt1);
 pfrt=frt1.*conj(frt1);
figure, plot(10*log10(pfrt));title('FRFT')

% pa=0.99:0.001:1.01;
% u=1:1:length(t);
% Pp3=zeros(length(u),length(pa));
% for k=1:1:length(pa)
%     p3=frft(psn,pa(k));
%     %vx3=frft(vx,a);
%     %vy3=frft(vy,a);
%     Pp3(:,k)=p3.*conj(p3);
% end
% surf(pa,u,Pp3);
% [CX,CI]=max(max(Pp3));
% pa(CI)
%  p3=frft(psn,0.9996);pinpu=p3.*conj(p3);plot(pinpu)
