%矩形信号的求和与乘积
t1=-2:0.001:-1;
n1=length(t1);
u1=zeros(1,n1);
t2=-1:0.001:1;
t0=-1;
u2=stepfun(t2,t0);
t3=1:0.001:2;
n3=length(t3);
u3=zeros(1,n3);
t=[t1 t2 t3];
u=[u1 u2 u3];
subplot(2,2,1);
plot(t,u);
axis([-2 2 -0.2 1.2])
grid on
xlabel('t');
ylabel('u1(t)')
title('u1(t)')

t4=-2:0.001:0;
n4=length(t4);
u4=zeros(1,n4);
t5=0:0.001:1;
t0=-0.5;
u5=stepfun(t5,t0);
t6=1:0.001:2;
n6=length(t6);
u6=zeros(1,n6);
tt=[t4 t5 t6];
uu=[u4 u5 u6];
subplot(2,2,2);
plot(tt,uu);
axis([-2 2 -0.2 1.2])
grid on
xlabel('t');
ylabel('u2(t)')
title('u2(t)')
sum=u+uu;
subplot(2,2,3);
plot(t,sum);
axis([-2 2 -0.2 2.5])
grid on
xlabel('t');
title('u1(t)+u2(t)')
mutiply=u.*uu;
subplot(2,2,4);
plot(t,mutiply);
axis([-2 2 -0.2 1.2])
grid on
xlabel('t')
title('u1(t)*u2(t)')