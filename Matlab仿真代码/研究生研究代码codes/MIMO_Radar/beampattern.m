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
        atheta = zeros(M,1);      %导引矢量
                for i=1:M
                    atheta(i,1)=exp(-j*(i-1)*pi*sin(theta(k)));
                end
        b = ones(M,1);
        c1 = (N/M)*(abs(atheta0'*b).^2)*(abs(atheta'*atheta0).^2);        %coherent transmit signals收发形式
        d1 = (N/(M))*(abs(atheta'*atheta0).^4);                               %orthogonal transmit signals收发形式
        c1=c1/1000;
        d1=d1/1000;
        c(1,k) = 10*log10(c1);
        d(1,k) = 10*log10(d1);
end
theta = theta*(180/pi);
figure
plot(theta,c,'r--',theta,d,'b')
xlabel('θ[deg]'),ylabel('G(θ)[db]')
legend('β=1','β=0',4)
title('Beam pattern for orthogonal and coherent signals')

savepath1='E:\matlab\fangzhen jieguo';
savename='firstfigure';%图像的文件名

 %print(2,'-djpeg',strcat(savepath1,'\',savename,'.jpeg')); %将句柄为2的图形保存为jpeg/jpg格式的图片，文件名为'C:\abc.jpeg'。
saveas(gcf,savename,'fig');
set(gcf,'visible','off');


