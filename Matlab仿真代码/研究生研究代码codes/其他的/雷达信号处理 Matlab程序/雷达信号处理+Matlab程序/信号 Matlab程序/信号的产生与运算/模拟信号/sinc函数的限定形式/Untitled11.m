%u=(1/tao)*rect(t/tao)
A=0.5;
tao=0.05;
t1=-2:0.001:(-A*tao);
n1=length(t1);
u1=zeros(1,n1);
t2=(-A*tao):0.001:(A*tao);
t0=(-A*tao);
u2=(1/tao)*stepfun(t2,t0);
t3=(A*tao):0.001:2;
n3=length(t3);
u3=zeros(1,n3);
t=[t1 t2 t3];
u=[u1 u2 u3];
plot(t,u)
axis([-2 2 -2 (1/tao)+2]);
xlabel('t');ylabel('(1/tao)*rect(t)');legend('高度=1/tao','面积=1','宽度=tao');
grid on