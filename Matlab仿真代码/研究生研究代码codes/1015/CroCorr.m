function [crossCorrNew,N]=CroCorr(x1,x2)
% 利用FFT计算自相关或互相关

% 测试
%x1 = [1 1 1 5 7];
%x2 = [1 2 3 2 9];
%y= CroCorr(x1,x2);
%等价于 xcorr(x1,x2)
%round(y)
%round(xcorr(x1))

k1 = length(x1);
k2 = length(x2);
k = k1;
if k1<k2
    k = k2;
end
X1 = fft(x1,2*k-1);
X2 = fft(x2,2*k-1);
X12 = X1.*conj(X2);
crossCorr = ifft(X12,2*k-1);
crossCorrNew(k:2*k-1) = crossCorr(1:k);
for i= k+1:2*k-1
    crossCorrNew(i-k) = crossCorr(i);
end
N = length(crossCorrNew);
end
