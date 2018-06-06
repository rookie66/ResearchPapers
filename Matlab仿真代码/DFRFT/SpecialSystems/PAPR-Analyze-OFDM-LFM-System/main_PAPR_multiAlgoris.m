% 整个系统的入口
% loop 为多次循环次数

format long 
format compact
close all;clear;clc
global papr_base
sumResult = zeros(5,length(papr_base));
loop = 1;
for l = 1:loop
    perResult = loopProcess();
    sumResult = sumResult + perResult;
end
average = sumResult/loop;
percent_paprs_CCDF_No_Reduction = average(1,:);
percent_paprs_CCDF_SLM_Reduction = average(2,:);
percent_paprs_CCDF_SLM_Reduction_opti = average(3,:);
percent_paprs_CCDF_SLM_Reduction_opti8 = average(4,:);
percent_paprs_CCDF_SLM_Clipping_Reduction = average(5,:);
percent_paprs_CCDF_Clipping_Reduction = average(6,:);
percent_paprs_CCDF_Clipping_Reduction8 = average(7,:);
%------------------作PAPR的CCDF图像----------
semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-k*');hold on;
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.bo');
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction_opti,'--r^');
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction_opti8,'--kv');
semilogy(papr_base,percent_paprs_CCDF_Clipping_Reduction,'--cs');
semilogy(papr_base,percent_paprs_CCDF_SLM_Clipping_Reduction,'--gd');
semilogy(papr_base,percent_paprs_CCDF_SLM_Clipping_Reduction8,'--c*');
legend(' Original',' SLM,U=6',' PJ-SLM,U=6',' PJ-SLM,U=8',' Clipping,\lambda=2.1',...
' PJ-SLM-C,U=6,\lambda=2.1',' PJ-SLM-C,U=8,\lambda=2.1','Location','west');
hold off;grid on;xlabel('PAPR_{th}/dB');ylabel('PAPR-CCDF');
% 一率采用无标题(无title)
% title('OFDM-LFM-RCI系统的PAPR-CCDF曲线');
% title('PAPR-CCDF');
    