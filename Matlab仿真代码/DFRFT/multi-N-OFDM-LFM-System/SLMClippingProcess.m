function [ y_slm_clipping_para,paprs_SLM] = SLMClippingProcess( y_para)
% 输入:并行的复数数据y_para;复数因子Q
% 输出:1.y_slm_para:经过SLM后的待发送的并行数据y_slm_para(已经包含了side information)
%      2.paprs_SLM : 计算出来的最小的paprs_SLM,用于作PAPR-CCDF图

    global   ofdmCodeNums LN p 
    %下面进行优化的SLM算法抑制PAPR
    y_slm_clipping_para = zeros(LN+1,ofdmCodeNums);%待发送的信号,第N+1行发送side information
    paprs_SLM = zeros(1,ofdmCodeNums);
    global Num_One  Num_More
    Num_One = 0; Num_More =0;
    sideInfoVs = zeros(1,ofdmCodeNums);
    for ii = 1:ofdmCodeNums
        [y_slm_clipping_para(:,ii), paprs_SLM(ii),sideInfoV]= OptiSLMProcessPerOFDMCode(y_para(:,ii));%处理第ii个OFDM码元
        sideInfoVs(ii) = sideInfoV;
    end
    %y_para
    %y_slm_clipping_para
%     sideInfoVs
    disp('OFDM码元的总数目：'); Num_One + Num_More
    disp('只进行一次IDFRFT变换的次数：'); Num_One
    disp('进行多次IDFRFT变换的次数：'); Num_More
    
    function [ofdmSLMPerCode,perVectorMinPaprValue,sideInfoV] = OptiSLMProcessPerOFDMCode( ofdmCode_Vector )
        % 输入：OFDM的一个码元矢量(向量)
        % 返回：添加side information的长度为N+1的向量和该向量的PAPR值
        global M  N L U1  Q1 papr_th
        % 从U个中选择PAPR最小的
        ofdmSLMCodesCandidate = zeros(LN+1,U1);
        paprs = zeros(1,U1+1);
         %-------添加过采样功能-------------
            y_slm_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
            y_slm_oversample(end) = modulate(modem.qammod(M),0);
            %首先进行一次IDFRFT，计算PAPR值
            y_ofdm = L*dFRTPro(y_slm_oversample,-p); %LN+1点
            papr_first = per_Vector_PAPR_Calcu(y_ofdm);%LN+1个点
            ofdmSLMCodesCandidate(:,1) = y_ofdm;%保存下来,第1列
            paprs(1) = papr_first;
            if papr_first < papr_th
                ofdmSLMPerCode =  ofdmSLMCodesCandidate(:,1);
                perVectorMinPaprValue = paprs(1);
                Num_One = Num_One + 1;
                sideInfoV = 1;
                return
            else
                Num_More = Num_More + 1;
                for iii = 2:(U1+1)
                    y_slm_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
                    y_slm_oversample(end) = modulate(modem.qammod(M),iii-1);%发送的是从0-U1
                    % 乘以相位序列
                    y_slm_oversample(1:end-1) = Q1(:,iii).*y_slm_oversample(1:end-1);
                    % 注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
                    y_ofdm = L*dFRTPro(y_slm_oversample,-p);%LN+1
                    ofdmSLMCodesCandidate(:,iii) = y_ofdm;%保存下来
                    %计算调整之后的PAPR值
                    paprs(iii) = per_Vector_PAPR_Calcu(ofdmSLMCodesCandidate(:,iii));%注意是LN个点
                end 
                    perVectorMinPaprValue = min(paprs);
                    min_papr_indexs = find(paprs == perVectorMinPaprValue);
                    ofdmSLMPerCode = ofdmSLMCodesCandidate(:,min_papr_indexs(1));
                    sideInfoV  = min_papr_indexs(1);
                    if perVectorMinPaprValue < papr_th
                        %进一步判断，PAPR是否小于指定阈值；若不满足，则限幅算法处理
                        return
                    else%采用Clipping 限幅法，改变幅度，保持相位不变
%                         disp('ddddddddddddddddd')
                        ofdmSLMPerCode = clipping(ofdmSLMPerCode);
%                         perVectorMinPaprValue
                        perVectorMinPaprValue = per_Vector_PAPR_Calcu(ofdmSLMPerCode);%LN+1个点
%                         perVectorMinPaprValue
                    end
            end
    end

    function [ClippingPerCode] = clipping(ofdmClippingPerCode)
        %利用Clipping限幅法处理每一个OFDM码元
        %保持相位不变，只改变幅度大小
        global Am_th
        for kkk = 1:length(ofdmClippingPerCode)
            if abs(ofdmClippingPerCode(kkk)) > Am_th
%                 ofdmClippingPerCode(kkk)
                ofdmClippingPerCode(kkk) = Am_th*exp(1i*angle(ofdmClippingPerCode(kkk)));
%                 ofdmClippingPerCode(kkk)
            end
            ClippingPerCode = ofdmClippingPerCode;
        end
    end
end

