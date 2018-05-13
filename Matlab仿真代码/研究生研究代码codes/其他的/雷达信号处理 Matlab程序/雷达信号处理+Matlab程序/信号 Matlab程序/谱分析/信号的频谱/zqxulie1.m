% n1=-4:4;
% x1=[0 1 2 3 4 3 2 1 0];
% n2=5:13;
% x2=[0 1 2 3 4 3 2 1 0];
% n3=14:22;
% x3=[0 1 2 3 4 3 2 1 0];
% n4=23:31;
% x4=[0 1 2 3 4 3 2 1 0];
% n5=32:40;
% x5=[0 1 2 3 4 3 2 1 0];
% n=[n1 n2 n3 n4 n5];
% x=[x1 x2 x3 x4 x5];
% figure,stem(n,x);
% X=fft(x);
% figure,stem(fftshift(abs(X)));xlabel('k')
M=1;%M为延拓的周期数
n=-4:4;
xn=[0 1 2 3 4 3 2 1 0];
n=0:8+9*M;
x=[xn xn];
figure,stem(n,x);
X=fft(x);
k=0:17;
figure,stem(k,fftshift(abs(X)));xlabel('k')




