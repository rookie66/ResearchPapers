%%�����źŵ�ģ������
clear;close ;clc
LFM_init_Params %���ó�ʼ�������ű�
u = A*1;%�����ź�
X = exp(j*pi*fd.*(Tp-Tao)).*(sinc(pi*fd.*(Tp-abs(Tao)))).*((Tp-abs(Tao))/Tp);
figure(1)
surf(Tao-eps,fd-eps,abs(X))
figure(2)
mesh(Tao-eps,fd-eps,abs(X))
figure(3)
mesh(Tao-eps,fd-eps,-10*log10(abs(X)))
figure(4)
surf(Tao-eps,fd-eps,-10*log10(abs(X)))



