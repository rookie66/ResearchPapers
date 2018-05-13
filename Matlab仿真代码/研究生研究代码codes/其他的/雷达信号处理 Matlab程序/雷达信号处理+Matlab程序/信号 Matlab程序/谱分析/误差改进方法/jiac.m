t=-0.5:0.05:0.5;
x=rectpuls(t,2);
w=(boxcar(length(t)))';
x1=x.*w;
X=fft(x1,1024);figure,plot(20*log10(fftshift(abs(X))/max(fftshift(abs(X)))));axis([0 1023 -50 0]);title('¾ØÐÎ´°')
w=(blackman(length(t)))';
x4=x.*w;
X=fft(x4,1024);figure,plot(20*log10(fftshift(abs(X))/max(fftshift(abs(X)))));axis([0 1023 -100 0]);title('²¼À³¿ËÂü´°')
