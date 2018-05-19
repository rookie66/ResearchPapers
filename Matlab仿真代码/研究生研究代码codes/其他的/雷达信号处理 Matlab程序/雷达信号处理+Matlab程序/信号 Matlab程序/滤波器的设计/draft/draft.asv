clc
clear all
close all
N=64;
w=rectwin(N);

f=abs(fft(w,1024));
f=10*log(f);
figure
subplot(211)
stem(w)
subplot(212)
plot(f)
axis([0 512 -20 50 ])
