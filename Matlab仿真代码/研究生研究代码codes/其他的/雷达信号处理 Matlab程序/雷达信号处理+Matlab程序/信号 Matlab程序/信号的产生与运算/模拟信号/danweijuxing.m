%单位矩形函数
A=0.5;
tao=0.05;
t1=-2:0.001:-A;
n1=length(t1);
u1=zeros(1,n1);
t2=-A:0.001:A;
t0=-A;
u2=stepfun(t2,t0);
t3=A:0.001:2;
n3=length(t3);
u3=zeros(1,n3);
t=[t1 t2 t3];
u=[u1 u2 u3];
plot(t,u)
axis([-2 2 -0.5 2]);
xlabel('t');ylabel('rect(t)');legend('高度=1','面积=1','宽度=1');
grid on