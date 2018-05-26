function [ BERs_opti_slm] = DemodulationOptiSLM( y_slm_serial_opti )
%对OFDM-LFM信号进行添加噪声、解调、计算误码率
%输入：输入的OFDM-LFM数据
%输出：误码率

global EbNos ofdmCodeNums N LN M Q1 x U1 L p
%-----------------------初始化--------------------
BERs_opti_slm = zeros(1,length(EbNos));
numBitErrorsOptiSLM = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------添加噪声(对应EbNo下)-----------------
    y_slm_serial_opti_noise = awgn(y_slm_serial_opti,EbNo,'measured');
%     y_slm_serial_opti_noise = y_slm_serial_opti;
    %在没有添加噪声的情况下，误码率为0.2498  应该为0，才对
    y_papr_opti_slm_para = reshape(y_slm_serial_opti_noise,LN+1,ofdmCodeNums);
    %-------------------先进性DFRFT-------------------------
    y_slm_after_dfrft = 1/L*dFRTPro(y_papr_opti_slm_para(:,:),p);%(LN+1)*
    %--------首先获取side information(当SNR较低时，导致y_papr_slm_para严重错误)-------------
    sideInform = round(demodulate(modem.qamdemod(M),y_slm_after_dfrft(end,:))) + 1;%1XofdmCodeNums
    %由0-U1，变成从1-（U1+1）
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
     %------------------去除过采样-------------
    y_slm_after_dfrft_qu_over = [y_slm_after_dfrft(1:N/2,:); y_slm_after_dfrft(end-1-N/2+1:end-1,:)];
    y_slm_after_de_16QAM = demodulate(modem.qamdemod(M),y_slm_after_dfrft_qu_over);
    y_bits_column = de2bi(y_slm_after_de_16QAM,'right-msb'); %转化为对应的二进制比特流
    y_bits_column2 = trans(y_bits_column);
    y_bits_serial = y_bits_column2(:);
    jjj = jjj + 1;
    [numBitErrorsOptiSLM(jjj),BERs_opti_slm(jjj)] = biterr(x(:),y_bits_serial);
end
