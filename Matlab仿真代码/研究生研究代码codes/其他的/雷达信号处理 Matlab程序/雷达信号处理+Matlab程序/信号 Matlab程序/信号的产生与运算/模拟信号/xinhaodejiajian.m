t1=0:0.001:1;
n1=length(t1);
x1=zeros(1,n1);
t2=1:0.001:2;
x2=t2-1;
t3=2:0.001:3;
x3=-t3+3;
t4=3:0.001:4;
n4=length(t4);
x4=zeros(1,n4);
t=[t1,t2,t3,t4];
x=[x1,x2,x3,x4];
subplot(221),plot(t,x)
axis([0 4 0 2.5]);
grid on
title('x1(t)');
%%%%%%%%%%%%%
tt1=0:0.001:1;
xx1=stepfun(tt1,0);
tt2=1:0.001:2;
xx2=stepfun(tt2,1);
tt3=2:0.001:3;
xx3=stepfun(tt3,2);
tt4=3:0.001:4;
xx4=stepfun(tt4,3);
tt=[tt1,tt2,tt3,tt4];
xx=[xx1,xx2,xx3,xx4];
subplot(222),plot(tt,xx)
axis([0 4 0 2.5]);
grid on
title('x2(t)');
sum=x+xx;
subplot(223),plot(t,sum);
grid on
axis([0 4 0 2.5]);
title('x1(t)+x2(t)');
mutiply=x.*xx;
subplot(224),plot(t,mutiply);
axis([0 4 0 2.5])
grid on
title('x1(t)*x2(t)');


