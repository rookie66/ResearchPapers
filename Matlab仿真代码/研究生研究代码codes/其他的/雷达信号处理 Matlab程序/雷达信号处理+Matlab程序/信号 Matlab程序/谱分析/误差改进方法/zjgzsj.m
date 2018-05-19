width=2;
TP=width;
t=-2*width:0.02:2*width;
x=rectpuls(t,width);
% plot(t,x);
X=abs(fft(x,2048));
subplot(311),plot(10*log10(fftshift(X)/max(X)));title('TP=2s');
axis([0 2048 -40 0])
%%%%%%
width=4;
TP=width;
t=-2*width:0.02:2*width;
x=rectpuls(t,width);
% plot(t,x);
X=abs(fft(x,2048));
subplot(312),plot(10*log10(fftshift(X)/max(X)));title('TP=4s');
axis([0 2048 -40 0])
%%%%%%%%%%%
width=8;
TP=width;
t=-2*width:0.02:2*width;
x=rectpuls(t,width);
% plot(t,x);
X=abs(fft(x,2048));
subplot(313),plot(10*log10(fftshift(X)/max(X)));title('TP=8s');
axis([0 2048 -40 0])
