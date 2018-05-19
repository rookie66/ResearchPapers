% ����MIMO��ƥ���˲��ڲ����γ�
% '��ʾת�ù���
%%%%%������2%������û����խ��ģ����
clc;clear all;close all;
c=3e8; 
B=c/2/10;% ����ֱ�����100m   ����B
fs=10*B; 
lambda0=0.6;% ������ 0.03m

dx=lambda0/2;%%%
fc=c/lambda0;%10GHz 
f_interval=B;% ����Ƶ�ʼ���� 4.5MHz
fm=fc+(0:4)*f_interval;%�������
lambda=c./fm;
M=length(fm);
daiguan=100*(B)/fc%%%%%������2%������û����խ��ģ����
%%%%%%%%���������ź�%%%%%%%%%%
T=0.1e-3;  % �������ȣ�0.1e-3s
delta_t=1/fs;
t=(-T/2:delta_t:T/2);  
f=((-(length(t)-1)/2:(length(t)-1)/2)*fs/length(t)); 
K=B/T;       %���Ե�Ƶ��
LFM_band=exp(j*pi*K*t.^2)+10*randn(1,length(t))+10*sqrt(-1)*randn(1,length(t));  %N=randn(sensor_number,snap)+i*randn(sensor_number,snap)
figure
plot(f,abs(fftshift(fft(LFM_band))),'k')
figure
real1=real((LFM_band));
plot(t,real((LFM_band)),'-d')
%%%%%%%%%%%%���������в����ϳ�%%%%%%%%%%%%
array_number_x=5;%����������Ԫ��
target_coordinate=[3000 4000 5000];
theta=atan(target_coordinate(:,3)./(sqrt((target_coordinate(:,1)).^2+(target_coordinate(:,2)).^2)));%0*pi/180;
phi=asin(target_coordinate(:,1)./(sqrt((target_coordinate(:,1)).^2+(target_coordinate(:,2)).^2)));%0*pi/180
theta=23*pi/180;
A=exp(j*2*pi*(0:array_number_x-1)'*dx/lambda0*(sin(theta)));%%%�����ڵ���������
D=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(theta))./lambda(1:M)');%%%����䷢�䵼��������

theta*180/pi
phi*180/pi
R0=sqrt((target_coordinate(1)).^2+(target_coordinate(2)).^2+(target_coordinate(3)).^2);
tao=2*R0/c;
%%%%%����˺��ź�SP
% D=ones(M,1);% 
temp_echo=[];S=[];
for k=1:M%%%��k������
    %temp_echo=LFM_band.*exp(1i*2*pi*fm(k)*t);0*
    tao0(k)=array_number_x*(k-1)*dx*(sin(theta))/c;
    temp_echo=exp(j*pi*K*(t-1*tao+tao0(k)).^2).*exp(j*2*pi*fm(k)*(t-1*tao+tao0(k)));
    S=[S;temp_echo];
end
SP=D.'*S;%0.197148572882893 - 0.639565863401463i

figure
plot(f,abs(fftshift(fft(SP))),'k')

    

%%%���ź�ʱ��2*R0/C
% SPR=ifft(fft(SP).*exp(-j*2*pi*f*2*R0/c));
% figure
% plot(f,abs(fftshift(fft(SPR))),'k')

%%%����������ź� x��ÿһ�д���һ������ο�������ź�   �ز���ʱ���Ӧ��lamda�Ƕ����أ�����������źŵĺͣ�lambda0
D1=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(theta))./lambda0);
x=D1*SP;%%%
figure
plot(f,abs(fftshift(fft(x(1,:)))),'k')
%���˲�������
%%3.1�˲���
filter_band1=sinc(2*B*t);

% %%3.2�ز��˲�  ÿһ�ж�Ӧ��һ�������������һ�н��в����γɼ������ڽ��ղ����γ�
zr=[];
echo_filter=[];
%%%���ú����õ�����ѹ���ź�   zr��ÿһ�б�ʾһ�������������ź�
for km=1:M
[y(:,km) result_compression]=compression(x(km,:),M,fm,t,filter_band1,LFM_band);
end 

zrcomsention=[];
for m=1:M
    
    zr(m,:)=y(m,:).*exp(j*2*pi*(tao)*(m-1)*f_interval);%%%Ԥ�Ȳ������ɲ�ͬ��Ƶ���������m*tao*f_interval   
          
end




%%%����������ź� y��ÿһ�ж�Ӧһ������ĺ��ź�
y=[];F=[];
tfai=(-90:90)*pi/180;
E=zeros(M,length(tfai));
for kw=1:length(tfai)


E=[];
  E=exp(j*2*pi*(0:M-1).'*dx*(sin(tfai(kw)-sin(theta)))./lambda0); %D=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(theta))./lambda(1:M)')
   
  zrcomsention=mean(E).*zr;  

%%%��y��ĳһ�н����˲����õ��������źţ�sm(t);

%%3 ��������˲�
% %%3.1�˲���
% filter_band1=sinc(2*B*t);
% % filter_fft1=[];filter_fft1=abs(fft(filter_band1));
% % filter_fft2=fftshift(filter_fft1);
% % figure
% % plot(f,(filter_fft2/max(filter_fft2)),'r')
% % 
% % %%3.2�ز��˲�  ÿһ�ж�Ӧ��һ�������������һ�н��в����γɼ������ڽ��ղ����γ�
% zr=[];
% echo_filter=[];
% %%%���ú����õ�����ѹ���ź�   zr��ÿһ�б�ʾһ�������������ź�
% for km=1:M
% [zr(:,km) result_compression]=compression(y(km,:),M,fm,t,filter_band1,LFM_band);
% end 
% 
% zrcomsention=[];
% for m=1:M
%     
%     zrcomsention(m,:)=zr(m,:).*exp(j*2*pi*(tao)*(m-1)*f_interval);%%%Ԥ�Ȳ������ɲ�ͬ��Ƶ���������m*tao*f_interval   
%           
% end




%%%һ�������еĲ����γ�
  Dx=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(tfai(kw)))./lambda(1:M)');  
  Dx3=exp(j*2*pi*array_number_x*(0:M-1)'*dx*(sin(tfai(kw)))./lambda0); 
  F(kw)=(Dx')*zrcomsention(:,1);     %mean(abs(zr(:,1)))%%%�������γ�
  G(kw)=(Dx')*zrcomsention*conj(Dx3);%%%ȫά�����γ�
end


figure
plot(tfai*180/pi,db(abs(F)/max(abs(F))))
hold on
plot(tfai*180/pi,db(abs(G)/max(abs(G))),'m')



