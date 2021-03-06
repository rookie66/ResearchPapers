%目标信号为chirp signal f0=7000,B=1750,T=0.5845,fs=4*f0;
%滤波器，噪声的功率改成dbHz
clc
clear all
close all
%常量设置
f0=7000;
B=1750;
fs=4*f0;

ts=0.5845;
t=-1*ts/2:1/fs:ts/2;
alfa=pi/4;
alfa11=45;
point=ts*fs+1;

snr=-15:0;
%滤波器
b=fir1(256,[(f0-B/2)/(fs/2),(f0+B/2)/(fs/2)]);
for k1=1:length(snr)
    for k=1:20
        signal=exp(i*2*pi*(f0-B/2)*t+i*pi*(B/ts)*t.*t);
        noise=normrnd(0,1,1,point);
        nx=normrnd(0,1,1,point);
        ny=normrnd(0,1,1,point);
        %  信噪比db/Hz
        b1=10^(snr(k1)/10);  
         a1=std(signal);
         a2=std(noise);
         n=sqrt(b1*a2/a1);
        signal1=n*signal;
        p=signal1+noise;
        
        
        %通过滤波器
        p1=conv(b,p); 
        p2=p1(129:1:point+128); 

        vx=signal1*cos(alfa)+nx;
        vx1=conv(b,vx);
        vx2=vx1(129:1:point+128);

        vy=signal1*sin(alfa)+ny;
        vy1=conv(b,vy);
        vy2=vy1(129:1:point+128);
%周期图算法，窗长512点，重叠后64点均匀滑动，窗个数124
        zu=512;
        k2=61;%窗个数
        add=256;%?????????????????滑动512-64
        for k3=1:k2
            s1=1+add*(k3-1);
            s2=zu+add*(k3-1);  
            p3=p2(s1:s2);
            vx3=vx2(s1:s2);
            vy3=vy2(s1:s2);
          
            p4=fft(p3);
            vx4=fft(vx3);
            vy4=fft(vy3);

   
            pvx=p4.*conj(vx4);
            pvy=p4.*conj(vy4);


            pvx1(k3,:)=real(pvx);
            pvy1(k3,:)=real(pvy);        
        end
        pvx2=mean(pvx1);
        pvy2=mean(pvy1);
        
        pvx3=mean(pvx2);
        pvy3=mean(pvy2);
        alfa1(k)=atan(pvy3/pvx3)*180/pi;%k1为信噪比，k为统计次数
       

    end
    alfa2(k1)=mean(alfa1);
     error1=(alfa1-45);
    error2(k1)=sqrt(mean(error1.^2));
end

plot(snr,error2,'*');
dy=(1/(6*B*ts))*(1./(10.^(snr/10)));%水平角度的CRB为1/（3*M*sina^2*snr）
hold on ;
plot(snr,sqrt(dy)*180/pi);
xlabel('信噪比')
ylabel('方位标准差 单位：度')
title('互谱滑动窗水平方位角误差分析')
% errorlog=log10(error2);
% plot(snr,error2,'*');
% grid on
% xlabel('信噪比')
% ylabel('方位标准差 单位：度')
% title('fft不同信噪比下估计目标水平方位角误差分析')