function [ y_no_Reduction_para,paprs_No_Reduction ] = NoPAPRReduction( y_para )
%不采用任何抑制PAPR的算法
%   dFRT
<<<<<<< HEAD
global ofdmCodeNums LN N L
=======
global ofdmCodeNums LN N L p
>>>>>>> 987a2b093037d32bcf97ba93f23655e90f5b8e94
y_no_Reduction_para = zeros(LN,ofdmCodeNums);%待发送的信号,第N+1行发送side information
paprs_No_Reduction = zeros(1,ofdmCodeNums);
 for ii = 1:ofdmCodeNums
     y_no_per = y_para(:,ii);
     y_no_oversample = [y_no_per(1:N/2);zeros((L-1)*N,1);y_no_per(N/2+1:end)];
     % 注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
<<<<<<< HEAD
     %y_ofdm = L*ifft(y_no_oversample,LN);%默认也是LN点ifft
     y_ofdm = L*dFRTPro(y_no_oversample,-1);%默认也是LN点ifft
=======
     y_ofdm = L*dFRTPro(y_no_oversample,-p);%默认也是LN点ifft
>>>>>>> 987a2b093037d32bcf97ba93f23655e90f5b8e94
     y_no_Reduction_para(:,ii) = y_ofdm;
     paprs_No_Reduction(1,ii) = per_Vector_PAPR_Calcu(y_ofdm);
 end
end

