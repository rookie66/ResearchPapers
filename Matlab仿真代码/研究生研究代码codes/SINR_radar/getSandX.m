% S denotes 雷达发射的信号，sm与sn相互正交
% X denotes 通信系统发射的信号
function [S,X]=getSandX(L_total,L,M)
A=rand(L,M); %Mdenote the number of antenna
S=orth(A);% Radar Signal ，任意两个列向量相互正交
X=randn(L_total,M);% Communication Signal
%注意：有疑虑，通信信号如何生成？
%对发射功率P_C = L_total*M_tC,
% the power is normalized by the power of the the radar waveform.
end