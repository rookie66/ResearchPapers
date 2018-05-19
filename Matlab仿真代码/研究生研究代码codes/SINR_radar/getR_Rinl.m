function [R_Rinl]=getR_Rinl(l)
R_xl=getR_xl(l);   %问题R_xl 是怎么计算的？？？？？？
sigema2=0.01;
global G2
R_Rinl=G2*R_xl*G2'+sigema2*eye(4);
end