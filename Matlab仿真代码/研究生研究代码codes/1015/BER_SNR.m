%BER-SNR
clear,clc,close all
EbN0dB = 0:0.01:30;
EbN0 = 10.^(EbN0dB./10);
phi = [10,20,30,45,60,90];
sinphi = sin(phi*pi/180);
figure(1)%第1个图像
subplot(121)
for i = 1:length(phi)
    %x = sqrt(2.*EbN0)*sinphi(i);
    x = sqrt(2.*EbN0*sinphi(i));
    BER = qfunc(x);
    semilogy(EbN0dB,BER);
    hold on 
end
legend('10 Deg','20 Deg','30 Deg','45 Deg','60 Deg','90 Deg','Location','southwest');
axis([0,20,1e-8,1]),xlabel('Eb/N0(dB)'),ylabel('BER')
title('Eb/N0(dB) VS BER For Reduced Phase BPSK(1)'),grid on
%第2个图像
subplot(122)
for i = 1:length(phi)
    x2 = sqrt(2.*EbN0)*sinphi(i);
    BER = qfunc(x2);
    semilogy(EbN0dB,BER);
    hold on 
end
legend('10 Deg','20 Deg','30 Deg','45 Deg','60 Deg','90 Deg','Location','southwest');
axis([0,30,1e-8,1]),xlabel('Eb/N0(dB)'),ylabel('BER')
title('Eb/N0(dB) VS BER For Reduced Phase BPSK(2)'),grid on

