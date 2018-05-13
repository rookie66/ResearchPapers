function [R_xl]=getR_xl(l)
global X
R_xl=X(l,:)'*X(l,:);
end