%简单脉冲的模糊函数
%xt=1/(sqrt(t));-T/2<t<T/2;  简单脉冲信号

T=1;
t=-T:5e-2:T;                                    %归一化时延
FD=-10*T:2e-1:10*T;                             %归一化多普勒频移
FD=FD+eps;
[xx,yy]=meshgrid(t,FD);                         % xx和yy都是t*FD的矩阵
AF=abs((sin(pi*yy.*(T-abs(xx))))./(T*pi*yy));   %简单脉冲的模糊函数
figure(1)
surf(yy,xx,AF);
title('脉宽为T，具有单位能量简单脉冲的模糊函数');
xlabel('归一化多普勒频移');ylabel('归一化时延');zlabel('模糊函数AF');
figure(2)
v=[10^(-0.5/20),10^(-3/20),10^(-10/20),10^(-20/20)];
contour(yy,xx,AF,v);
text(-9,0.8,{'-0.5,-3,-10和','-20dB等高线图'}, 'Edgecolor',[0 0 0]);
title('简单脉冲模糊函数的等高线图');
xlabel('多普勒失配（1/T的倍数）');ylabel('延迟（T的倍数）');

t=-T:1e-6:T;
At=1-abs(t);
figure(3)
plot(t,At);
title('简单脉冲AF的零多普勒截线');
xlabel('时延（T的倍数）');ylabel('幅值');

FD=-10*T:1e-2:10*T;
FD=FD+eps;
Af=abs((sin(pi*FD*T))./(T*pi*FD));
figure(4)
plot(FD,Af);
title('零延迟截线');
xlabel('多普勒失配（1/T的倍数）');ylabel('幅值');

figure(5)
t=-T:1e-6:T;
FD=0.31;
Atf=abs((sin(pi*FD*(T-abs(t))))./(T*pi*FD));
plot(t,Atf,'k')
hold on
FD=0.94;
Atf=abs((sin(pi*FD*(T-abs(t))))./(T*pi*FD));
plot(t,Atf,'r')
hold on
FD=1.72;
Atf=abs((sin(pi*FD*(T-abs(t))))./(T*pi*FD));
plot(t,Atf,'g')
hold on
FD=7.5;
Atf=abs((sin(pi*FD*(T-abs(t))))./(T*pi*FD));
plot(t,Atf,'b')
title('多普勒失配对简单脉冲匹配滤波器输出距离响应的影响');
xlabel('时延（T的倍数）');ylabel('幅值');