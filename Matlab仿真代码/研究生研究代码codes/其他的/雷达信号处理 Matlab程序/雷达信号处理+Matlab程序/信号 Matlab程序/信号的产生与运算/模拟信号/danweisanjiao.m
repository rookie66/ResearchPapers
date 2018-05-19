%单位面积三角函数
A=1;
t1=-2:0.001:-A;
n1=length(t1);
u1=zeros(1,n1);
t2=-A:0.001:0;
u2=((A-0)/(0-(-A)))*t2+A;
t3=0:0.001:A;
u3=((A-0)/(0-A))*t3+A;
t4=A:0.001:2;
n4=length(t4);
u4=zeros(1,n4);
t=[t1 t2 t3 t4];
u=[u1 u2 u3 u4];
plot(t,u);
xlabel('t');ylabel('tri(t)');legend('高度=1','面积=1','宽度=2','position',2);
axis([-2 2 -0.2 A+0.5]);
grid on