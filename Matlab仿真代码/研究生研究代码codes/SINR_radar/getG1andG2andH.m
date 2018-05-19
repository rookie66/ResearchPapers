function [G1,G2,H]=getG1andG2andH()
G1= normrnd(0,sqrt(0.01),[4,4]);%方差是0.01，标准差需开方，为0.1
G2= normrnd(0,sqrt(0.01),[4,4]);%方差是0.01，标准差需开方，为0.1
H = normrnd(0,sqrt(1),[4,4]);%方差是11，标准差需开方，为1
end
