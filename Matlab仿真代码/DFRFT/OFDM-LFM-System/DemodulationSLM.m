function [ BERs_slm ] = DemodulationSLM( y_slm_serial )
%��OFDM-LFM�źŽ���������������������������
%���룺�����OFDM-LFM����
%�����������

<<<<<<< HEAD
global EbNos ofdmCodeNums N LN M Q x U L
=======
global EbNos ofdmCodeNums N LN M Q x U L p
>>>>>>> 987a2b093037d32bcf97ba93f23655e90f5b8e94
%-----------------------��ʼ��--------------------
BERs_slm = zeros(1,length(EbNos));
numBitErrorsSLM = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------�������(��ӦEbNo��)-----------------
<<<<<<< HEAD
    %y_slm_serial_noise = awgn(y_slm_serial,EbNo,'measured');
    %��û���������������£�������Ϊ0.2498  Ӧ��Ϊ0���Ŷ�
    y_papr_slm_para = reshape(y_slm_serial,LN+1,ofdmCodeNums);
    %-------------------�Ƚ���DFRFT-------------------------
    y_slm_after_dfrft = 1/L*dFRTPro(y_papr_slm_para(1:LN,:),1);
    %--------���Ȼ�ȡside information(��SNR�ϵ�ʱ������y_papr_slm_para���ش���)-------------
    sideInform = round(demodulate(modem.qamdemod(M),y_papr_slm_para(end,:)));%1XofdmCodeNums
    for iii = 1:ofdmCodeNums
        if ( sideInform(iii)>U || sideInform(iii)<1 )
            sideInform(iii) = rem(sideInform(iii),U);
=======
    y_slm_serial_noise = awgn(y_slm_serial,EbNo,'measured');
    %��û���������������£�������Ϊ0.2498  Ӧ��Ϊ0���Ŷ�
    y_papr_slm_para = reshape(y_slm_serial_noise,LN+1,ofdmCodeNums);
    %-------------------�Ƚ���DFRFT-------------------------
    y_slm_after_dfrft = 1/L*dFRTPro(y_papr_slm_para(1:LN,:),p);
    %--------���Ȼ�ȡside information(��SNR�ϵ�ʱ������y_papr_slm_para���ش���)-------------
    sideInform = round(demodulate(modem.qamdemod(M),y_papr_slm_para(end,:)/2));%1XofdmCodeNums
    for iii = 1:ofdmCodeNums
        if  sideInform(iii)>U
                sideInform(iii) = U;
        end
        if sideInform(iii)<1
             sideInform(iii) = 1;
>>>>>>> 987a2b093037d32bcf97ba93f23655e90f5b8e94
        end
        y_slm_after_dfrft(:,iii) = y_slm_after_dfrft(:,iii)./Q(:,sideInform(iii));
    end
     %------------------ȥ��������-------------
    y_slm_after_dfrft_qu_over = [y_slm_after_dfrft(1:N/2,:); y_slm_after_dfrft(end-N/2+1:end,:)];
    y_slm_after_de_16QAM = demodulate(modem.qamdemod(M),y_slm_after_dfrft_qu_over);
    y_bits_column = de2bi(y_slm_after_de_16QAM,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
    y_bits_column2 = conj(y_bits_column');
    y_bits_serial = y_bits_column2(:);
    jjj = jjj + 1;
    [numBitErrorsSLM(jjj),BERs_slm(jjj)] = biterr(x(:),y_bits_serial);
end

