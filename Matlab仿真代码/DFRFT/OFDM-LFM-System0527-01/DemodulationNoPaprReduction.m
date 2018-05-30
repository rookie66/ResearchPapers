function [ BER_no_Reduction ] = DemodulationNoPaprReduction( y_no_papr_reduction_serial )
%DEMODULATIONNOPAPRREDUCTION Summary of this function goes here
%输入：已经添加过噪声的并行信号,一列对应OFDM的一个码元
%输出：误码率

global EbNos ofdmCodeNums N LN M x L p
%-----------------------初始化--------------------
BER_no_Reduction = zeros(1,length(EbNos));
numBitErrors = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------添加噪声(对应EbNo下)-----------------
    y_no_papr_reduction_serial_noise = awgn(y_no_papr_reduction_serial,EbNo,'measured');
%     y_no_papr_reduction_serial_noise = y_no_papr_reduction_serial;
    %串变并S/P
    y_no_papr_reduction_para = reshape(y_no_papr_reduction_serial_noise,LN,ofdmCodeNums);
    jjj = jjj + 1;
    [numBitErrors(jjj),BER_no_Reduction(jjj)] = DemodulationNoPaprReductionPerEbNo(y_no_papr_reduction_para);
end

    function [numBitError,BERPerEbNo] = DemodulationNoPaprReductionPerEbNo(y_no_papr_reduction_para)
        %解调加过噪声的信号(整个OFDM-LFM系统的信号),对应某一个信噪比情况下
        y_demodulation = 1/L*dFRTPro(y_no_papr_reduction_para,p);%对于矩阵，直接按列dfrft变换
        %---------------去过采样-----------------------
        y_demodulation_qu_over = [y_demodulation(1:N/2,:);y_demodulation(end-N/2+1:end,:)];
        y_demodulation_qu_over_de_16QAM = demodulate(modem.qamdemod(M),y_demodulation_qu_over);
        y_after_de_16QAM_serial = y_demodulation_qu_over_de_16QAM(:);
        y_bits_column = de2bi(y_after_de_16QAM_serial,'right-msb'); %转化为对应的二进制比特流
        y_bits_column2 = conj(y_bits_column');
        y_bits_serial = y_bits_column2(:);
        [numBitError,BERPerEbNo] = biterr(x(:),y_bits_serial);
    end
end

