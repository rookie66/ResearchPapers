clear;close all;clc
g=19;%G=10011;
state=8;%state=1000
L=1000;
%m序列产生
N=15;
mq=mgen(g,state,L);
%m序列自相关
ms=conv(1-2*mq,1-2*mq(15:-1:1))/N;
figure(1)
subplot(222)
stem(ms(15:end));
axis([0 63 -0.3 1.2]);title('m序列自相关序列')
%m序列构成的信号（矩形脉冲）
N_sample=8;
Tc=1;
dt=Tc/N_sample;
t=0:dt:Tc*L-dt;
gt=ones(1,N_sample);
mt=sigexpand(1-2*mq,N_sample);
mt=conv(mt,gt);
figure(1)
subplot(221);
plot(t,mt(1:length(t)));
axis([0 63 -0.3 1.2]);title('m序列矩形成型信号')
st=sigexpand(1-2*mq(1:15),N_sample);
s=conv(st,gt);
st=s(1:length(st));
rt1=conv(mt,st(end:-1:1))/(N*N_sample);
subplot(223)
plot(t,rt1(length(st):length(st)+length(t)-1));
axis([0 63 -0.3 1.2]);title('m序列矩形成型信号的自相关');xlabel('t');
Tc=1;
dt=Tc/N_sample;
t=-20:dt:20;
gt=sinc(t/Tc);
mt=sigexpand(1-2*mq,N_sample);
mt=conv(mt,gt);
st2=sigexpand(1-2*mq(1:15),N_sample);
s2=conv(st2,gt);
st2=s2;
rt2=conv(mt,st2(end:-1:1))/(N*N_sample);
subplot(224);
t1=-55+dt:dt:Tc*L-dt;
%plot(t,mt(1:length(t)));
plot(t1,rt2(1:length(t1)));
axis([0 63 -0.5 1.2]);title('m序列since成形信号的自相关');xlabel('t')
