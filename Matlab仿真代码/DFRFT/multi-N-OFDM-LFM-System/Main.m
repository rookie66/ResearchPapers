function [BERs_no_reduction] = Main(NN)
global N
N = NN;
%����ϵͳ�����
close all;clear;clc
format long 
format compact
% �����ź�
signalsGenerator
%��PAPR�����㷨����
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
y_no_papr_reduction_serial = reshape(y_no_Reduction_para,1,LN*ofdmCodeNums);%���ɷ���Ĵ�������
%----------------�Է��͵Ĵ��������ڲ�ͬ��������£�������������������������-------------------
BERs_no_reduction =  DemodulationNoPaprReduction(y_no_papr_reduction_serial);
end



