function [ BER_no_Reduction ] = DemodulationNoPaprReduction( y_no_papr_reduction_serial )
%DEMODULATIONNOPAPRREDUCTION Summary of this function goes here
%���룺�Ѿ���ӹ������Ĳ����ź�,һ�ж�ӦOFDM��һ����Ԫ
%�����������

global EbNos ofdmCodeNums N LN M x L p
%-----------------------��ʼ��--------------------
BER_no_Reduction = zeros(1,length(EbNos));
numBitErrors = zeros(1,length(EbNos)); 
jjj = 0;
for EbNo = EbNos 
    %-------------------�������(��ӦEbNo��)-----------------
    y_no_papr_reduction_serial_noise = awgn(y_no_papr_reduction_serial,EbNo,'measured');
%     y_no_papr_reduction_serial_noise = y_no_papr_reduction_serial;
    %���䲢S/P
    y_no_papr_reduction_para = reshape(y_no_papr_reduction_serial_noise,LN,ofdmCodeNums);
    jjj = jjj + 1;
    [numBitErrors(jjj),BER_no_Reduction(jjj)] = DemodulationNoPaprReductionPerEbNo(y_no_papr_reduction_para);
end

    function [numBitError,BERPerEbNo] = DemodulationNoPaprReductionPerEbNo(y_no_papr_reduction_para)
        %����ӹ��������ź�(����OFDM-LFMϵͳ���ź�),��Ӧĳһ������������
        y_demodulation = 1/L*dFRTPro(y_no_papr_reduction_para,p);%���ھ���ֱ�Ӱ���dfrft�任
        %---------------ȥ������-----------------------
        y_demodulation_qu_over = [y_demodulation(1:N/2,:);y_demodulation(end-N/2+1:end,:)];
        y_demodulation_qu_over_de_16QAM = demodulate(modem.qamdemod(M),y_demodulation_qu_over);
        y_after_de_16QAM_serial = y_demodulation_qu_over_de_16QAM(:);
        y_bits_column = de2bi(y_after_de_16QAM_serial,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
        y_bits_column2 = conj(y_bits_column');
        y_bits_serial = y_bits_column2(:);
        [numBitError,BERPerEbNo] = biterr(x(:),y_bits_serial);
    end
end

