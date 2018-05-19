function [y_R_radar]=y_R_add(beta,v_r,v_t,theta,P,s,K,L_PRI)
y_R_radar=0;
for l=1:L_PRI
  for i=1:K
    y_R_radar(l) = y_R_radar(l)+ beta(k)*v_r(theta(k))*conj(v_t(theta(k)))'*P*s(l-l_k);
  end
end
end
