clear all
close all
clc
choose=0;
N=64;
w=boxcar(N);%���δ� 0
N=64;
w1=triang(N);%���Ǵ� 1
N=64;
w2=hann(N);%������ 2
N=64;
w3=hamming(N);%������ 3
N=64;
w4=blackman(N);%�����˴� 4
N=64;
r=100;
w5=chebwin(N,r);%�б�ѩ�� 5
N=64;
w6=bartlett(N);%�������ش� 6
N=200;
r=4.5;
w7=kaiser(N,r);%������ 7
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
