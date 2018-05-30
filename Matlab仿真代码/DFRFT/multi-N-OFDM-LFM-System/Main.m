function [BERs_no_reduction] = Main(NN)
global N
N = NN;
%整个系统的入口
close all;clear;clc
format long 
format compact
% 生成信号
signalsGenerator
%无PAPR抑制算法处理
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
y_no_papr_reduction_serial = reshape(y_no_Reduction_para,1,LN*ofdmCodeNums);%生成发射的串行数据
%----------------对发送的串行数据在不同的信噪比下，添加噪声、解调并计算误码率-------------------
BERs_no_reduction =  DemodulationNoPaprReduction(y_no_papr_reduction_serial);
end



