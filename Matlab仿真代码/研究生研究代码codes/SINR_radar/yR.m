P
[G1 G2]=getG1andG2();
v_r
v_t
x
s
w_R
total
for l=1:L_PRI
    y_R(l)=G2*x(l)*exp(j*alpha2(l))+w_R(l)+y_R_radar(l);
end

