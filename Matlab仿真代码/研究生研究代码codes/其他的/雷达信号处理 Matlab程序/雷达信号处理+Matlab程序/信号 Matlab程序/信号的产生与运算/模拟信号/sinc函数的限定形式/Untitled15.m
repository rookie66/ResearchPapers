%(1/tao)*tri(t/tao)
A=1;
tao=0.1;
t1=-2:0.0001:(-A*tao);
n1=length(t1);
u1=zeros(1,n1);
t2=(-A*tao):0.0001:0;
u2=(((1/tao)-0)/(0-(-tao)))*t2+1/tao;
t3=0:0.001:(A*tao);
u3=(((1/tao)-0)/(0-tao))*t3+1/tao;
t4=(A*tao):0.0001:2;
n4=length(t4);
u4=zeros(1,n4);
t=[t1 t2 t3 t4];
u=[u1 u2 u3 u4];
plot(t,u);
xlabel('t');ylabel('(1/tao)*tri(t/tao)');legend('高度=1/tao','面积=1','宽度=2*tao');
axis([-2 2 -0.2 (1/tao)+1]);
grid on