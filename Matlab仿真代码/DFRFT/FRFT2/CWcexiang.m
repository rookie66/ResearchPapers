%目标信号为CW平面波，f0=500，B=1000，积分时间为1s，M=2BT=2
%滤波器，噪声的功率改成dbHz
clc
clear all
close all
%常量设置
f0=7000;
B=1750;
fs=4*f0;


ts=0.5845;

t=0:1/fs:ts;
point=ts*fs+1;

alfa=pi/4;
point=ts*fs+1;
t=0:1/fs:ts;
snr=-2:25;


%滤波器
b=fir1(256,[(f0-B/2)/(fs/2),(f0+B/2)/(fs/2)]);
for k1=1:length(snr)
    for k=1:30
        signal=cos(2*pi*f0*t);
        noise=normrnd(0,1,1,point);
        nx=normrnd(0,1,1,point);
        ny=normrnd(0,1,1,point);
        %  信噪比db/Hz
        b1=10^(snr(k1)/10);  
        a1=std(signal);
        a2=std(noise);
        n=b1*a2/a1;
%         n=sqrt(b1*4*(std(noise)^2)/point);
        signal1=n*signal;
        p=signal1+noise;
        vx=signal1*cos(alfa)+nx;
        vy=signal1*sin(alfa)+ny;
        
     snrpiji(k1)=10*log10((std(signal1)^2*point/2)/(std(noise)^2));
        
        %通过滤波器
        p1=conv(b,p); 
        p2=p1(129:1:point+128); 

        vx=signal1*cos(alfa)+nx;
        vx1=conv(b,vx);
        vx2=vx1(129:1:point+128);

        vy=signal1*sin(alfa)+ny;
        vy1=conv(b,vy);
        vy2=vy1(129:1:point+128);

        
        p3=fft(p2);
        vx3=fft(vx2);
        vy3=fft(vy2);

        pvx=p3(1:8000).*conj(vx3(1:8000));
        pvy=p3(1:8000).*conj(vy3(1:8000));
        
%         f=(0:fix(point/2)-1)*fs/point;
%         x=abs(pvy);
%         plot(f,x(1:fix(point/2)));
%         [NMaxx,pvxmax]=max(abs(pvx));
%         [NMaxy,pvymax]=max(abs(pvy));
%         pvx1=real(mean(pvx(pvxmax-5:pvxmax+5)));
%         pvy1=real(mean(pvy(pvymax-5:pvymax+5)));

        pvx1=real(mean(pvx));
        pvy1=real(mean(pvy));
        alfa1(k)=atan(pvy1/pvx1);%虚部能量很小
        error1(k)=(alfa1(k)-alfa)*180/pi;
    end
    error(k1)=sqrt(mean(error1.^2));
    alfa2(k1)=mean(alfa1);
end

plot(snr,error,'*');

 dy=1./(3*2*10.^(snrpiji/10));
 dydu=sqrt(dy)*180/pi;
 hold on 
plot(snr,dydu);