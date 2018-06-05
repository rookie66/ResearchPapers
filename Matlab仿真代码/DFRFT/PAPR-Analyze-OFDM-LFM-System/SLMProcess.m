function [ y_slm_para,paprs_SLM] = SLMProcess( y_para)
% 输入:并行的复数数据y_para;复数因子Q
% 输出:1.y_slm_para:经过SLM后的待发送的并行数据y_slm_para(已经包含了side information)
%      2.paprs_SLM : 计算出来的最小的paprs_SLM,用于作PAPR-CCDF图

    global   ofdmCodeNums LN p
    %下面进行SLM算法抑制PAPR
    y_slm_para = zeros(LN+1,ofdmCodeNums);%待发送的信号,第N+1行发送side information
    paprs_SLM = zeros(1,ofdmCodeNums);
    for ii = 1:ofdmCodeNums
        [y_slm_para(:,ii), paprs_SLM(ii)]= SLMProcessPerOFDMCode(y_para(:,ii));%处理第ii个OFDM码元
    end
    function [ofdmSLMPerCode,perVectorMinPaprValue] = SLMProcessPerOFDMCode(ofdmCode_Vector)
        % 输入：OFDM的一个码元矢量(向量)
        % 返回：添加side information的长度为N+1的向量和该向量的PAPR值
        global M  N L U  Q
        % 从U个中选择PAPR最小的
        ofdmSLMCodesCandidate = zeros(LN+1,U);
        paprs = zeros(1,U);
        for iii = 1:U
            %-------添加过采样功能-------------
            y_slm_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
            % 乘以相位序列
            y_slm_oversample(1:end-1) = Q(:,iii).*y_slm_oversample(1:end-1);
            
            y_slm_oversample(LN+1) = modulate(modem.qammod(M),floor(iii/2));%修改了
            % 注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
            y_ofdm = L*dFRTPro(y_slm_oversample,-p);%LN+1点
            ofdmSLMCodesCandidate(:,iii) = y_ofdm;%保存下来
            %计算调整之后的PAPR值
            paprs(iii) = per_Vector_PAPR_Calcu(ofdmSLMCodesCandidate(:,iii));%注意是LN+1个点
        end
        perVectorMinPaprValue = min(paprs);
        min_papr_indexs = find(paprs == perVectorMinPaprValue);
        ofdmSLMPerCode = ofdmSLMCodesCandidate(:,min_papr_indexs(1));
    end
end
