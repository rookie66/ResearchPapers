%%矩形信号的模糊函数
clear;close ;clc
LFM_init_Params %调用初始化参数脚本
u = A*1;%矩形信号
X = exp(j*pi*fd.*(Tp-Tao)).*(sinc(pi*fd.*(Tp-abs(Tao)))).*((Tp-abs(Tao))/Tp);
figure(1)
surf(Tao-eps,fd-eps,abs(X))
figure(2)
mesh(Tao-eps,fd-eps,abs(X))
figure(3)
mesh(Tao-eps,fd-eps,-10*log10(abs(X)))
figure(4)
surf(Tao-eps,fd-eps,-10*log10(abs(X)))



