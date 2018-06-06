% 整个系统的入口

format long ;format compact;
close all;clear;clc
global papr_base ps
pNum = length(ps);
result = loopSLMProcess();
resultNoRedu = result(1:pNum,:); 
% resultSLM = result(pNum+1:2*pNum,:);
%------------------作PAPR的CCDF图像------------------------
semilogy(papr_base,result(1,:),'-k*');hold on;
semilogy(papr_base,result(2,:),'-.bs');
semilogy(papr_base,result(3,:),'--r^');
semilogy(papr_base,result(4,:),'-go');
semilogy(papr_base,result(5,:),'-.cd');
semilogy(papr_base,result(6,:),'--mv');
semilogy(papr_base,result(7,:),'--r^');
semilogy(papr_base,result(8,:),'-go');
semilogy(papr_base,result(9,:),'-.cd');
semilogy(papr_base,result(10,:),'--mv');
legend(' Original',' p=0.1',' p=0.2',' p=0.3',' p=0.4','p=0.5',' p=0.6',' p=0.7',' p=0.8',' p=0.9','p=1.0','location','west')
hold off;grid on;xlabel('PAPR_{th}/dB');ylabel('PAPR-CCDF');
% 一率采用无标题(无title)
% title('SLM算法在不同U值下的PAPR-CCDF曲线');