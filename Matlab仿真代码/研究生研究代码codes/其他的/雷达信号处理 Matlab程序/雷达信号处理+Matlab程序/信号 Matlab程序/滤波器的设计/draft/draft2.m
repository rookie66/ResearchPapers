clc
clear all
close all
choose=3;
fr=10e3;
tr=1/fr;
fs=8e6;
ts=1/fs;
fd=2.5e3;
N=floor(fr*2*pi);
s=[ones(1,1000),zeros(1,25000),ones(1,3000),zeros(1,9000),ones(1,2000),zeros(1,N-41001),ones(1,1000),0];
n=1:floor(fr*2*pi);
k1=0;
k2=0.95;
z=exp(j*n*tr);
z_1=1./z;
switch choose
    case 1
H=1-z_1;%一次对消
   case 2
H=k1*z_1+k2*z_1.^2;;%二次对消
   case 3
H=(1-z_1)./(1-k1*z_1);%反馈型一次对消
   case 4
H=(1-z_1).^2./(1-(k1+k2)*z_1+k2*z_1.^2);%反馈型三脉冲对消
end
H=abs(H);
subplot(211),plot(n,H,'r')
text(-1,-0.4,'固定杂波')
text(2.2e4,-0.4,'运动杂波')
text(3.7e4,-0.4,'目标')
text(6.2e4,-0.4,'fr')
xlabel('f')
ylabel('H')
hold on
plot(n,s,'b')
y=s.*H;
subplot(212),plot(n,y)
text(-1,-0.4,'固定杂波')
text(2.2e4,-0.4,'运动杂波')
text(3.7e4,-0.4,'目标')
text(6.2e4,-0.4,'fr')
xlabel('f')
ylabel('H')
