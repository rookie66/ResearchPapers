%LFM��ģ������

BT=100;
T=1;
B=BT/T;
t=-T:5e-2:T;                                    %��һ��ʱ��
FD=-4*T:2e-1:4*T;                             %��һ��������Ƶ��
FD=FD+eps;
[xx,yy]=meshgrid(t,FD);                         % xx��yy����t*FD�ľ���

AF=abs((sin(pi*(yy+B*xx/T).*(T-abs(xx)))./(T*pi*(yy++B*xx/T))));   %LFM��ģ������
figure(1)
surf(yy,xx,AF);
title('BT��Ϊ100��LFM��ģ������');
xlabel('��һ��������Ƶ��');ylabel('��һ��ʱ��');zlabel('ģ������AF');