%LFM的模糊函数

BT=100;
T=1;
B=BT/T;
t=-T:5e-2:T;                                    %归一化时延
FD=-4*T:2e-1:4*T;                             %归一化多普勒频移
FD=FD+eps;
[xx,yy]=meshgrid(t,FD);                         % xx和yy都是t*FD的矩阵

AF=abs((sin(pi*(yy+B*xx/T).*(T-abs(xx)))./(T*pi*(yy++B*xx/T))));   %LFM的模糊函数
figure(1)
surf(yy,xx,AF);
title('BT积为100的LFM的模糊函数');
xlabel('归一化多普勒频移');ylabel('归一化时延');zlabel('模糊函数AF');