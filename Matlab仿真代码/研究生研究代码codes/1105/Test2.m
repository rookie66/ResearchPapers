%OFDM
f0 = 100;
DeltaF = 50;
f1 = f0+1*DeltaF;
f2 = f0+2*DeltaF;
f3 = f0+3*DeltaF;
Fs = 1000;
t = -10:0.001:10;
s = cos(2*pi*f0*t)+cos(2*pi*f1*t)+cos(2*pi*f2*t)+cos(2*pi*f3*t);
figure(1)
plot(t,s)
F = fftshift(fft(s));
figure(2)
plot(-Fs/2:Fs/(length(t)-1):Fs/2,abs(F))
