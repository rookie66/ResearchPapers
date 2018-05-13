% M序列新测试1108
%% 相关性较好的M序列
clear,close all;clc
seed = [zeros(1,6),1];
pri1 = [1,0,0,0,0,0,1];
pri2 = [0,0,1,0,0,0,1];
N = 2^(length(pri1))-1;
M1 = My_M_Seq(pri1,seed,4*N);
M2 = My_M_Seq(pri2,seed,4*N);
M1a = M1.*2-1;
M2a = M2.*2-1;
%M1aSingle = M1a(1:127);
%M2aSingle = M2a(1:127);
[CorrM1M2,x] = xcorr(M1a,M2a,'unbiased');
%CorrM1M2_Part = CorrM1M2(357:657);
%Corr_min = min(CorrM1M2_Part);
%Corr_max = max(CorrM1M2_Part);
Corr_min =-0.134;
Corr_max = 0.118;
figure(1)
subplot(311),plot(x,CorrM1M2),axis([-150,150,-0.5,1.1])
title('M1和M2互相关')
% hold on ,plot(-150:150,ones(1,301)*Corr_min)
% hold on,plot(-150:150,ones(1,301)*Corr_max)
M1aNew = M1a(1:end-13);
M2aNew = M2a(14:end);
SumM1M2 = M1aNew + M2aNew;
%[CorrSumM1,xs1] = xcorr(SumM1M2,[M1aSingle,zeros(1,length(SumM1M2)-127)],'unbiased');
%[CorrSumM2,xs2] = xcorr(SumM1M2,[M2aSingle,zeros(1,length(SumM1M2)-127)],'unbiased');
[CorrSumM1,xs1] = xcorr(M1aNew,SumM1M2,'unbiased');
[CorrSumM2,xs2] = xcorr(M2a(1:end-13),SumM1M2,'unbiased');
subplot(312),plot(xs1,CorrSumM1),axis([-150,150,-0.5,1.1]),title('M1+M2与M1互相关性能比较')
subplot(313),plot(xs2,CorrSumM2),axis([-150,150,-0.5,1.1]),title('M1+M2与M2互相关性能比较')

figure(2)
[CorrM1,x11] = xcorr(M1aNew,'unbiased');
plot(x11,CorrM1),axis([-150,150,-0.2,1.1]),title('M1序列的自相关')
%% 相关性不是很好的一对M序列
clear,close all;clc
seed = [zeros(1,6),1];
pri1 = [1,0,1,0,0,1,1];
pri2 = [0,0,1,0,0,0,1];
N = 2^(length(pri1))-1;
M1 = My_M_Seq(pri1,seed,4*N);
M2 = My_M_Seq(pri2,seed,4*N);
M1a = M1.*2-1;
M2a = M2.*2-1;
M1aSingle = M1a(1:127);
M2aSingle = M2a(1:127);
[CorrM1M2,x] = xcorr(M1a,M2a,'unbiased');
CorrM1M2_Part = CorrM1M2(357:657);
Corr_min = min(CorrM1M2_Part);
Corr_max = max(CorrM1M2_Part);
figure(2)
subplot(311),plot(x,CorrM1M2),axis([-150,150,-0.5,1])
hold on ,plot(-150:150,ones(1,301)*Corr_min)
hold on ,plot(-150:150,ones(1,301)*Corr_max)
M1aNew = M1a(1:end-13);
M2aNew = M2a(14:end);
SumM1M2 = M1aNew + M2aNew;
[CorrSumM1,xs1] = xcorr(M1aNew,SumM1M2,'unbiased');
[CorrSumM2,xs2] = xcorr(M2a(1:end-13),SumM1M2,'unbiased');
subplot(312),plot(xs1,CorrSumM1),axis([-150,150,-0.5,1])
subplot(313),plot(xs2,CorrSumM2),axis([-150,150,-0.5,1])
%% 论文中采用的6阶M序列特性
clear,close all;clc
seed1 = [1,0,0,0,1,1];
seed2 = [zeros(1,5),1];
pri = [0,1,1,0,1,1];
N = 2^(length(pri))-1;
M1 = My_M_Seq(pri,seed1,4*N);
M2 = My_M_Seq(pri,seed2,4*N);
M1a = M1.*2-1;
M2a = M2.*2-1;
M1aSingle = M1a(1:127);
M2aSingle = M2a(1:127);
[CorrM1M2,x] = xcorr(M1a,M2a,'unbiased');
%CorrM1M2_Part = CorrM1M2(357:657);
%Corr_min = min(CorrM1M2_Part);
%Corr_max = max(CorrM1M2_Part);
Corr_min =-0.134;
Corr_max = 0.118;
figure(3)
subplot(311),plot(x,CorrM1M2),axis([-80,80,-0.5,1])
hold on ,plot(-80:80,ones(1,161)*Corr_min)
hold on ,plot(-80:80,ones(1,161)*Corr_max)
M1aNew = M1a(1:end-13);
M2aNew = M2a(14:end);
SumM1M2 = M1aNew + M2aNew;
[CorrSumM1,xs1] = xcorr(M1aNew,SumM1M2,'unbiased');
[CorrSumM2,xs2] = xcorr(M2a(1:end-13),SumM1M2,'unbiased');
subplot(312),plot(xs1,CorrSumM1),axis([-80,80,-0.5,1])
subplot(313),plot(xs2,CorrSumM2),axis([-80,80,-0.5,1])