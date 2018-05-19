%讨论不同的p有什么影响
p_s = 0.1:0.3:1.5;
global PAPRs_no PAPRs_slm BERs_no_s BERs_slm_s papr_base EbNos  index_p
global p papr_no_name papr_slm_name ber_no_name ber_slm_name matFiledir 
matFiledir = 'matFiles/';
papr_no_name = 'PAPR_no_p_';
papr_slm_name = 'PAPR_slm_p_';
ber_no_name = 'BER_no_p_';
ber_slm_name = 'BER_slm_p_';
PAPRs_no = zeros(length(p_s),length(papr_base));
PAPRs_slm = zeros(length(p_s),length(papr_base));
BERs_no_s = zeros(length(p_s),length(EbNos));
BERs_slm_s = zeros(length(p_s),length(EbNos));
index_p = 0;
for p1 = p_s
    index_p = index_p + 1;
    p = p1;
    p
    Main
end


