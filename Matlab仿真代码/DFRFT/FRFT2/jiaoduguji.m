%%三维互谱估计器估计目标方位误差分析(周期图法)

%角度变化 水平方位角从60度到120度 俯仰角从5度到65度 信噪比为15dB
%50次统计平均

clc
clear all
close all
%常量设置
fl=400;
fh=1000;
fs=4000;
ts=2.5;
point=ts*fs+1;

t=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据

n1=2*point-1;%????线性卷积或相关后点数，
n2=1:n1;
thetao2=50:100;%水平方位角
thetao1=5:55;%俯仰角


theta1=thetao1*pi/180;%俯仰角
theta2=thetao2*pi/180;%水平方位角
snr=15;
%滤波器
b=fir1(256,[fl/(fs/2),fh/(fs/2)]);
numc=50;%50次统计平均
nums=length(thetao1);
for k=1:nums%k为离散角度值
    for k1=1:numc%k1为统计平均次数
%造信号
signal=chirp(t,700*S,ts/2,900);
noise=normrnd(0,1,1,point);
nx=normrnd(0,1,1,point);
ny=normrnd(0,1,1,point);
nz=normrnd(0,1,1,point);
%加信噪比


b1=10^(snr/20);  
a1=std(signal);
a2=std(noise);
n=a2*b1/a1;
signal1=n*signal;
%生成最终信号
p=signal1+noise;
%通过滤波器
p1=conv(b,p);
p2=p1(129:1:point+128);

vx=signal1*cos(theta2(k))*cos(theta1(k))+nx;
vx1=conv(b,vx);
vx2=vx1(129:1:point+128);

vy=signal1*sin(theta2(k))*cos(theta1(k))+ny;
vy1=conv(b,vy);
vy2=vy1(129:1:point+128);

vz=signal1*sin(theta1(k));
vz1=conv(b,vz);
vz2=vz1(129:1:point+128);


%周期图算法，窗长100点，重叠一半均匀滑动，窗个数199
zu=100;
k2=199;%窗个数
add=50;%?????????????????滑动一半
for k3=1:k2
    s1=1+add*(k3-1);
    s2=zu+add*(k3-1);  
    p3=p2(s1:s2);
    vx3=vx2(s1:s2);
    vy3=vy2(s1:s2);
    vz3=vz2(s1:s2);
    p4=fft(p3);
    vx4=fft(vx3);
    vy4=fft(vy3);
    vz4=fft(vz3);
    pvx=p4.*conj(vx4);
    pvy=p4.*conj(vy4);
    pvz=p4.*conj(vz4);
    pvx1(k3,:)=real(pvx);
    pvy1(k3,:)=real(pvy);
    pvz1(k3,:)=real(pvz);
end
pvx2=mean(pvx1);%窗中100点数的均值
pvy2=mean(pvy1);
pvz2=mean(pvz1);

pvx3=mean(pvx2);%所有窗一起的均值
pvy3=mean(pvy2);
pvz3=mean(pvz2);

thetaf1(k1,k)=atan(pvz3/(sqrt(pvx3^2+pvy3^2)));
thetas1(k1,k)=atan2(pvy3,pvx3);
%化成角度，k1为统计平均的次数，k为离散角度值
thetaf2(k1,k)=thetaf1(k1,k)*180/pi;
thetas2(k1,k)=thetas1(k1,k)*180/pi;
%统计误差
errors1(k1,k)=thetas2(k1,k)-theta2(k)*180/pi;
errors2(k1,k)=errors1(k1,k)^2;

errorf1(k1,k)=thetaf2(k1,k)-theta1(k)*180/pi;
errorf2(k1,k)=errorf1(k1,k)^2;
end
errors3(k)=mean(errors2(:,k));
errorf3(k)=mean(errorf2(:,k));


end

errors4=sqrt(errors3);
errorf4=sqrt(errorf3);
thetaf=theta1*180/pi;
thetas=theta2*180/pi;


figure;
plot(thetas,errors4)


grid on
xlabel('目标真实角度')
ylabel('方位标准差 单位：度')
title('不同角度下估计目标水平方位角误差分析')
figure;
plot(thetaf,errorf4)


grid on
xlabel('目标真实角度')
ylabel('方位标准差 单位：度')
title('不同角度下估计目标俯仰角误差分析')