function Faf = frft(f, a)
% The fast Fractional Fourier Transform
% input: f = samples of the signal
%        a = fractional power
% output: Faf = fast Fractional Fourier transform

% H.M. Ozaktas, M.A. Kutay, and G. Bozdagi.
% [i]Digital computation of the fractional Fourier transform.[/i]
% IEEE Trans. Sig. Proc., 44:2141--2150, 1996.
narginchk(2,2);
f = f(:);
N = length(f);
shft = rem((0:N-1)+fix(N/2),N)+1;%移位，为什么呢？6 7 8 9 10 (11) 1 2 3 4  5   后面的N/2提到前面，构成-N--N
%rem取模结果与第一个参数符号相同，mod与第二个参数符号相同
sN = sqrt(N);
a = mod(a,4);%取模操作,mod(-1,4)=3
% do special cases  特殊情况
if (a==0), Faf = f; return; end; %当FRFT阶数是0,则序列不变
if (a==2), Faf = flipud(f); return; end;%当FRFT阶数是2,则上下翻转
if (a==1), Faf(shft,1) = fft(f(shft))/sN; return; end %当FRFT阶数是1,则就是fft变换
%讨论下：循环移位，对fft结果的实部虚部绝对值没有影响，对模也没有影响，只影响了实部和虚部的正负号，也就是相位
if (a==3), Faf(shft,1) = ifft(f(shft))*sN; return; end %当FRFT阶数是3(-1),则就是ifft变换
%循环移位的作用同fft
% reduce to interval 0.5 < a < 1.5 
% 这些并没有return，没有结束，只是将阶数降低到0.5-1.5之间
if (a>2.0), a = a-2; f = flipud(f); end
if (a>1.5), a = a-1; f(shft,1) = fft(f(shft))/sN; end
if (a<0.5), a = a+1; f(shft,1) = ifft(f(shft))*sN; end
% the general case for 0.5 < a < 1.5
alpha = a*pi/2;
tana2 = tan(alpha/2);
sina = sin(alpha);
f = [zeros(N-1,1) ; interp(f) ; zeros(N-1,1)];%4N-3
%正弦插值：在f的N点中插入N-1个点，返回2N-1长度的序列
%前后补零,2*(N-1)+2N-1 = 4N-3个点

% chirp premultiplication
chrp = exp(-1i*pi/N*tana2/4*(-2*N+2:2*N-2)'.^2);
%gama-beta=tan(alpha/2)
%两部分共用
% -2*N+2:2*N-2是4N-1个点
f = chrp.*f;%卷积的后面一部分
% chirp convolution
c = pi/N/sina/4;
Faf = fconv(exp(1i*c*(-(4*N-4):4*N-4)'.^2),f);%完成卷积部分
Faf = Faf(4*N-3:8*N-7)*sqrt(c/pi);%乘以A_alpha/2deltaX
% chirp post multiplication
Faf = chrp.*Faf;
% normalizing constant
Faf = exp(-1i*(1-a)*pi/4)*Faf(N:2:end-N+1);
%Faf去除两头的N-1个数，然后中间间隔为2递增
%exp(-1i*(1-a)*pi/4)是一个复数，a=1时，值为1.
%normalizing constant归一化常数

function xint=interp(x)
% 正弦插值 sinc interpolation
N = length(x);
y = zeros(2*N-1,1);%插入N-1个点
y(1:2:2*N-1) = x;
xint = fconv(y(1:2*N-1), sinc((-(2*N-3):(2*N-3))'/2)); 
%插值中需要用到卷积算法，卷积利用FFT实现计算
%[-(2*N-3):(2*N-3)]'/2等价于-(N-1.5):0.5:N-1.5,共4N-5个点
%y(1:2*N-1)共2N-1个点
%卷积之后：4N-5+2N-1-1= 6N-7
xint = xint(2*N-2:end-2*N+3);%end = 6N - 7

function z = fconv(x,y)% 通过FFT计算卷积
% convolution by fft
N = length([x(:);y(:)])-1;%相当于L=N+M-1
P = 2^nextpow2(N);%返回大于N且最接近N的2的幂(大于或等于N)
z = ifft( fft(x,P) .* fft(y,P));
z = z(1:N);%取出卷积的结果