function [ y_slm_para,paprs_SLM] = SLMProcess( y_para)
% ����:���еĸ�������y_para;��������Q
% ���:1.y_slm_para:����SLM��Ĵ����͵Ĳ�������y_slm_para(�Ѿ�������side information)
%      2.paprs_SLM : �����������С��paprs_SLM,������PAPR-CCDFͼ

    global   ofdmCodeNums LN p
    %�������SLM�㷨����PAPR
    y_slm_para = zeros(LN+1,ofdmCodeNums);%�����͵��ź�,��N+1�з���side information
    paprs_SLM = zeros(1,ofdmCodeNums);
    for ii = 1:ofdmCodeNums
        [y_slm_para(:,ii), paprs_SLM(ii)]= SLMProcessPerOFDMCode(y_para(:,ii));%�����ii��OFDM��Ԫ
    end
    function [ofdmSLMPerCode,perVectorMinPaprValue] = SLMProcessPerOFDMCode(ofdmCode_Vector)
        % ���룺OFDM��һ����Ԫʸ��(����)
        % ���أ����side information�ĳ���ΪN+1�������͸�������PAPRֵ
        global M  N L U  Q
        % ��U����ѡ��PAPR��С��
        ofdmSLMCodesCandidate = zeros(LN+1,U);
        paprs = zeros(1,U);
        for iii = 1:U
            %-------��ӹ���������-------------
            y_slm_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
            % ������λ����
            y_slm_oversample(1:end-1) = Q(:,iii).*y_slm_oversample(1:end-1);
            
            y_slm_oversample(LN+1) = modulate(modem.qammod(M),floor(iii/2));%�޸���
            % ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
            y_ofdm = L*dFRTPro(y_slm_oversample,-p);%LN+1��
            ofdmSLMCodesCandidate(:,iii) = y_ofdm;%��������
            %�������֮���PAPRֵ
            paprs(iii) = per_Vector_PAPR_Calcu(ofdmSLMCodesCandidate(:,iii));%ע����LN+1����
        end
        perVectorMinPaprValue = min(paprs);
        min_papr_indexs = find(paprs == perVectorMinPaprValue);
        ofdmSLMPerCode = ofdmSLMCodesCandidate(:,min_papr_indexs(1));
    end
end
