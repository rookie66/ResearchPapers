% ����ϵͳ�����
% loop Ϊ���ѭ������

format long 
format compact
close all;clear;clc
global papr_base
sumResult = zeros(4,length(papr_base));
Us = [2,4,6,8,10];
result = loopSLMProcess(Us);
%------------------��PAPR��CCDFͼ��----------
semilogy(papr_base,result(1,:),'-k*');hold on;
semilogy(papr_base,result(2,:),'-.bo');
semilogy(papr_base,result(3,:),'--r^');
semilogy(papr_base,result(4,:),'--g*');
semilogy(papr_base,result(5,:),'--bd');
semilogy(papr_base,result(6,:),'--go');
legend(' Original',' SLM-U=2',' SLM-U=4',' SLM-U=6',' SLM-U=8','SLM-U=10','location','west')
hold off;grid on;xlabel('PAPR\_th/dB');ylabel('PAPR-CCDF');
% һ�ʲ����ޱ���(��title)
% title('OFDM-LFM-RCIϵͳ��PAPR-CCDF����');
% title('PAPR-CCDF');
    