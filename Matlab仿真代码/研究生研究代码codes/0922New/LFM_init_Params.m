% 初始化参数集合
clear,close,clc
Tp = 1E-6;%1微秒
eps = 1E-8;
[Tao,fd]=meshgrid(linspace(-1E-6,1E-6,100)+eps,linspace(-5E6,5E6,100)+eps);
A = 1/sqrt(Tp);%信号的幅度
save('init_Params.mat')