% %周期序列的频谱
% n1=0:3;
% x1=ones(1,length(n1));
% n2=4:6;
% x2=zeros(1,length(n2));
% n3=7:10;
% x3=ones(1,length(n3));
% n4=11:13;
% x4=zeros(1,length(n4));
% n5=14:17;
% x5=ones(1,length(n5));
% n6=18:20;
% x6=zeros(1,length(n6));
% n7=21:24;
% x7=ones(1,length(n7));
% n8=25:27;
% x8=zeros(1,length(n8));
% n9=28:31;
% x9=ones(1,length(n9));
% n10=32:34;
% x10=zeros(1,length(n10));
% n=[n1 n2 n3 n4 n5 n6 n7 n8 n9 n10];
% x=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10];
% figure(1),stem(n,x);
% X=fft(x);figure(2),stem(fftshift(abs(X)));xlabel('k');


%周期序列的频谱
n1=0:3;
x1=ones(1,length(n1));
n2=4:6;
x2=zeros(1,length(n2));
n=[n1,n2];
xn=[x1,x2];
figure,stem(n,xn);
M=3;%M为延拓的周期数
n=0:6+7*M;
x=[xn xn xn xn];
figure,stem(n,x);
X=fft(x);
figure,stem(fftshift(abs(X)));xlabel('k');

