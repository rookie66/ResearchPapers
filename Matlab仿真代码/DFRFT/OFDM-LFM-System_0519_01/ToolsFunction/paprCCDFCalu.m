function [ percent_paprs_CCDF ] = paprCCDFCalu( paprs )
%统计PAPR的CCDF数据
%输入：需要发送的所有码元的paprs
%返回：统计好的percents
%需要全局变量papr_base
    global papr_base
    percent_paprs_CCDF = zeros(1,length(papr_base)); 
    i = 0;
    for papr_base_per = papr_base
        i = i + 1;  
        percent_paprs_CCDF(i) = length(find(paprs > papr_base_per))/length(paprs);
    end
end

