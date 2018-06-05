% ��ϵͳ�����
% �Ա�����N���ز�����Ŀ
% ����� BER������(�������κε�PAPR����)
% Ns = [32,64,128,256];
global EbNos
format long;format compact
BERs_32 = process(32);
BERs_64 = process(64);
BERs_128 = process(128);
BERs_256 = process(256);
figure,semilogy(EbNos,BERs_32,'-k*'),hold on;grid on ;
semilogy(EbNos,BERs_64,'-.ko');
semilogy(EbNos,BERs_128,'-.k^');
semilogy(EbNos,BERs_256,'--kd');
output = [BERs_32;BERs_64;BERs_128;BERs_256];
output
legend('  N=32','  N=64','  N=128','  N=256','Location','west');hold off;
xlabel('SNR/dB');ylabel('BER');
% title('��ͬ���ز���Ŀ�µ�BER-SNRͼ��');
title('BER');