% 线阵，MIMO先匹配滤波在波束形成
% '表示转置共轭
%%%%%带宽超过2%基本就没法用窄带模型了
clc;clear all;close all;
c=3e8; 
B=c/2/10;% 距离分辨力：100m   带宽B
fs=10*B; 
lambda0=0.6;% 波长： 0.03m

dx=lambda0/2;%%%
fc=c/lambda0;%10GHz 
f_interval=B;% 波形频率间隔： 4.5MHz
fm=fc+(0:4)*f_interval;%子阵个数
lambda=c./fm;
M=length(fm);
daiguan=100*(B)/fc%%%%%带宽超过2%基本就没法用窄带模型了
%%%%%%%%产生基带信号%%%%%%%%%%
T=0.1e-3;  % 子脉冲宽度：0.1e-3s
delta_t=1/fs;
t=(-T/2:delta_t:T/2);  
f=((-(length(t)-1)/2:(length(t)-1)/2)*fs/length(t)); 
K=B/T;       %线性调频率
LFM_band=exp(j*pi*K*t.^2)+10*randn(1,length(t))+10*sqrt(-1)*randn(1,length(t));  %N=randn(sensor_number,snap)+i*randn(sensor_number,snap)
figure
plot(f,abs(fftshift(fft(LFM_band))),'k')
figure
real1=real((LFM_band));
plot(t,real((LFM_band)),'-d')
%%%%%%%%%%%%单个子阵列波束合成%%%%%%%%%%%%
array_number_x=5;%单个阵列阵元数
target_coordinate=[3000 4000 5000];
theta=atan(target_coordinate(:,3)./(sqrt((target_coordinate(:,1)).^2+(target_coordinate(:,2)).^2)));%0*pi/180;
phi=asin(target_coordinate(:,1)./(sqrt((target_coordinate(:,1)).^2+(target_coordinate(:,2)).^2)));%0*pi/180
theta=23*pi/180;
A=exp(j*2*pi*(0:array_number_x-1)'*dx/lambda0*(sin(theta)));%%%子阵内导向列向量
D=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(theta))./lambda(1:M)');%%%子阵间发射导向列向量

theta*180/pi
phi*180/pi
R0=sqrt((target_coordinate(1)).^2+(target_coordinate(2)).^2+(target_coordinate(3)).^2);
tao=2*R0/c;
%%%%%发射端和信号SP
% D=ones(M,1);% 
temp_echo=[];S=[];
for k=1:M%%%第k个子阵
    %temp_echo=LFM_band.*exp(1i*2*pi*fm(k)*t);0*
    tao0(k)=array_number_x*(k-1)*dx*(sin(theta))/c;
    temp_echo=exp(j*pi*K*(t-1*tao+tao0(k)).^2).*exp(j*2*pi*fm(k)*(t-1*tao+tao0(k)));
    S=[S;temp_echo];
end
SP=D.'*S;%0.197148572882893 - 0.639565863401463i

figure
plot(f,abs(fftshift(fft(SP))),'k')

    

%%%和信号时移2*R0/C
% SPR=ifft(fft(SP).*exp(-j*2*pi*f*2*R0/c));
% figure
% plot(f,abs(fftshift(fft(SPR))),'k')

%%%各子阵接收信号 x中每一行代表一个子阵参考面接收信号   回波的时候对应的lamda是多少呢？（多个正交信号的和）lambda0
D1=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(theta))./lambda0);
x=D1*SP;%%%
figure
plot(f,abs(fftshift(fft(x(1,:)))),'k')
%先滤波再搜索
%%3.1滤波器
filter_band1=sinc(2*B*t);

% %%3.2回波滤波  每一列对应于一个子阵输出，对一列进行波束形成即子阵内接收波束形成
zr=[];
echo_filter=[];
%%%调用函数得到脉冲压缩信号   zr中每一列表示一个子阵分离出的信号
for km=1:M
[y(:,km) result_compression]=compression(x(km,:),M,fm,t,filter_band1,LFM_band);
end 

zrcomsention=[];
for m=1:M
    
    zr(m,:)=y(m,:).*exp(j*2*pi*(tao)*(m-1)*f_interval);%%%预先补偿掉由不同载频带来的误差m*tao*f_interval   
          
end




%%%各子阵接收信号 y中每一行对应一个子阵的和信号
y=[];F=[];
tfai=(-90:90)*pi/180;
E=zeros(M,length(tfai));
for kw=1:length(tfai)


E=[];
  E=exp(j*2*pi*(0:M-1).'*dx*(sin(tfai(kw)-sin(theta)))./lambda0); %D=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(theta))./lambda(1:M)')
   
  zrcomsention=mean(E).*zr;  

%%%对y的某一行进行滤波，得到各正交信号，sm(t);

%%3 谱域分离滤波
% %%3.1滤波器
% filter_band1=sinc(2*B*t);
% % filter_fft1=[];filter_fft1=abs(fft(filter_band1));
% % filter_fft2=fftshift(filter_fft1);
% % figure
% % plot(f,(filter_fft2/max(filter_fft2)),'r')
% % 
% % %%3.2回波滤波  每一列对应于一个子阵输出，对一列进行波束形成即子阵内接收波束形成
% zr=[];
% echo_filter=[];
% %%%调用函数得到脉冲压缩信号   zr中每一列表示一个子阵分离出的信号
% for km=1:M
% [zr(:,km) result_compression]=compression(y(km,:),M,fm,t,filter_band1,LFM_band);
% end 
% 
% zrcomsention=[];
% for m=1:M
%     
%     zrcomsention(m,:)=zr(m,:).*exp(j*2*pi*(tao)*(m-1)*f_interval);%%%预先补偿掉由不同载频带来的误差m*tao*f_interval   
%           
% end




%%%一个子阵中的波束形成
  Dx=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(tfai(kw)))./lambda(1:M)');  
  Dx3=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(tfai(kw)))./lambda0); 
  F(kw)=(Dx')*zrcomsention(:,1);     %mean(abs(zr(:,1)))%%%子阵波束形成
  G(kw)=(Dx')*zrcomsention*conj(Dx3);%%%全维波束形成
end


figure
plot(tfai*180/pi,db(abs(F)/max(abs(F))))
hold on
plot(tfai*180/pi,db(abs(G)/max(abs(G))),'m')



