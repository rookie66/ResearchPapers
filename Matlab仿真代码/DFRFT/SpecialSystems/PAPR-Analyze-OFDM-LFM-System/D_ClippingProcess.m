function [ y_Clipping_para,paprs_Clipping] = D_ClippingProcess( y_para )
% 输入:并行的复数数据y_para;复数因子Q
% 输出:1.y_slm_para:经过SLM后的待发送的并行数据y_slm_para(已经包含了side information)
%      2.paprs_SLM : 计算出来的最小的paprs_SLM,用于作PAPR-CCDF图

    global   ofdmCodeNums LN p 
    %下面进行优化的SLM算法抑制PAPR
    y_Clipping_para = zeros(LN+1,ofdmCodeNums);%待发送的信号,第N+1行发送side information
    paprs_Clipping = zeros(1,ofdmCodeNums);
    for ii = 1:ofdmCodeNums
        [y_Clipping_para(:,ii), paprs_Clipping(ii)]= ClippingProcessPerOFDMCode(y_para(:,ii));%处理第ii个OFDM码元
    end
    
     function [ofdmClippingPerCode,perVectorMinPaprValue] = ClippingProcessPerOFDMCode( ofdmCode_Vector )
        % 输入：OFDM的一个码元矢量(向量)
        % 返回：长度为LN的向量和该向量的PAPR值
        global N L papr_th
        
         %-------添加过采样功能-------------
            y_clipping_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
            %首先进行一次IDFRFT，计算PAPR值
            y_ofdm = L*dFRTPro(y_clipping_oversample,-p); %LN点
            papr_first = per_Vector_PAPR_Calcu(y_ofdm);%LN个点
            if papr_first < papr_th
                ofdmClippingPerCode =  y_ofdm;
                perVectorMinPaprValue = papr_first;
                return
            else %直接限幅
                [ofdmClippingPerCode,perVectorMinPaprValue] = clipping(y_ofdm);
            end
     end

    function [ofdmClippingPerCode,perVectorMinPaprValue] = clipping(ofdmClippingPerCode)
        %利用Clipping限幅法处理每一个OFDM码元
        %保持相位不变，只改变幅度大小
        global lambda
        Am_th = sqrt(sum(abs(ofdmClippingPerCode).^2)/length(ofdmClippingPerCode))*lambda;
        for kkk = 1:length(ofdmClippingPerCode)
            if abs(ofdmClippingPerCode(kkk)) > Am_th
                ofdmClippingPerCode(kkk) = Am_th*exp(1i*angle(ofdmClippingPerCode(kkk)));
            end
        end
        perVectorMinPaprValue = per_Vector_PAPR_Calcu(ofdmClippingPerCode);
    end
end


