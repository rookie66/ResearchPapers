clear all
clc
N = 1;
M = 10;
j = sqrt(-1);
theta1 = (-40*pi)/180;
theta2 = (40*pi)/180;
theta = linspace(theta1,theta2,1000);
atheta0 = ones(M,1);
for k=1:1000
        atheta = zeros(M,1);      %����ʸ��
                for i=1:M
                    atheta(i,1)=exp(-j*(i-1)*pi*sin(theta(k)));
                end
        b = ones(M,1);
        c1 = (N/M)*(abs(atheta0'*b).^2)*(abs(atheta'*atheta0).^2);        %coherent transmit signals�շ���ʽ
        d1 = (N/(M))*(abs(atheta'*atheta0).^4);                               %orthogonal transmit signals�շ���ʽ
        c1=c1/1000;
        d1=d1/1000;
        c(1,k) = 10*log10(c1);
        d(1,k) = 10*log10(d1);
end
theta = theta*(180/pi);
figure
plot(theta,c,'r--',theta,d,'b')
xlabel('��[deg]'),ylabel('G(��)[db]')
legend('��=1','��=0',4)
title('Beam pattern for orthogonal and coherent signals')

savepath1='E:\matlab\fangzhen jieguo';
savename='firstfigure';%ͼ����ļ���

 %print(2,'-djpeg',strcat(savepath1,'\',savename,'.jpeg')); %�����Ϊ2��ͼ�α���Ϊjpeg/jpg��ʽ��ͼƬ���ļ���Ϊ'C:\abc.jpeg'��
saveas(gcf,savename,'fig');
set(gcf,'visible','off');


