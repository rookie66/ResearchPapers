function [R_Rinl]=getR_Rinl(l)
R_xl=getR_xl(l);   %����R_xl ����ô����ģ�����������
sigema2=0.01;
global G2
R_Rinl=G2*R_xl*G2'+sigema2*eye(4);
end