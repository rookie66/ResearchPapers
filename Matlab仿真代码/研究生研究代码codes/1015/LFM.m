clear,clc,close all
Fs = 500e6;% ����Ƶ��Ϊ500MHz
Ts = 1/Fs;%�������2ns
Tp = 10e-6;%LFM�źų���Ϊ10΢��
N = round(Tp/Ts);%��������
f0 = 0;%��ʼƵ��Ϊ0
B = 10e6;%�ź�Ƶ�ʴ���10MHz
k = B/Tp;%Ƶ������б��
t = 0:Ts:Tp;%��ɢʱ���ź�
f = f0 + k*t;
figure(1)
plot(t*1e6,f/1e6)
xlabel('ʱ�䣨΢�룩'),ylabel('Ƶ�ʣ�MHz��'),title('Ƶ��-ʱ��仯')
phi = 2*pi*f0*t+pi*k*t.^2;
figure(2)
plot(t*1e6,phi/pi/2)
xlabel('ʱ�䣨΢�룩'),ylabel('��λ��2*pi rad��'),title('��λ-ʱ��仯')
%u1 = exp(j*phi);
u = cos(phi);
figure(3)
plot(t*1e6,u)
xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('LFM�ź�-ʱ��仯')
figure(4)
F = fft(u(1:N))/N*2;
F = fftshift(F);
f = -Fs/2:Fs/N-1:Fs/2;
plot(f(1:N)/1e6,abs(F(1:N)))
xlabel('Ƶ�ʣ�MHz��'),ylabel('��ֵ'),title('LFMƵ�׷���')
axis([-50,50,0,0.2])
%[Ru Rt] = xcorr(u,'unbiased');%�ص���������ĸ���Ǽ�
%[Ru Rt] = xcorr(u,'biased');%���ԵĶ���N
[Ru,Rt] = xcorr(u,'coeff');%�ص���������ĸ���Ǽ�
Rt = Rt*Ts;
figure(5)
plot(Rt*1e6,abs(Ru))
xlabel('ʱ�䣨΢�룩'),ylabel('Ru'),title('LFM�ź�����غ���(����xcorr����)');
tao = -Tp:Ts:Tp;
Rtao = sinc(k*pi*tao.*(Tp-abs(tao))).*(Tp-abs(tao))/Tp;
%fclo([1,2,3,4])
figure(6)
plot(tao*1e6,abs(Rtao))
xlabel('ʱ�䣨\mu�룩'),ylabel('Rtao'),title('LFM�ź�����غ���(���ù�ʽ��');

Ntao = 2500;
t2 = [zeros(1,Ntao),t];%��ɢʱ���ź�
t3 = [t,zeros(1,Ntao)];%��ɢʱ���ź�
phi2 = 2*pi*f0*t2+pi*k*t2.^2;
phi3 = 2*pi*f0*t3+pi*k*t3.^2;
u2 = cos(phi2);
u3 = cos(phi3);
[Ru2,Rt2] = xcorr(u2,u3);%�ص���������ĸ���Ǽ�
Rt2 = Rt2(Ntao+1:end)*Ts;
figure(7)
plot(Rt2*1e6,abs(Ru2(Ntao+1:end)))
xlabel('ʱ�䣨΢�룩'),ylabel('Ru2'),title('LFM�źŻ���غ���(����xcorr����)');
axis([-5,15,0,3000])
xlabel('ʱ�䣨\mu�룩'),ylabel('Ru23'),title('����xcorr�������ƥ�䣬�ӳ�5\mu s')

[Ru23,N]=CroCorr(u2,u3);%%����FFTʵ��u2��u3�Ļ����
figure(8)
t8 = ((0:(N-1))-N/2)*Ts;
plot(t8*1e6,abs(Ru23))
axis([-5,15,0,3000])
xlabel('ʱ�䣨\mu�룩'),ylabel('Ru23'),title('����FFT�������ƥ�䣬�ӳ�5\mu s')
%PSD
figure(9)
[PSD,F_psd] = periodogram(u,[],[-50e6,50e6],Fs);
plot(F_psd,PSD)
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%LFM�źŵ�ģ��������Ambiguity Function��
tao = -Tp:10*Ts:Tp;%ʱ���ӳٷ�Χ
tao3 = -Tp:10*Ts:Tp;%ʱ���ӳٷ�Χ
v_range = B/1e2;  
v_range3 = B;  
v = linspace(-v_range,v_range,length(tao));%������Ƶ�Ƶķ�Χ
v3 = linspace(-v_range3,v_range3,length(tao));%������Ƶ�Ƶķ�Χ3
[tao,v]=meshgrid(tao,v);
[tao3,v3]=meshgrid(tao3,v3);
% LFM�źŵ�Ambiguity Function ģ������
AF = sinc((v-k*tao).*(Tp-abs(tao))).*(Tp-abs(tao))/Tp;%ģ������
AF3 = sinc((v3-k*tao3).*(Tp-abs(tao3))).*(Tp-abs(tao3))/Tp;%ģ������
%LFM�źŵľ���ģ������
tao2 = -Tp:10*Ts:Tp;%ʱ���ӳٷ�Χ
AF_range = sinc(-k*pi*tao2.*(Tp-abs(tao2))/pi).*(Tp-abs(tao2))/Tp;
%LFM�źŵ��ٶ�ģ������
v2 = -B:100:B;%������Ƶ�Ƶķ�Χ
AF_v = sinc(Tp*v2);


figure(11)
colormap jet;
mesh(tao*1e6,v/1e6,abs(AF))%����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')

%view(2)
figure(12)
colormap jet;
mesh(tao3*1e6,v3/1e6,abs(AF3))%����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')
view(2)
figure(13)  % ����ģ��ͼ���ٶ�ģ��ͼ
subplot(211)%������ģ��ͼ
plot(tao2*1e6,abs(AF_range))
title('LFM�źŵľ���ģ��ͼ'),xlabel('ʱ��(\mus)'),ylabel('��ֵ')
subplot(212)
plot(v2/1e6,abs(AF_v)) %���ٶ�ģ��ͼ
title('LFM�źŵ��ٶ�ģ��ͼ'),xlabel('Ƶ��(MHz)'),ylabel('��ֵ')
% view(2)�Ϳ��Կ���x-yƽ��ͶӰ


%% ����FFT���������ܶȷ���PSD������periodogram)
close all

x = u;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;
plot(freq*1e-6,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (MHz)')
ylabel('Power/Frequency (dB/Hz)')
axis([0,50,-150,0])

