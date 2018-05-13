clc
clear all
close all
fr=10e3;
tr=1/fr;
fs=8e6;
ts=1/fs;
fd=2.5e3;
lemna=0.01;
sita=0.027;%固定杂波速度方差
sita1=0.06;%动杂波速度方差
sita2=0.06;%动杂波速度方差
choose=3;
f1=1:50;
f2=-49:50;
f3=-24.5:25;
N=round(tr/ts);
G=exp(-(f1.^2*lemna^2/(8*sita^2)));
G1=0.6*exp(-(f2.^2*lemna^2/(8*sita1^2)));
G2=exp(-(f3.^2*lemna^2/(8*sita^2)));
G3=0.3*exp(-(f2.^2*lemna^2/(8*sita2^2)));
s=[G,zeros(1,50),G1,zeros(1,125),G3,zeros(1,N-451),G2,0];
n=1:floor(fr*2*pi)/800:floor(fr*2*pi);
k1=0.5;
k2=0.0;
k3=0.3;
k=2;
z=exp(j*n.*tr);
z_1=1./z;
switch choose
    case 1
H=1-z_1;%一次对消
   case 2
H=1-k*z_1+z_1.^2;;%二次对消
   case 3
H=(1-z_1)./(1-k1*z_1);%反馈型一次对消
   case 4
H=(1-z_1).^2./(1-(k2+k3)*z_1+k3*z_1.^2);%反馈型三脉冲对消
end
H=abs(H)./2;
s1=[H,zeros(1,25)].*s;
subplot(211)
plot(1:800,H)
text(-4,-0.2,'\fontsize{8}固定杂波')
text(120,-0.2,'\fontsize{8}运动杂波')
text(350,-0.2,'\fontsize{8}目标')
text(800,-0.2,'fr')
hold on
grid on
plot(1:825,s,'r')
subplot(212)
plot(1:max(size(s1)),s1,'r')
grid on
B=fr/8;
[b(1,:),a(1,:)]=fir1(50,eps+B/fr);
[b(2,:),a(2,:)]=fir1(50,[1*B/fr,2*B/fr]);
[b(3,:),a(3,:)]=fir1(50,[2*B/fr,3*B/fr]);
[b(4,:),a(4,:)]=fir1(50,[3*B/fr,4*B/fr]);
[b(5,:),a(5,:)]=fir1(50,[4*B/fr,5*B/fr]);
[b(6,:),a(6,:)]=fir1(50,[5*B/fr,6*B/fr]);
[b(7,:),a(7,:)]=fir1(50,[6*B/fr,7*B/fr]);
[b(8,:),a(8,:)]=fir1(50,[7*B/fr,8*B/fr-eps]);
[h1,w]=freqz(b(1,:),a(1,:),825);
figure
subplot(211)
grid on
plot(1:825,abs(h1));hold on;
[h2,w]=freqz(b(2,:),a(2,:),825);
plot(1:825,abs(h2));hold on;
[h3,w]=freqz(b(3,:),a(3,:),825);
plot(1:825,abs(h3));hold on;
[h4,w]=freqz(b(4,:),a(4,:),825);
plot(1:825,abs(h4));hold on;
[h5,w]=freqz(b(5,:),a(5,:),825);
plot(1:825,abs(h5));hold on;
[h6,w]=freqz(b(6,:),a(6,:),825);
plot(1:825,abs(h6));hold on;
[h7,w]=freqz(b(7,:),a(7,:),825);
plot(1:825,abs(h7));hold on;
[h8,w]=freqz(b(8,:),a(8,:),825);
plot(1:825,abs(h8));hold on;
plot(s,'r')
hold on
grid
num=max(size(s));
h1=abs(h1)';
h2=abs(h2)';
h3=abs(h3)';
h4=abs(h4)';
h5=abs(h5)';
h6=abs(h6)';
h7=abs(h7)';
h8=abs(h8)';
subplot(234)
s1=s.*h1;
plot(1:max(size(s1)),s1,'r')
axis([0 600 0 1])
title('0通道')
grid
subplot(235)
s1=s.*h2;
plot(1:max(size(s1)),s1,'r')
axis([0 600 0 1])
title('1通道')
grid
subplot(236)
s1=s.*h4;
plot(1:max(size(s1)),s1,'r')
axis([0 600 0 1])
title('3通道')
grid