%%%%%%%Cramer-Rao bound on DOA for a single target
clear all
clc
M=10;
snr=1;
i=sqrt(-1);
syms theta;                           %����һ�����ű���theta
%atheta = zeros(M,1);  
for m=1:M
    atheta(m,1)=exp(-i*(m-1)*pi*sin(theta));
end
atheta;  
dtheta=diff(atheta);                  %����ʸ�����ڽǶ�theta��һ��΢��
theta1 = 0;
theta2 = (12*pi)/180;
theta3 = linspace(theta1,theta2);
for k=1:100
    theta=theta3(k);
    athetanum=eval(atheta);
    dthetanum=eval(dtheta);                    
    b = ones(M);
    c = eye(M);
    CRB1(k)=1/(2*snr*(M*dthetanum'*b*dthetanum+athetanum'*b*athetanum*((norm(dthetanum)).^2)...
                       -M*(((abs(athetanum'*b*dthetanum)).^2)/(athetanum'*b*athetanum))));  %CRB on DOA for coherent signals 
    CRB2(k)=1/(2*snr*(M*dthetanum'*c*dthetanum+athetanum'*c*athetanum*((norm(dthetanum)).^2)...
                       -M*(((det(athetanum'*c*dthetanum)).^2)/(athetanum'*c*athetanum))));  %CRB on DOA for orthogonal signals
    CRBthe1(1,k)=CRB1(k);
    CRBthe2(1,k)=abs(CRB2(k)); 
    
end
theta3 = theta3*(180/pi);
CRBthe11=CRBthe1*(180/pi);
CRBthe22=CRBthe2*(180/pi);
figure
semilogy(theta3, CRBthe11,'b--',theta3,CRBthe22,'r')
grid on
xlabel('��[deg]'),ylabel('CRB[deg]')
axis([0 12 0 100])
legend('��=1','��=0',2)
title('CRB on DOA for M=10,L=1,SNR=0dB.for orthogonal and coherent signals')

     