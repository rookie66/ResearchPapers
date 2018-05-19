function [R_Cinl]=getR_Cinl(P_R,l)
global L L_total sigma2_C
if (l>0) && (l<L_total+1)
   if l<L+1
       R_Ci=getR_Ci(P_R);
       R_Cinl=R_Ci+sigma2_C*eye(4,4);
   else 
       R_Cinl=sigma2_C*eye(4,4);
   end
end
end