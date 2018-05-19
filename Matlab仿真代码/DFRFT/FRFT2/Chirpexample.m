%chirp example:  a chirp of 200ms pulse_width with 300Hz bandwidth at
%centered aroud 1000Hz;
clc;
close all;
clear;
f0=7000;
B=1750;
fs=4*f0;

ts=0.5845;
t=-1*ts/2:1/fs:ts/2;
alfa=pi/6;
alfa11=30;
point=ts*fs+1;

t=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据

point=ts*fs+1;
a=atan(-1/(S*S*B/ts))*2/pi+4;
SN=5;
% t=-1*T/2:1/fs:T/2;
% S=sqrt(T/fs)
% dx=sqrt(T*fs)
% N=length(t);
% tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据
% s1=chirp(tt,1000*S,dx/2,1150*S);
 %signal=chirp(t,1000,0.1,1150);
 Ns=sqrt(10^(SN/10)*fs/point);
noise=Ns*normrnd(0,1,1,point);


signal=exp(i*2*pi*(f0-B/2)*tt*S+i*pi*50*tt.*tt*S*S);
s1=cos(2*pi*(f0-B/2)*tt*S+pi*(B/ts)*tt.*tt*S*S);
psn=signal+noise;

v=50;
c=1500;
t1=(c-v/c)*tt;
signal1=exp(i*2*pi*500*tt*S+i*pi*160*tt.*tt*S*S);


% frt1=frft(s1,a);
% [C,I]=max(frt1);
% pfrt=frt1.*conj(frt1)/point;
% plot(pfrt);

pa=0.9:0.01:1.1;
u=1:1:length(t);
Pp3=zeros(length(u),length(pa));
for k=1:1:length(pa)
    p3=frft(s1,pa(k));
    %vx3=frft(vx,a);
    %vy3=frft(vy,a);
    Pp3(:,k)=p3.*conj(p3)/point;
end
surf(pa,u,Pp3);
[CX,CI]=max(max(Pp3));
pa(CI)

