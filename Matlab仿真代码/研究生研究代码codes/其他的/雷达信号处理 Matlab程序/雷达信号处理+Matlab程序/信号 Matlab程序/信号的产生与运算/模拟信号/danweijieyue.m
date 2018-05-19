%µ¥Î»½×Ô¾ÏìÓ¦
t1=-0.5:0.001:0;
A=100;
A1=1/A;
n1=length(t1);
u1=zeros(1,n1);
t2=0:0.001:A1;
t0=0;
u2=A*stepfun(t2,t0);
t3=A1:0.001:1;
n3=length(t3);
u3=zeros(1,n3);
t=[t1 t2 t3];
u=[u1 u2 u3];
plot(t,u)
axis([-0.5 1 0 A+2])
grid on