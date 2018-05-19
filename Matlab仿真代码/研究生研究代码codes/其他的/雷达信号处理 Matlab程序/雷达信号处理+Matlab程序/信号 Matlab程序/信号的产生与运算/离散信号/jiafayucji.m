%离散信号的加法和乘积
n1=0:3;
x1=[1.8 2.1 0.4 1];
subplot(221)
stem(n1,x1);
axis([-1 8 0 2.5]);
n2=3:7;
x2=[1 0.9 0.5 2 1.2];
subplot(222)
stem(n2,x2);
axis([-1 8 0 2.5]);
n=0:7;
x1=[x1 zeros(1,8-length(n1))];
x2=[zeros(1,8-length(n2)) x2];
x=x1+x2;
subplot(223)
stem(n,x);
xx=x1.*x2;
subplot(224)
stem(n,xx)
axis([0 8 0 2.5])




