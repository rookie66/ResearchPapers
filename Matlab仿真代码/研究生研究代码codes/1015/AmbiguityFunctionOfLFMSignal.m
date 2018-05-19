%LFM�źŵ�ģ��������Ambiguity Function��
clear,clc,close all
Fs = 500e6;% ����Ƶ��Ϊ500MHz
Ts = 1/Fs;%�������2ns
Tp = 10e-6;%LFM�źų���Ϊ10΢��
N = round(Tp/Ts);%��������
%f0 = 0;%��ʼƵ��Ϊ0
B = 10e6;%�ź�Ƶ�ʴ���10MHz
k = B/Tp;%Ƶ������б��

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
figure(1)
colormap jet;
mesh(tao*1e6,v/1e6,abs(AF))%����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')
view(2)
figure(2)
colormap jet;
mesh(tao3*1e6,v3/1e6,abs(AF3))%����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')
view(2)
figure(3)  % ����ģ��ͼ���ٶ�ģ��ͼ
subplot(211)%������ģ��ͼ
plot(tao2*1e6,abs(AF_range))
title('LFM�źŵľ���ģ��ͼ'),xlabel('ʱ��(\mus)'),ylabel('��ֵ')
subplot(212)
plot(v2/1e6,abs(AF_v)) %���ٶ�ģ��ͼ
title('LFM�źŵ��ٶ�ģ��ͼ'),xlabel('Ƶ��(MHz)'),ylabel('��ֵ')
% view(2)�Ϳ��Կ���x-yƽ��ͶӰ


%%
figure(5) 
colormap winter;
contourf(abs(AF),10)%���ڵȸ��߻���ͼ��
%%
figure(6)
contourf(peaks,10)%���ڵȸ��߻���ͼ��





