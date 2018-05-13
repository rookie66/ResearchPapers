%% 冲激函数
n=-10:10;
y=[n==0];%y=[n>=0&n<=0]
stem(n,y,'fill');
%{
n=-10:1:10; % n = linspace(-10,10,21)
y=zeros(1,21);% y(21)=0;或 y = linspace(0,0,21)
y(11)=1;
stem(n,y,'fill')
%}
%% 
%{
DTFT 可以利用函数工具箱中的freqz 函数实现。
%}
n=-200:1:200;
x = 0.1*cos(0.45*n*pi)+sin(0.3*n*pi)-cos(0.302*n*pi-pi/4);
plot(n,x)
[X,w]=freqz(x,1,256);
%[X,w]=freqz(x,1,256,'whole');
plot(w/pi,abs(X))

