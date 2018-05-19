clc
clear all
close all
fr=10e3;
tr=1/fr;
fs=8e6;
ts=1/fs;
fd=2.5e3;
lemna=0.01;
sita=0.027;%�̶��Ӳ��ٶȷ���
sita1=0.06;%���Ӳ��ٶȷ���
sita2=0.06;%���Ӳ��ٶȷ���
choose=3;
f1=1:50;
f2=-49:50;
f3=-24.5:25;
N=round(tr/ts);
G=exp(-(f1.^2*lemna^2/(8*sita^2)));
G1=0.6*exp(-(f2.^2*lemna^2/(8*sita1^2)));
G2=exp(-(f3.^2*lemna^2/(8*sita^2)));
G3=0.3*exp(-(f2.^2*lemna^2/(8*sita2^2)));
s=[G,zeros(1,50),G1,zeros(1,125),G3,zeros(1,N-451),G2,0];
num=1:500/801:500;
n=1:floor(fr*2*pi)/800:floor(fr*2*pi);
k1=0.5;
k2=0.0;
k3=0.3;
k=2;
z=exp(j*n.*tr);
z_1=1./z;
switch choose
    case 1
H=1-z_1;%һ�ζ���
   case 2
H=1-k*z_1+z_1.^2;;%���ζ���
   case 3
H=(1-z_1)./(1-k1*z_1);%������һ�ζ���
   case 4
H=(1-z_1).^2./(1-(k2+k3)*z_1+k3*z_1.^2);%���������������
end
H=abs(H)./2;
s1=[H,zeros(1,25)].*s;
subplot(211)
plot(1:800,H)
hold on
plot(1:max(size(s)),s,'r')
grid on
text(-4,-0.2,'\fontsize{8}�̶��Ӳ�')
text(110,-0.2,'\fontsize{8}�˶��Ӳ�')
text(350,-0.2,'\fontsize{8}Ŀ��')
text(800,-0.2,'fr')
subplot(212)
plot(1:max(size(s1)),s1)
grid on