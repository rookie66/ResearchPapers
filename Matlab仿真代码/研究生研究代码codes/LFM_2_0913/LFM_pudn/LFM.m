%���Ե�Ƶ
clear al;
close all;
clc;

BT=50;                                      %ʱ������
T=1;                                        %��һ������
B=BT/T;                                     %��Ƶ����
Fs=50*B;Ts=1/Fs;                            %�����������
t=-1:Ts:1;
xt=exp(1j*pi*B*t.^2/T);                     %���Ե�Ƶ�ź�
figure(1)
plot(t,real(xt));
xlabel('��һ��ʱ��t/T');ylabel('����');
title('BT��Ϊ50ʱ��LFM��ʱ����');

BT=100;                                     %ʱ������
T=1;                                        %��һ������
B=BT/T;                                     %��Ƶ����
Fs=20*B;Ts=1/Fs;                            %�����������
N=T/Ts;                                     %�������������
t=linspace(-T/2,T/2,N);
xt=exp(1j*pi*B/T*t.^2);                     %���Ե�Ƶ�ź�
X=fftshift(abs(fft(xt)));                   %���Ե�Ƶ�źŵĸ���Ҷ�任
f=linspace(-Fs/(max(Fs)),Fs/(max(Fs)),N);   
n=N*B/Fs;
f=-n*Fs:Fs:n*Fs;                            %ȡƵ���е�һ������ʾ
f=f/max(f);                                 %Ƶ�ʹ�һ��
figure(2)
X=X/(max(X));                               %���ȹ�һ��
plot(f,X(N/2-n:N/2+n));
xlabel('��һ��Ƶ��F/B');ylabel('����');
title('BT��Ϊ100ʱ��LFMƵ��');
Ht=exp(-1j*pi*B/T*t.^2);                    %ƥ���˲�����λ�弤��Ӧ
Sot=abs(conv(xt,Ht));                       %ƥ���˲����
L=2*N-1;                                    %ƥ���˲����ʱ�򳤶�
t1=linspace(-T,T,L);
Sot=Sot/(max(Sot));                         %���ȹ�һ��
figure(3)
plot(t1,Sot);
xlabel('��һ��ʱ��t/T');ylabel('��һ������');
title('BT��Ϊ100ʱ��LFMƥ���˲�������');
N0=T/20/Ts;
figure(4)
t2=-N0*Ts:Ts:N0*Ts;
plot(t2,Sot(N-N0:N+N0));                    %ȡƥ���˲���ʱ���һ���ֽ�����ʾ
xlabel('��һ��ʱ��t/T');ylabel('��һ������');
title('ƥ���˲�������---���Ĳ��ַŴ�ͼ');



