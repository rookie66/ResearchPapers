% ����ϵͳ�����
% loop Ϊ���ѭ������

format long 
format compact
close all;clear;clc
global papr_base
sumResult = zeros(4,length(papr_base));
loop = 1;
for l = 1:loop
    perResult = loopProcess();
    sumResult = sumResult + perResult;
end
average = sumResult/loop;
percent_paprs_CCDF_No_Reduction = average(1,:);
percent_paprs_CCDF_SLM_Reduction = average(2,:);
percent_paprs_CCDF_SLM_Reduction_opti = average(3,:);
percent_paprs_CCDF_SLM_Clipping_Reduction = average(4,:);
%------------------��PAPR��CCDFͼ��----------
semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-k*');hold on;
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.bo');
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction_opti,'--r^');
semilogy(papr_base,percent_paprs_CCDF_SLM_Clipping_Reduction,'--gd');
legend(' Original',' SLM',' PJ-SLM',' PJ-SLM-C','Location','west')
hold off;grid on;xlabel('PAPR\_th/dB');ylabel('PAPR-CCDF');
% һ�ʲ����ޱ���(��title)
% title('OFDM-LFM-RCIϵͳ��PAPR-CCDF����');
% title('PAPR-CCDF');
    