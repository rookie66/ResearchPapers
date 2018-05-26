function [ BERs_slm ] = DemodulationSLM( y_slm_serial )
%��OFDM-LFM�źŽ���������������������������
%���룺�����OFDM-LFM����
%�����������

global EbNos ofdmCodeNums N LN M Q x U L p
%-----------------------��ʼ��--------------------
BERs_slm = zeros(1,length(EbNos));
numBitErrorsSLM = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------�������(��ӦEbNo��)-----------------
    y_slm_serial_noise = awgn(y_slm_serial,EbNo,'measured');
%     y_slm_serial_noise = y_slm_serial;
    %��û���������������£�������Ϊ0.2498  Ӧ��Ϊ0���Ŷ�
    y_papr_slm_para = reshape(y_slm_serial_noise,LN+1,ofdmCodeNums);
    %-------------------�Ƚ���DFRFT-------------------------
    y_slm_after_dfrft = 1/L*dFRTPro(y_papr_slm_para(:,:),p);
    %--------���Ȼ�ȡside information(��SNR�ϵ�ʱ������y_papr_slm_para���ش���)-------------
    sideInform = round(demodulate(modem.qamdemod(M),y_slm_after_dfrft(end,:)));%1XofdmCodeNums
    for iii = 1:ofdmCodeNums
        if  sideInform(iii)>U
                sideInform(iii) = U;
        end
        if sideInform(iii)<1
             sideInform(iii) = 1;
        end
        y_slm_after_dfrft(1:end-1,iii) = y_slm_after_dfrft(1:end-1,iii)./Q(:,sideInform(iii));
    end
     %------------------ȥ��������-------------
    y_slm_after_dfrft_qu_over = [y_slm_after_dfrft(1:N/2,:); y_slm_after_dfrft(end-1-N/2+1:end-1,:)];
    y_slm_after_de_16QAM = demodulate(modem.qamdemod(M),y_slm_after_dfrft_qu_over);
    y_bits_column = de2bi(y_slm_after_de_16QAM,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
    y_bits_column2 = trans(y_bits_column);
    y_bits_serial = y_bits_column2(:);
    jjj = jjj + 1;
    [numBitErrorsSLM(jjj),BERs_slm(jjj)] = biterr(x(:),y_bits_serial);
end

