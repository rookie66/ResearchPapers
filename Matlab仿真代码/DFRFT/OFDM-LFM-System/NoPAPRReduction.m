function [ y_no_Reduction_para,paprs_No_Reduction ] = NoPAPRReduction( y_para )
%�������κ�����PAPR���㷨
%   dFRT
<<<<<<< HEAD
global ofdmCodeNums LN N L
=======
global ofdmCodeNums LN N L p
>>>>>>> 987a2b093037d32bcf97ba93f23655e90f5b8e94
y_no_Reduction_para = zeros(LN,ofdmCodeNums);%�����͵��ź�,��N+1�з���side information
paprs_No_Reduction = zeros(1,ofdmCodeNums);
 for ii = 1:ofdmCodeNums
     y_no_per = y_para(:,ii);
     y_no_oversample = [y_no_per(1:N/2);zeros((L-1)*N,1);y_no_per(N/2+1:end)];
     % ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
<<<<<<< HEAD
     %y_ofdm = L*ifft(y_no_oversample,LN);%Ĭ��Ҳ��LN��ifft
     y_ofdm = L*dFRTPro(y_no_oversample,-1);%Ĭ��Ҳ��LN��ifft
=======
     y_ofdm = L*dFRTPro(y_no_oversample,-p);%Ĭ��Ҳ��LN��ifft
>>>>>>> 987a2b093037d32bcf97ba93f23655e90f5b8e94
     y_no_Reduction_para(:,ii) = y_ofdm;
     paprs_No_Reduction(1,ii) = per_Vector_PAPR_Calcu(y_ofdm);
 end
end

