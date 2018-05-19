%FRFT
%50次统计平均

clc
clear all
close all
%常量设置
f0=5000;
B=2000;
fs=4*f0;

ts=0.5;
t=-1*ts/2:1/fs:ts/2;
alfa=pi/6;
alfa11=30;


t=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据
point=ts*fs+1;

a=atan(-1/(S*S*B/ts))*2/pi+4;
snr=-25:2:5;

%滤波器
b=fir1(256,[(f0-B/2)/(fs/2),(f0+B/2)/(fs/2)]);
for k=1:length(snr)%k为snr;
    k
    for k1=1:500%k1为统计平均次数
%造信号
        signal=exp(i*2*pi*(f0)*tt*S+i*pi*(B/ts)*tt.*tt*S*S);
        noise=normrnd(0,1,1,point);
        nx=normrnd(0,1,1,point);
        ny=normrnd(0,1,1,point);

        %加信噪比
        %信噪比db/Hz
        b1=10^(snr(k)/10);  
        a1=std(signal);
        a2=std(noise);
        n=sqrt(b1*a2/a1);

        signal1=n*signal;
        p=signal1+noise;

        %通过滤波器
%         p1=conv(b,p); 
%         p2=p1(129:1:point+128); 

        vx=signal1*cos(alfa)+nx;
%         vx1=conv(b,vx);
%         vx2=vx1(129:1:point+128);

        vy=signal1*sin(alfa)+ny;
%         vy1=conv(b,vy);
%         vy2=vy1(129:1:point+128);
%时域
%         sypvy=mean(real(p.*conj(vy)));
%         sypvx=mean(real(p.*conj(vx)));
%         syalfa1(k1)=atan(sypvy/sypvx)*180/pi;
%频域
        p3=fft(p);
        vx3=fft(vx);
        vy3=fft(vy);
        
        pvy=real(p3.*conj(vy3));
        pvx=real(p3.*conj(vx3));
        pvx1=mean(pvx(2500-B/4:2500+B/4));
        pvy1=mean(pvy(2500-B/4:2500+B/4));
        alfa1(k1)=atan(pvy1/pvx1)*180/pi;
  
 %分数阶域       
        frp3=frft(p,a);
        frvx3=frft(vx,a);
        frvy3=frft(vy,a);
        frpvy=real(frp3.*conj(frvy3));
        frpvx=real(frp3.*conj(frvx3));
        [Cx,Ix]=max(frpvx);
        [Cy,Iy]=max(frpvy);
        frpvy1=mean(frpvy(Iy-15:Iy+15));
        frpvx1=mean(frpvx(Ix-15:Ix+15));
        fralfa1(k1)=atan(frpvy1/frpvx1)*180/pi; 

        
 
        
    end
%     频域
    alfa2(k)=mean(alfa1);
    error1=(alfa1-alfa11);
    error2(k)=sqrt(mean(error1.^2));
%     时域;
%     syalfa2(k)=mean(syalfa1);
%     syerror1=syalfa1-alfa11;
%     syerror2(k)=sqrt(mean(syerror1.^2));
%    分数阶域
    fralfa2(k)=mean(fralfa1);
    frerror1=fralfa1-alfa11;
    frerror2(k)=sqrt(mean(frerror1.^2));
end


figure,
plot(snr,error2,'-*');
hold on 
% plot(snr,syerror2,'-d');
% hold on
plot(snr,frerror2,'-o');

xlabel('输入信噪比/（dB）')
ylabel('方位估计标准偏差/（°）')

figure,
plot(snr,alfa2,'-*')%频域
hold on 
% plot(snr,syalfa2,'-d');%时域
% hold on 
plot(snr,fralfa2,'-o');%分数阶域
xlabel('输入信噪比/（dB）')
ylabel('估计方位/（°）')
