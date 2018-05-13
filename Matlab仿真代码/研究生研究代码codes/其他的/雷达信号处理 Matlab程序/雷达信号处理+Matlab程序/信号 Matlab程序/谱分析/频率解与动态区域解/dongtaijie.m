A1=1;
A2=0.05;
f0=30;
deltaf=1;
switch 2
    case 1
%采样频率90HZ,N为180,NFFT为2048
t=0:1/90:2-1/90;
x=A1*cos(2*pi*f0*t)+A2*cos(2*pi*(f0+deltaf)*t);
% t2=2.01:0.01:20.47;
% x2=zeros(1,length(t2));
% t=[t1 t2];
% x=[x1 x2];
X=10*log10((abs(fftshift(fft(x,2048)))/max(abs(fftshift(fft(x,2048))))));
% X=abs(fftshift(fft(x,2048)));
f=([0:2047]-1024)/2048*90;
subplot(211),plot(f(1300:end),X(1300:end));grid on;
%加海宁窗
w=(hanning(length(t)))';
xa=x.*w;
Xa=10*log10((abs(fftshift(fft(xa,2048)))/max(abs(fftshift(fft(xa,2048))))));
% Xa=abs(fftshift(fft(xa,2048)));
fa=([0:2047]-1024)/2048*90;
subplot(212),plot(fa(1300:end),Xa(1300:end));grid on;
case 2
    %采样频率90HZ,N为360,NFFT为4096 
t=0:1/90:4-1/90;
x=A1*cos(2*pi*f0*t)+A2*cos(2*pi*(f0+deltaf)*t);
% t2=5.01:0.01:40.95;
% x2=zeros(1,length(t2));
% t=[t1 t2];
% x=[x1 x2];
X=10*log10(abs(fftshift(fft(x,4096)))/max(abs(fftshift(fft(x,4096)))));
f=([0:4095]-2048)/4096*90;
subplot(211),plot(f(2200:end),X(2200:end));grid on;
 axis([5 45 -50 0]);
%加海宁窗
w=(hanning(length(t)))';
xa=x.*w;
Xa=10*log10(abs(fftshift(fft(xa,4096)))/max(abs(fftshift(fft(xa,4096)))));
fa=([0:4095]-2048)/4096*90;
subplot(212),plot(fa(2200:end),Xa(2200:end));grid on;axis([5 45 -50 0]);
end


