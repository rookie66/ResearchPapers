clear all;close ;clc
 Fs=10e6;
 t=0:1/Fs:300e-6;
 fr=4e3;
 f0=8.5e7;
 x1=square(2*pi*fr*t,8)./2+0.5;
 x2=exp(i*2*pi*f0*t); x3=x1.*x2;
 subplot(2,2,1);
plot(t,x1,'-');
axis([0,310e-6,-1.5,1.5]);
xlabel('时间/s')
ylabel('幅度/v')
title('脉冲信号重复周期T=250US 脉冲宽度为8us ')
grid;
subplot(223);
 plot(t,x2,'-');
 axis([0,310e-6,-1.5,1.5]);
 xlabel('时间/s')
 ylabel('幅度/v')
 title('连续正弦波信号载波频率f0=85MHz ')
 grid;
 eps = 0.000001;
 B = 15.0e6; 
 T = 10.e-6; f0=8.5e7;
 mu = B / T;
 delt = linspace(-T/2., T/2., 10001); 
 LFM=exp(i*2*pi*(f0*delt+mu .* delt.^2 / 2.));
 LFMFFT = fftshift(fft(LFM));
 freqlimit = 0.5 / 1.e-9;
 freq = linspace(-freqlimit/1.e6,freqlimit/1.e6,10001);
 figure(1)
 subplot(2,2,2)
 plot(delt*1e6,LFM,'k');
axis([-1 1 -1.5 1.5])
 grid;
 xlabel('时间/us')
 ylabel('幅度/v')
 
title('线性调频信号T = 10 mS, B = 15 MHz')
 subplot(2,2,4)
 y=20*log10(abs(LFMFFT));
 y=y-max(y);
 plot(freq, y,'k');
 axis([-500 500 -80 10]);
grid;
%axis tight
 xlabel('频率/ MHz')
 ylabel('频谱/dB')
 title('线性调频信号T = 10 mS, B = 15 MHz')
