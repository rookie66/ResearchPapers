% 整个系统的入口

format long ;format compact;
close all;clear;clc
global papr_base
sumResult = zeros(4,length(papr_base));
result = loopSLMProcess();
%------------------作PAPR的CCDF图像------------------------
semilogy(papr_base,result(1,:),'-k*');hold on;
semilogy(papr_base,result(2,:),'-.bs');
semilogy(papr_base,result(3,:),'--r^');
semilogy(papr_base,result(4,:),'-go');
semilogy(papr_base,result(5,:),'-.cd');
semilogy(papr_base,result(6,:),'--mv');
legend(' Original',' SLM-U=2',' SLM-U=4',' SLM-U=6',' SLM-U=8','SLM-U=10','location','west')
hold off;grid on;xlabel('PAPR_{th}/dB');ylabel('PAPR-CCDF');
% 一率采用无标题(无title)
% title('SLM算法在不同U值下的PAPR-CCDF曲线');