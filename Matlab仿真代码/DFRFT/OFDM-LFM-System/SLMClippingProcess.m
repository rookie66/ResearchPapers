function [ y_slm_clipping_para,paprs_SLM] = SLMClippingProcess( y_para)
% ����:���еĸ�������y_para;��������Q
% ���:1.y_slm_para:����SLM��Ĵ����͵Ĳ�������y_slm_para(�Ѿ�������side information)
%      2.paprs_SLM : �����������С��paprs_SLM,������PAPR-CCDFͼ

    global   ofdmCodeNums LN p 
    %��������Ż���SLM�㷨����PAPR
    y_slm_clipping_para = zeros(LN+1,ofdmCodeNums);%�����͵��ź�,��N+1�з���side information
    paprs_SLM = zeros(1,ofdmCodeNums);
    global Num_One  Num_More
    Num_One = 0; Num_More =0;
    sideInfoVs = zeros(1,ofdmCodeNums);
    for ii = 1:ofdmCodeNums
        [y_slm_clipping_para(:,ii), paprs_SLM(ii),sideInfoV]= OptiSLMProcessPerOFDMCode(y_para(:,ii));%�����ii��OFDM��Ԫ
        sideInfoVs(ii) = sideInfoV;
    end
    %y_para
    %y_slm_clipping_para
%     sideInfoVs
    disp('OFDM��Ԫ������Ŀ��'); Num_One + Num_More
    disp('ֻ����һ��IDFRFT�任�Ĵ�����'); Num_One
    disp('���ж��IDFRFT�任�Ĵ�����'); Num_More
    
    function [ofdmSLMPerCode,perVectorMinPaprValue,sideInfoV] = OptiSLMProcessPerOFDMCode( ofdmCode_Vector )
        % ���룺OFDM��һ����Ԫʸ��(����)
        % ���أ����side information�ĳ���ΪN+1�������͸�������PAPRֵ
        global M  N L U1  Q1 papr_th
        % ��U����ѡ��PAPR��С��
        ofdmSLMCodesCandidate = zeros(LN+1,U1);
        paprs = zeros(1,U1+1);
         %-------��ӹ���������-------------
            y_slm_oversample = [ofdmCode_Vector(1:N/2);zeros((L-1)*N,1);ofdmCode_Vector(N/2+1:end);zeros(1,1)];
            y_slm_oversample(end) = modulate(modem.qammod(M),0);
            %���Ƚ���һ��IDFRFT������PAPRֵ
            y_ofdm = L*dFRTPro(y_slm_oversample,-p); %LN+1��
            papr_first = per_Vector_PAPR_Calcu(y_ofdm);%LN+1����
            ofdmSLMCodesCandidate(:,1) = y_ofdm;%��������,��1��
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
                    y_slm_oversample(end) = modulate(modem.qammod(M),iii-1);%���͵��Ǵ�0-U1
                    % ������λ����
                    y_slm_oversample(1:end-1) = Q1(:,iii).*y_slm_oversample(1:end-1);
                    % ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
                    y_ofdm = L*dFRTPro(y_slm_oversample,-p);%LN+1
                    ofdmSLMCodesCandidate(:,iii) = y_ofdm;%��������
                    %�������֮���PAPRֵ
                    paprs(iii) = per_Vector_PAPR_Calcu(ofdmSLMCodesCandidate(:,iii));%ע����LN����
                end 
                    perVectorMinPaprValue = min(paprs);
                    min_papr_indexs = find(paprs == perVectorMinPaprValue);
                    ofdmSLMPerCode = ofdmSLMCodesCandidate(:,min_papr_indexs(1));
                    sideInfoV  = min_papr_indexs(1);
                    if perVectorMinPaprValue < papr_th
                        %��һ���жϣ�PAPR�Ƿ�С��ָ����ֵ���������㣬���޷��㷨����
                        return
                    else%����Clipping �޷������ı���ȣ�������λ����
%                         disp('ddddddddddddddddd')
                        ofdmSLMPerCode = clipping(ofdmSLMPerCode);
%                         perVectorMinPaprValue
                        perVectorMinPaprValue = per_Vector_PAPR_Calcu(ofdmSLMPerCode);%LN+1����
%                         perVectorMinPaprValue
                    end
            end
    end

    function [ClippingPerCode] = clipping(ofdmClippingPerCode)
        %����Clipping�޷�������ÿһ��OFDM��Ԫ
        %������λ���䣬ֻ�ı���ȴ�С
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

