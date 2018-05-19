%%%%%%%% T_3.m %%%%
clear all
clc
clf
taup=1;       %������  100us
b=10;             %����    
up_down=-1;         %up_down=-1��б�ʣ� up_down=1��б��
x=lfm_ambg(taup,b,up_down);  %����ģ������   
taux=-1.1*taup:.01:1.1*taup;
fdy=-b:.01:b;
figure(1)               
mesh(100*taux,fdy./10,x)       %��ģ������
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
zlabel('| \chi ( \tau,fd) |')
title('ģ������')
figure(2)
contour(100.*taux,fdy./10,x)       %���ȸ���
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('ģ�������ȸ���')
grid on
N_fd_0=(length(fdy)+1)/2;  % fd=0 ��λ��
x_tau=x(N_fd_0,:);         %  ʱ��ģ������
figure(3)
plot(100*taux,x_tau)
axis([-110  110  0 1])
xlabel('Delay - \mus')
ylabel('| \chi ( \tau,0) |')
title(' ʱ��ģ������')
grid on
N_tau_0=(length(taux)+1)/2; % tau=0 ��λ��
x_fd=x(:,N_tau_0);           %  �ٶ�ģ������
figure(4)
plot(fdy./10,x_fd)
xlabel('Doppler - MHz')
ylabel('| \chi ( 0,fd) |')
title(' �ٶ�ģ������')
grid on
x_db=20*log10(x+eps);
[I,J]=find(abs(x_db+6)<0.09); %ȡ6db���λ��
I=(I-b/.01)/(1/.01);            %Dopplerά ����任
J=(J-1.1*taup/.01)/(1/.01);      %ʱ��ά ����任
figure(5)                         %6db �ĵȸ���
plot(J*100,I/10,'.')                   
axis([-110 110 -1 1])
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('ģ������ 6db �ĵȸ���')
grid on
%- - - - ģ������ - - -
function  x=lfm_ambg(taup,b,up_down)
% taup  ������;  
%  b    ����;
%up_down=-1��б�ʣ� up_down=1��б��
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
taup=1;       %������  100us
b=10;             %����    
up_down=-1;         %up_down=-1��б�ʣ� up_down=1��б��
x=lfm_ambg(taup,b,up_down);  %����ģ������   
taux=-1.1*taup:.01:1.1*taup;
fdy=-b:.01:b;
figure(1)               
mesh(100*taux,fdy./10,x)       %��ģ������
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
zlabel('| \chi ( \tau,fd) |')
title('ģ������')
figure(2)
contour(100.*taux,fdy./10,x)       %���ȸ���
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('ģ�������ȸ���')
grid on
N_fd_0=(length(fdy)+1)/2;  % fd=0 ��λ��
x_tau=x(N_fd_0,:);         %  ʱ��ģ������
figure(3)
plot(100*taux,x_tau)
axis([-110  110  0 1])
xlabel('Delay - \mus')
ylabel('| \chi ( \tau,0) |')
title(' ʱ��ģ������')
grid on
N_tau_0=(length(taux)+1)/2; % tau=0 ��λ��
x_fd=x(:,N_tau_0);           %  �ٶ�ģ������
figure(4)
plot(fdy./10,x_fd)
xlabel('Doppler - MHz')
ylabel('| \chi ( 0,fd) |')
title(' �ٶ�ģ������')
grid on
x_db=20*log10(x+eps);
[I,J]=find(abs(x_db+6)<0.09); %ȡ6db���λ��
I=(I-b/.01)/(1/.01);            %Dopplerά ����任
J=(J-1.1*taup/.01)/(1/.01);      %ʱ��ά ����任
figure(5)                         %6db �ĵȸ���
plot(J*100,I/10,'.')                   
axis([-110 110 -1 1])
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('ģ������ 6db �ĵȸ���')
grid on
%- - - - ģ������ - - -
function  x=lfm_ambg(taup,b,up_down)
% taup  ������;  
%  b    ����;
%up_down=-1��б�ʣ� up_down=1��б��
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
taup=1;       %������  100us
b=10;             %����    
up_down=-1;         %up_down=-1��б�ʣ� up_down=1��б��
x=lfm_ambg(taup,b,up_down);  %����ģ������   
taux=-1.1*taup:.01:1.1*taup;
fdy=-b:.01:b;
figure(1)               
mesh(100*taux,fdy./10,x)       %��ģ������
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
zlabel('| \chi ( \tau,fd) |')
title('ģ������')
figure(2)
contour(100.*taux,fdy./10,x)       %���ȸ���
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('ģ�������ȸ���')
grid on
N_fd_0=(length(fdy)+1)/2;  % fd=0 ��λ��
x_tau=x(N_fd_0,:);         %  ʱ��ģ������
figure(3)
plot(100*taux,x_tau)
axis([-110  110  0 1])
xlabel('Delay - \mus')
ylabel('| \chi ( \tau,0) |')
title(' ʱ��ģ������')
grid on
N_tau_0=(length(taux)+1)/2; % tau=0 ��λ��
x_fd=x(:,N_tau_0);           %  �ٶ�ģ������
figure(4)
plot(fdy./10,x_fd)
xlabel('Doppler - MHz')
ylabel('| \chi ( 0,fd) |')
title(' �ٶ�ģ������')
grid on
x_db=20*log10(x+eps);
[I,J]=find(abs(x_db+6)<0.09); %ȡ6db���λ��
I=(I-b/.01)/(1/.01);            %Dopplerά ����任
J=(J-1.1*taup/.01)/(1/.01);      %ʱ��ά ����任
figure(5)                         %6db �ĵȸ���
plot(J*100,I/10,'.')                   
axis([-110 110 -1 1])
xlabel('Delay - \mus')
ylabel('Doppler - MHz')
title('ģ������ 6db �ĵȸ���')
grid on
%- - - - ģ������ - - -
function  x=lfm_ambg(taup,b,up_down)
% taup  ������;  
%  b    ����;
%up_down=-1��б�ʣ� up_down=1��б��
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
