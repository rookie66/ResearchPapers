N=70;%N为补零的点数
t=-1:0.1:1;
x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1 0];
stem(t,x);
X=fft(x,length(t));
figure,stem(fftshift(abs(X)));
x=[x zeros(1,N)];
t=-1:0.1:1+N*0.1
figure,stem(t,x);
X=fft(x,length(t)+N);figure,stem(fftshift(abs(X)));hold on;plot(fftshift(abs(X)),'r')
