function [ percent_paprs_CCDF ] = paprCCDFCalu( paprs )
%ͳ��PAPR��CCDF����
%���룺��Ҫ���͵�������Ԫ��paprs
%���أ�ͳ�ƺõ�percents
%��Ҫȫ�ֱ���papr_base
    global papr_base
    percent_paprs_CCDF = zeros(1,length(papr_base)); 
    i = 0;
    for papr_base_per = papr_base
        i = i + 1;  
        percent_paprs_CCDF(i) = length(find(paprs > papr_base_per))/length(paprs);
    end
end

