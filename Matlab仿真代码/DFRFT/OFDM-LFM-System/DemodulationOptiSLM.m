function [ BERs_opti_slm] = DemodulationOptiSLM( y_slm_serial_opti )
%��OFDM-LFM�źŽ���������������������������
%���룺�����OFDM-LFM����
%�����������

global EbNos ofdmCodeNums N LN M Q1 x U1 L p
%-----------------------��ʼ��--------------------
BERs_opti_slm = zeros(1,length(EbNos));
numBitErrorsOptiSLM = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------�������(��ӦEbNo��)-----------------
    y_slm_serial_opti_noise = awgn(y_slm_serial_opti,EbNo,'measured');
%     y_slm_serial_opti_noise = y_slm_serial_opti;
    %��û���������������£�������Ϊ0.2498  Ӧ��Ϊ0���Ŷ�
    y_papr_opti_slm_para = reshape(y_slm_serial_opti_noise,LN+1,ofdmCodeNums);
    %-------------------�Ƚ���DFRFT-------------------------
    y_slm_after_dfrft = 1/L*dFRTPro(y_papr_opti_slm_para(:,:),p);%(LN+1)*
    %--------���Ȼ�ȡside information(��SNR�ϵ�ʱ������y_papr_slm_para���ش���)-------------
    sideInform = round(demodulate(modem.qamdemod(M),y_slm_after_dfrft(end,:))) + 1;%1XofdmCodeNums
    %��0-U1����ɴ�1-��U1+1��
    for iii = 1:ofdmCodeNums
        if  sideInform(iii)>U1+1
                sideInform(iii) = U1+1;
        end
        if sideInform(iii)<1
             sideInform(iii) = 1;
        end
        y_slm_after_dfrft(1:end-1,iii) = y_slm_after_dfrft(1:end-1,iii)./Q1(:,sideInform(iii));%
    end
   % y_slm_after_dfrft(1:end-1,:)
%     sideInform
     %------------------ȥ��������-------------
    y_slm_after_dfrft_qu_over = [y_slm_after_dfrft(1:N/2,:); y_slm_after_dfrft(end-1-N/2+1:end-1,:)];
    y_slm_after_de_16QAM = demodulate(modem.qamdemod(M),y_slm_after_dfrft_qu_over);
    y_bits_column = de2bi(y_slm_after_de_16QAM,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
    y_bits_column2 = trans(y_bits_column);
    y_bits_serial = y_bits_column2(:);
    jjj = jjj + 1;
    [numBitErrorsOptiSLM(jjj),BERs_opti_slm(jjj)] = biterr(x(:),y_bits_serial);
end
