clear all
close all
clc
choose=0;
N=64;
w=boxcar(N);%矩形窗 0
N=64;
w1=triang(N);%三角窗 1
N=64;
w2=hann(N);%汉宁窗 2
N=64;
w3=hamming(N);%海明窗 3
N=64;
w4=blackman(N);%布拉克窗 4
N=64;
r=100;
w5=chebwin(N,r);%切比雪夫窗 5
N=64;
w6=bartlett(N);%巴特利特窗 6
N=200;
r=4.5;
w7=kaiser(N,r);%凯塞窗 7
switch choose
    case 0
wvtool(w);
case 1
wvtool(w1);
case 2
wvtool(w2);
case 3
wvtool(w3);
case 4
wvtool(w4);
case 5
wvtool(w5);
case 6
wvtool(w6);
case 7
wvtool(w7);
end
