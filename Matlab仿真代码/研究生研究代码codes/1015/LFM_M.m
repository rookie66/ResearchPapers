clear,clc,close all
Fs = 500e6;% ����Ƶ��Ϊ500MHz
Ts = 1/Fs;%�������2ns
Tp = 10e-6;%LFM�źų���Ϊ10΢��
N = round(Tp/Ts);%��������
f0 = 0;%��ʼƵ��Ϊ0
B = 10e6;%�ź�Ƶ�ʴ���10MHz
k = B/Tp;%Ƶ������б��
t = 0:Ts:Tp;%��ɢʱ���ź�
phi = 2*pi*f0*t+pi*k*t.^2;
u = cos(phi);
%***************************����������M���н�����λ�ı�*******************************************************

phi_deta = pi/12;
M1 = My_M_Seq([0,1,1,0,1,1],[1,0,0,0,1,1]);
M2 = My_M_Seq([0,1,1,0,1,1],[0,0,0,0,0,1]);
for i = 1:length(M1)
    if M1(i)==0
        M1(i)=-1;
    end
end
for i = 1:length(M1)
    if M2(i)==0
        M2(i)=-1;
    end
end
message = zeros(1,158);
for i = 1:158
    if mod(i,3)==1
         message(i)= 1;
    end
    if mod(i,5)==1
         message(i)= 1;
    end
end
message1 = message(1:79);
message2 = message(80:158);
N_Ms = length(M1);
phiM = phi;
for i = 1:length(message1)
    if message1(i)==1
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)+M1*phi_deta;
    else if message1(i)==0
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)-M1*phi_deta;   
        end
    end
end
for i = 1:length(message2)
    if message2(i)==1
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)+M1*phi_deta;
    else if message2(i)==0
         phiM(((i-1)*N_Ms+1):i*N_Ms) = phiM(((i-1)*N_Ms+1):i*N_Ms)-M1*phi_deta;   
        end
    end
end

%#################��λ-ʱ��ͼ�����#################################
figure(1)%��λ-ʱ��ͼ�����
subplot(211)
plot(t*1e6,phi);
xlabel('ʱ�䣨΢�룩'),ylabel('��λ'),title('��λ-ʱ��仯��LFM��')
subplot(212)
plot(t*1e6,phiM)
xlabel('ʱ�䣨΢�룩'),ylabel('��λ'),title('��λ-ʱ��仯��LFM-M��')

%#################LFM�ź�-ʱ��ͼ�����#############################
u2 = cos(phiM);
figure(2)%LFM�ź�-ʱ��ͼ�����
subplot(211)
plot(t*1e6,u)
xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('LFM�ź�-ʱ��仯��LFM��')
subplot(212)
plot(t*1e6,u2)
xlabel('ʱ�䣨΢�룩'),ylabel('��ֵ'),title('LFM�ź�-ʱ��仯��LFM-M��')


%**********************����غ���******************************************
%[Ru Rt] = xcorr(u,'unbiased');%�ص���������ĸ���Ǽ�
%[Ru Rt] = xcorr(u,'biased');%���ԵĶ���N
[Ru,Rt] = xcorr(u,'coeff');%�ص���������ĸ���Ǽ�
[Ru2,Rt2] = xcorr(u2,'coeff');%�ص���������ĸ���Ǽ�
Rt = Rt*Ts;
Rt2 = Rt2*Ts;
figure(3)
subplot(211)
plot(Rt*1e6,abs(Ru))
xlabel('ʱ�䣨΢�룩'),ylabel('Ru'),title('LFM�ź�����غ���(����xcorr����)');
subplot(212)
plot(Rt2*1e6,abs(Ru2))
xlabel('ʱ�䣨΢�룩'),ylabel('Ru'),title('LFM�ź�����غ���(����xcorr����)');
%#############LFM�ź�Ƶ�׷���###########################
figure(4) %LFM�ź�Ƶ�׷���
F = fft(u(1:N))/N*2;
F2 = fft(u2(1:N))/N*2;
F = fftshift(F);
F2 = fftshift(F2);
f = -Fs/2:Fs/N-1:Fs/2;
subplot(211)
plot(f(1:N)/1e6,abs(F(1:N)))
xlabel('Ƶ�ʣ�MHz��'),ylabel('��ֵ'),title('LFMƵ�׷���(LFM)')
axis([-50,50,0,0.2])
subplot(212)
plot(f(1:N)/1e6,abs(F2(1:N)))
xlabel('Ƶ�ʣ�MHz��'),ylabel('��ֵ'),title('LFMƵ�׷���(LFM-M)')
axis([-50,50,0,0.2])

%######################LFM�źŵ�PSD���������##############################


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
mesh(tao*1e6,v/1e6,abs(AF3))%����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(MHz)'),zlabel('��ֵ')
%view(2)

figure(13)  % ����ģ��ͼ���ٶ�ģ��ͼ
subplot(211)%������ģ��ͼ
plot(tao2*1e6,abs(AF_range))
axis([-2,2,0,1])

title('LFM�źŵľ���ģ��ͼ'),xlabel('ʱ��(\mus)'),ylabel('��ֵ')
subplot(212)
plot(v2/1e6,abs(AF_v)) %���ٶ�ģ��ͼ
title('LFM�źŵ��ٶ�ģ��ͼ'),xlabel('Ƶ��(MHz)'),ylabel('��ֵ')
axis([-2,2,0,1])
%view(2)%�Ϳ��Կ���x-yƽ��ͶӰ




