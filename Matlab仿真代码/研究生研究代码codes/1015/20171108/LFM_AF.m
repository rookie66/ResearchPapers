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
phi = 2*pi*f0*t+pi*k*t.^2;
%u1 = exp(j*phi);
u = cos(phi);

%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%LFM�źŵ�ģ��������Ambiguity Function��
tao = -Tp:10*Ts:Tp;%ʱ���ӳٷ�Χ
tao3 = -Tp:10*Ts:Tp;%ʱ���ӳٷ�Χ
v_range = B/1e5;  
v_range3 = B;  
v = linspace(0,v_range,length(tao));%������Ƶ�Ƶķ�Χ
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
mesh(tao*1e6,v/1e6,abs(AF))  %����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')
AF_New = 20*log10(abs(AF)*10000+eps);
view(3)
figure(13)
colormap jet;
AF_New(find(AF_New<0))=0;
mesh(tao*1e6,v,AF_New)%����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')
axis([-10,10,0,100,0,100])

%%
figure(13)  % ����ģ��ͼ���ٶ�ģ��ͼ
subplot(211)%������ģ��ͼ
plot(tao2*1e6,abs(AF_range))
title('LFM�źŵľ���ģ��ͼ'),xlabel('ʱ��(\mus)'),ylabel('��ֵ')
AF_range_dB = 20*log10(abs(AF_range*10000+eps));

subplot(212)
plot(v2/1e6,abs(AF_v)) %���ٶ�ģ��ͼ
title('LFM�źŵ��ٶ�ģ��ͼ'),xlabel('Ƶ��(MHz)'),ylabel('��ֵ')
% view(2)�Ϳ��Կ���x-yƽ��ͶӰ