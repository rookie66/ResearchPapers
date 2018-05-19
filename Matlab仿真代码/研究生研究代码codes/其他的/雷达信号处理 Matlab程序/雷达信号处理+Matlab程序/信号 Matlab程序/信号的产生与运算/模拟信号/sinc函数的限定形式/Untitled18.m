tao=0.05;
A=2;
t1=-2:0.001:0;
n1=length(t1);
x1=zeros(1,n1);
t2=0:0.001:A;
t0=0;
x2=(1/tao)*exp(-(t2/tao)).*stepfun(t2,t0);
t=[t1 t2];
x=[x1 x2];
plot(t,x)
grid on
xlabel('t');
ylabel('x(t)');
title('(1/tao)*exp(-(t2/tao))*u(t)')