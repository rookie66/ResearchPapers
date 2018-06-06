function [ y_Clipping_para,paprs_Clipping] = D_ClippingProcess( y_para )
% ����:���еĸ�������y_para;��������Q
% ���:1.y_slm_para:����SLM��Ĵ����͵Ĳ�������y_slm_para(�Ѿ�������side information)
%      2.paprs_SLM : �����������С��paprs_SLM,������PAPR-CCDFͼ

    global   ofdmCodeNums LN p 
    %��������Ż���SLM�㷨����PAPR
    y_Clipping_para = zeros(LN+1,ofdmCodeNums);%�����͵��ź�,��N+1�з���side information
    paprs_Clipping = zeros(1,ofdmCodeNums);
    for ii = 1:ofdmCodeNums
        [y_Clipping_para(:,ii), paprs_Clipping(ii)]= ClippingProcessPerOFDMCode(y_para(:,ii));%�����ii��OFDM��Ԫ
    end
    
     function [ofdmClippingPerCode,perVectorMinPaprValue] = ClippingProcessPerOFDMCode( ofdmCode_Vector )
        % ���룺OFDM��һ����Ԫʸ��(����)
        % ���أ�����ΪLN�������͸�������PAPRֵ
        global N L papr_th
        
         %-------��ӹ���������-------------
            y_clipping_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
            %���Ƚ���һ��IDFRFT������PAPRֵ
            y_ofdm = L*dFRTPro(y_clipping_oversample,-p); %LN��
            papr_first = per_Vector_PAPR_Calcu(y_ofdm);%LN����
            if papr_first < papr_th
                ofdmClippingPerCode =  y_ofdm;
                perVectorMinPaprValue = papr_first;
                return
            else %ֱ���޷�
                [ofdmClippingPerCode,perVectorMinPaprValue] = clipping(y_ofdm);
            end
     end

    function [ofdmClippingPerCode,perVectorMinPaprValue] = clipping(ofdmClippingPerCode)
        %����Clipping�޷�������ÿһ��OFDM��Ԫ
        %������λ���䣬ֻ�ı���ȴ�С
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


