%讨论不同的p有什么影响
p_s = 0.1:0.3:1.5;
global PAPRs_no PAPRs_slm BERs_no_s BERs_slm_s papr_base EbNos  index_p
global p papr_no_name papr_slm_name ber_no_name ber_slm_name matFiledir 
matFiledir = 'matFiles/';
papr_no_name = 'PAPR_no_p_';
papr_slm_name = 'PAPR_slm_p_';
ber_no_name = 'BER_no_p_';
ber_slm_name = 'BER_slm_p_';
PAPRs_no = zeros(length(p_s),length(papr_base));
PAPRs_slm = zeros(length(p_s),length(papr_base));
BERs_no_s = zeros(length(p_s),length(EbNos));
BERs_slm_s = zeros(length(p_s),length(EbNos));
index_p = 0;
for p1 = p_s
    index_p = index_p + 1;
    p = p1;
    p
    Main
end
figure
semilogy(papr_base,PAPRs_no(1,:),'-b*');hold on;
semilogy(papr_base,PAPRs_no(2,:),'-k*');
semilogy(papr_base,PAPRs_no(3,:),'-r*');
semilogy(papr_base,PAPRs_no(4,:),'-g^');
semilogy(papr_base,PAPRs_no(5,:),'-y^');
legend(strcat('p=',num2str(p_s(1))),strcat('p=',num2str(p_s(2))),...
strcat('p=',num2str(p_s(3))),strcat('p=',num2str(p_s(4))),strcat('p=',num2str(p_s(5))))
grid on;xlabel('PAPR\_base/dB');ylabel('CCDF');title('OFDM\_LFM\_PAPR\_CCDF曲线');hold off;
figure
semilogy(papr_base,PAPRs_slm(1,:),'-b*');hold on;
semilogy(papr_base,PAPRs_slm(2,:),'-k*');
semilogy(papr_base,PAPRs_slm(3,:),'-r*');
semilogy(papr_base,PAPRs_slm(4,:),'-g^');
semilogy(papr_base,PAPRs_slm(5,:),'-y^');
legend(strcat('p=',num2str(p_s(1))),strcat('p=',num2str(p_s(2))),...
strcat('p=',num2str(p_s(3))),strcat('p=',num2str(p_s(4))),strcat('p=',num2str(p_s(5))))
grid on;xlabel('PAPR\_base/dB');ylabel('CCDF');title('OFDM\_LFM\_PAPR\_CCDF曲线(SLM)');hold off;
figure
semilogy(EbNos,BERs_no_s(1,:),'-b*');hold on;
semilogy(EbNos,BERs_no_s(2,:),'-k*');
semilogy(EbNos,BERs_no_s(3,:),'-r*');
semilogy(EbNos,BERs_no_s(4,:),'-g^');
semilogy(EbNos,BERs_no_s(5,:),'-y^');
legend(strcat('p=',num2str(p_s(1))),strcat('p=',num2str(p_s(2))),...
strcat('p=',num2str(p_s(3))),strcat('p=',num2str(p_s(4))),strcat('p=',num2str(p_s(5))))
grid on;xlabel('SNR/dB');ylabel('BER');title('OFDM-LFM系统的BER-SNR图像(无算法)');hold off;
figure
semilogy(EbNos,BERs_slm_s(1,:),'-b*');hold on;
semilogy(EbNos,BERs_slm_s(2,:),'-k*');
semilogy(EbNos,BERs_slm_s(3,:),'-r*');
semilogy(EbNos,BERs_slm_s(4,:),'-g^');
semilogy(EbNos,BERs_slm_s(5,:),'-y^');
legend(strcat('p=',num2str(p_s(1))),strcat('p=',num2str(p_s(2))),...
strcat('p=',num2str(p_s(3))),strcat('p=',num2str(p_s(4))),strcat('p=',num2str(p_s(5))))
grid on;xlabel('SNR/dB');ylabel('BER');title('OFDM-LFM系统的BER-SNR图像(SLM算法)');hold off;
