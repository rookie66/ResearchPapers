% S denotes �״﷢����źţ�sm��sn�໥����
% X denotes ͨ��ϵͳ������ź�
function [S,X]=getSandX(L_total,L,M)
A=rand(L,M); %Mdenote the number of antenna
S=orth(A);% Radar Signal �����������������໥����
X=randn(L_total,M);% Communication Signal
%ע�⣺�����ǣ�ͨ���ź�������ɣ�
%�Է��书��P_C = L_total*M_tC,
% the power is normalized by the power of the the radar waveform.
end