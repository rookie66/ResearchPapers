%�����źŵĲ���
f=10;
t=0:0.001:0.2;
x=cos(2*pi*f*t);
plot(t,x);
%%%%%%%%%%����%%%%%%%%%%%%
Fs=50;        
Ts=1/Fs;
n=0:20;
xn=cos(2*pi*f*n*Ts);
figure,stem(n,xn);
% W=(hanning(length(n)))';xn=xn.*W;�Ӵ�
%%%%%%%%%%%%
k=-64:64;
X=xn*exp(-j*pi/64).^(n'*k);
magX=abs(X);
w=pi/64*k
figure,stem(w/pi,magX);
