function [ BERs_slm ] = DemodulationSLM( y_slm_serial )
%对OFDM-LFM信号进行添加噪声、解调、计算误码率
%输入：输入的OFDM-LFM数据
%输出：误码率

global EbNos ofdmCodeNums N LN M Q x U L p
%-----------------------初始化--------------------
BERs_slm = zeros(1,length(EbNos));
numBitErrorsSLM = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------添加噪声(对应EbNo下)-----------------
    y_slm_serial_noise = awgn(y_slm_serial,EbNo,'measured');
%     y_slm_serial_noise = y_slm_serial;
    %在没有添加噪声的情况下，误码率为0.2498  应该为0，才对
    y_papr_slm_para = reshape(y_slm_serial_noise,LN+1,ofdmCodeNums);
    %-------------------先进性DFRFT-------------------------
    y_slm_after_dfrft = 1/L*dFRTPro(y_papr_slm_para(:,:),p);
    %--------首先获取side information(当SNR较低时，导致y_papr_slm_para严重错误)-------------
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
     %------------------去除过采样-------------
    y_slm_after_dfrft_qu_over = [y_slm_after_dfrft(1:N/2,:); y_slm_after_dfrft(end-1-N/2+1:end-1,:)];
    y_slm_after_de_16QAM = demodulate(modem.qamdemod(M),y_slm_after_dfrft_qu_over);
    y_bits_column = de2bi(y_slm_after_de_16QAM,'right-msb'); %转化为对应的二进制比特流
    y_bits_column2 = trans(y_bits_column);
    y_bits_serial = y_bits_column2(:);
    jjj = jjj + 1;
    [numBitErrorsSLM(jjj),BERs_slm(jjj)] = biterr(x(:),y_bits_serial);
end

