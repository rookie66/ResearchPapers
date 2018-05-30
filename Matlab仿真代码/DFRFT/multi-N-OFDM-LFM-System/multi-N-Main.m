
% Ns = [32,64,128,256];
global EbNos
BERs_32 = Main(32);
BERs_64 = Main(64);
BERs_128 = Main(128);
BERs_256 = Main(256);
figure,semilogy(EbNos,BERs_32,'-k*'),hold on;grid on ;
semilogy(EbNos,BERs_64,'-.ko');
semilogy(EbNos,BERs_128,'-.k^');
semilogy(EbNos,BERs_256,'--kd');
legend('  N=32','  N=64','  N=128','  N=256','Location','west')
xlabel('SNR');ylabel('BER');title('不同子载波数目下的BER-SNR图像');
