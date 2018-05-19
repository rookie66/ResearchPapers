%%%%%%%% T_3.m %%%%
clear all
clc
clf
taup=1;       %脉冲宽度  100us
b=10;             %带宽    
up_down=-1;         %up_down=-1正斜率， up_down=1负斜率
x=lfm_ambg(taup,b,up_down);  %计算模糊函数   
taux=-1.1*taup:.01:1.1*taup;
fdy=-b:.01:b;
figure(1)               
mesh(100*taux,fdy./10,x)       %画模糊函数
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
zlabel('| \chi ( \tau,fd) |')
title('模糊函数')
figure(2)
contour(100.*taux,fdy./10,x)       %画等高线
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('模糊函数等高线')
grid on
N_fd_0=(length(fdy)+1)/2;  % fd=0 的位置
x_tau=x(N_fd_0,:);         %  时间模糊函数
figure(3)
plot(100*taux,x_tau)
axis([-110  110  0 1])
xlabel('Delay - \mus')
ylabel('| \chi ( \tau,0) |')
title(' 时间模糊函数')
grid on
N_tau_0=(length(taux)+1)/2; % tau=0 的位置
x_fd=x(:,N_tau_0);           %  速度模糊函数
figure(4)
plot(fdy./10,x_fd)
xlabel('Doppler - MHz')
ylabel('| \chi ( 0,fd) |')
title(' 速度模糊函数')
grid on
x_db=20*log10(x+eps);
[I,J]=find(abs(x_db+6)<0.09); %取6db点的位置
I=(I-b/.01)/(1/.01);            %Doppler维 坐标变换
J=(J-1.1*taup/.01)/(1/.01);      %时间维 坐标变换
figure(5)                         %6db 的等高线
plot(J*100,I/10,'.')                   
axis([-110 110 -1 1])
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('模糊函数 6db 的等高线')
grid on
%- - - - 模糊函数 - - -
function  x=lfm_ambg(taup,b,up_down)
% taup  脉冲宽度;  
%  b    带宽;
%up_down=-1正斜率， up_down=1负斜率
eps=0.0000001;
i=0;
mu=up_down*b/2./taup;
for tau=-1.1*taup:.01:1.1*taup
    i=i+1;
    j=0;
   for fd=-b:.01:b
       j=j+1;
       val1=1-abs(tau)/taup;
       val2=pi*taup*(1-abs(tau)/taup);
       val3=(fd+mu*tau);
       val=val2*val3+eps;
       x(j,i)=abs(val1*sin(val)/val);
   end
end   
%%%%%%%%%%%%%%%%%%
%%%%%%%% T_3.m %%%%
clear all
clc
clf
taup=1;       %脉冲宽度  100us
b=10;             %带宽    
up_down=-1;         %up_down=-1正斜率， up_down=1负斜率
x=lfm_ambg(taup,b,up_down);  %计算模糊函数   
taux=-1.1*taup:.01:1.1*taup;
fdy=-b:.01:b;
figure(1)               
mesh(100*taux,fdy./10,x)       %画模糊函数
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
zlabel('| \chi ( \tau,fd) |')
title('模糊函数')
figure(2)
contour(100.*taux,fdy./10,x)       %画等高线
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('模糊函数等高线')
grid on
N_fd_0=(length(fdy)+1)/2;  % fd=0 的位置
x_tau=x(N_fd_0,:);         %  时间模糊函数
figure(3)
plot(100*taux,x_tau)
axis([-110  110  0 1])
xlabel('Delay - \mus')
ylabel('| \chi ( \tau,0) |')
title(' 时间模糊函数')
grid on
N_tau_0=(length(taux)+1)/2; % tau=0 的位置
x_fd=x(:,N_tau_0);           %  速度模糊函数
figure(4)
plot(fdy./10,x_fd)
xlabel('Doppler - MHz')
ylabel('| \chi ( 0,fd) |')
title(' 速度模糊函数')
grid on
x_db=20*log10(x+eps);
[I,J]=find(abs(x_db+6)<0.09); %取6db点的位置
I=(I-b/.01)/(1/.01);            %Doppler维 坐标变换
J=(J-1.1*taup/.01)/(1/.01);      %时间维 坐标变换
figure(5)                         %6db 的等高线
plot(J*100,I/10,'.')                   
axis([-110 110 -1 1])
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('模糊函数 6db 的等高线')
grid on
%- - - - 模糊函数 - - -
function  x=lfm_ambg(taup,b,up_down)
% taup  脉冲宽度;  
%  b    带宽;
%up_down=-1正斜率， up_down=1负斜率
eps=0.0000001;
i=0;
mu=up_down*b/2./taup;
for tau=-1.1*taup:.01:1.1*taup
    i=i+1;
    j=0;
   for fd=-b:.01:b
       j=j+1;
       val1=1-abs(tau)/taup;
       val2=pi*taup*(1-abs(tau)/taup);
       val3=(fd+mu*tau);
       val=val2*val3+eps;
       x(j,i)=abs(val1*sin(val)/val);
   end
end   
%%%%%%%%%%%%%%%%%%
%%%%%%%% T_3.m %%%%
clear all
clc
clf
taup=1;       %脉冲宽度  100us
b=10;             %带宽    
up_down=-1;         %up_down=-1正斜率， up_down=1负斜率
x=lfm_ambg(taup,b,up_down);  %计算模糊函数   
taux=-1.1*taup:.01:1.1*taup;
fdy=-b:.01:b;
figure(1)               
mesh(100*taux,fdy./10,x)       %画模糊函数
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
zlabel('| \chi ( \tau,fd) |')
title('模糊函数')
figure(2)
contour(100.*taux,fdy./10,x)       %画等高线
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('模糊函数等高线')
grid on
N_fd_0=(length(fdy)+1)/2;  % fd=0 的位置
x_tau=x(N_fd_0,:);         %  时间模糊函数
figure(3)
plot(100*taux,x_tau)
axis([-110  110  0 1])
xlabel('Delay - \mus')
ylabel('| \chi ( \tau,0) |')
title(' 时间模糊函数')
grid on
N_tau_0=(length(taux)+1)/2; % tau=0 的位置
x_fd=x(:,N_tau_0);           %  速度模糊函数
figure(4)
plot(fdy./10,x_fd)
xlabel('Doppler - MHz')
ylabel('| \chi ( 0,fd) |')
title(' 速度模糊函数')
grid on
x_db=20*log10(x+eps);
[I,J]=find(abs(x_db+6)<0.09); %取6db点的位置
I=(I-b/.01)/(1/.01);            %Doppler维 坐标变换
J=(J-1.1*taup/.01)/(1/.01);      %时间维 坐标变换
figure(5)                         %6db 的等高线
plot(J*100,I/10,'.')                   
axis([-110 110 -1 1])
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('模糊函数 6db 的等高线')
grid on
%- - - - 模糊函数 - - -
function  x=lfm_ambg(taup,b,up_down)
% taup  脉冲宽度;  
%  b    带宽;
%up_down=-1正斜率， up_down=1负斜率
eps=0.0000001;
i=0;
mu=up_down*b/2./taup;
for tau=-1.1*taup:.01:1.1*taup
    i=i+1;
    j=0;
   for fd=-b:.01:b
       j=j+1;
       val1=1-abs(tau)/taup;
       val2=pi*taup*(1-abs(tau)/taup);
       val3=(fd+mu*tau);
       val=val2*val3+eps;
       x(j,i)=abs(val1*sin(val)/val);
   end
end   
%%%%%%%%%%%%%%%%%%
