%·ûºÅº¯Êý
A=2;
t1=-A:0.001:0;
t0=-A;
u1=-stepfun(t1,t0);
t2=0:0.001:A;
t3=0;
u2=stepfun(t2,t3);
t=[t1 t2];
u=[u1 u2];
plot(t,u)
grid on
axis([-2 2 -1.5 1.5])