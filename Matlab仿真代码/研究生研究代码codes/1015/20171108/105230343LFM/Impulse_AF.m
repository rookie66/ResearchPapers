%�������ģ������
%xt=1/(sqrt(t));-T/2<t<T/2;  �������ź�

T=1;
t=-T:5e-2:T;                                    %��һ��ʱ��
FD=-10*T:2e-1:10*T;                             %��һ��������Ƶ��
FD=FD+eps;
[xx,yy]=meshgrid(t,FD);                         % xx��yy����t*FD�ľ���
AF=abs((sin(pi*yy.*(T-abs(xx))))./(T*pi*yy));   %�������ģ������
figure(1)
surf(yy,xx,AF);
title('����ΪT�����е�λ�����������ģ������');
xlabel('��һ��������Ƶ��');ylabel('��һ��ʱ��');zlabel('ģ������AF');
figure(2)
v=[10^(-0.5/20),10^(-3/20),10^(-10/20),10^(-20/20)];
contour(yy,xx,AF,v);
text(-9,0.8,{'-0.5,-3,-10��','-20dB�ȸ���ͼ'}, 'Edgecolor',[0 0 0]);
title('������ģ�������ĵȸ���ͼ');
xlabel('������ʧ�䣨1/T�ı�����');ylabel('�ӳ٣�T�ı�����');

t=-T:1e-6:T;
At=1-abs(t);
figure(3)
plot(t,At);
title('������AF��������ս���');
xlabel('ʱ�ӣ�T�ı�����');ylabel('��ֵ');

FD=-10*T:1e-2:10*T;
FD=FD+eps;
Af=abs((sin(pi*FD*T))./(T*pi*FD));
figure(4)
plot(FD,Af);
title('���ӳٽ���');
xlabel('������ʧ�䣨1/T�ı�����');ylabel('��ֵ');

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
title('������ʧ��Լ�����ƥ���˲������������Ӧ��Ӱ��');
xlabel('ʱ�ӣ�T�ı�����');ylabel('��ֵ');