% n=-10:10;
% x=[0 0 0 0.5 1 1.5 2 2.5 3 3.5 4 3.5 3 2.5 2 1.5 1 0.5 0 0 0];
% figure,stem(n,x);
% X=fft(x,64);
% k=0:63;
% figure,stem(k,fftshift(abs(X)));xlabel('k');
% w=2*pi*k/64;
% stem(w/2/pi,fftshift(abs(X)));xlabel('F');

dt=0.2;
M=4/dt+1;%M为序列总长度
t=-2:dt:2;
width=2;
x=tripuls(t,width);
stem(t,x);
X=fft(x);
k=0:length(t)-1;
figure,stem(k,fftshift(abs(X)));xlabel('k');
% w=2*pi*k/length(t);
figure,stem(t/length(t)*(1/dt)+0.5,fftshift(abs(X)));xlabel('F');

