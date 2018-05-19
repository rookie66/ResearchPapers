%%

%FRFT
%50次统计平均

clc
clear all
close all
%常量设置
f0=5000;
fs=4*f0;ts=0.5;
B=500:500:4000;
t=-1*ts/2:1/fs:ts/2;
alfa=pi/6;
alfa11=30;
point=ts*fs+1;


t=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据





snr=-10;
%滤波器


for k=1:length(B)%k为snr;
    k
    for k1=1:3%k1为统计平均次数
%造信号
        signal=exp(i*2*pi*(f0-B(k)/2)*tt*S+i*pi*(B(k)/ts)*tt.*tt*S*S);%chirp(t,700*S,ts/2,900);
        noise=normrnd(0,1,1,point);
        nx=normrnd(0,1,1,point);
        ny=normrnd(0,1,1,point);

        %加信噪比
        %信噪比db/Hz
        b1=10^(snr/10);  
        a1=std(signal);
        a2=std(noise);
        n=sqrt(b1*a2/a1);
%         n=sqrt(b1*(std(noise)^2)/point);
        signal1=n*signal;
        p=signal1+noise;
%         snrpuji(k1)=10*log10((std(signal1)^2*point)/(std(noise)^2));

        %通过滤波器
%         p1=conv(b,p); 
%         p2=p1(129:1:point+128); 

        vx=signal1*cos(alfa)+nx;
%         vx1=conv(b,vx);
%         vx2=vx1(129:1:point+128);

        vy=signal1*sin(alfa)+ny;
%         vy1=conv(b,vy);
%         vy2=vy1(129:1:point+128);

        a=atan(-1/(S*S*B(k)/ts))*2/pi+4;      
        p3=frft(p,a);
        vx3=frft(vx,a);
        vy3=frft(vy,a);
%      plot(abs(p3))  ;
%         p3=fft(p);
%         vx3=fft(vx);
%         vy3=fft(vy);

        pvy=real(p3.*conj(vy3));
        pvx=real(p3.*conj(vx3));
%     plot(abs(pvx));
        [Cx,Ix]=max(pvx);
        [Cy,Iy]=max(pvy);
        pvy1=mean(pvy(Iy-15:Iy+15));
        pvx1=mean(pvx(Ix-15:Ix+15));
%         pvx1=mean(pvx);
%         pvy1=mean(pvy);
        alfa1(k1)=atan(pvy1/pvx1)*180/pi;
        
%         alfa1(k1)=atan(pvy/pvx);
       
        
    end

    error1=(alfa1-alfa11);
    error2(k)=sqrt(mean(error1.^2));
%     snrpuji1(k)=mean(snrpuji);

end


figure,
plot(B,error2,'-*')


xlabel('输入信噪比/（dB）')
ylabel('方位估计标准差/（°）')

% figure,
% plot(snr,alfa2,'*')
% hold on 
% plot(snr,alfa2);
% xlabel('输入信噪比/（dB）')
% ylabel('估计方位值/（°）')
