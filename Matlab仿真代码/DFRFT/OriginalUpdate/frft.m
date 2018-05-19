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
shft = rem((0:N-1)+fix(N/2),N)+1;%��λ��Ϊʲô�أ�6 7 8 9 10 (11) 1 2 3 4  5   �����N/2�ᵽǰ�棬����-N--N
%remȡģ������һ������������ͬ��mod��ڶ�������������ͬ
sN = sqrt(N);
a = mod(a,4);%ȡģ����,mod(-1,4)=3
% do special cases  �������
if (a==0), Faf = f; return; end; %��FRFT������0,�����в���
if (a==2), Faf = flipud(f); return; end;%��FRFT������2,�����·�ת
if (a==1), Faf(shft,1) = fft(f(shft))/sN; return; end %��FRFT������1,�����fft�任
%�����£�ѭ����λ����fft�����ʵ���鲿����ֵû��Ӱ�죬��ģҲû��Ӱ�죬ֻӰ����ʵ�����鲿�������ţ�Ҳ������λ
if (a==3), Faf(shft,1) = ifft(f(shft))*sN; return; end %��FRFT������3(-1),�����ifft�任
%ѭ����λ������ͬfft
% reduce to interval 0.5 < a < 1.5 
% ��Щ��û��return��û�н�����ֻ�ǽ��������͵�0.5-1.5֮��
if (a>2.0), a = a-2; f = flipud(f); end
if (a>1.5), a = a-1; f(shft,1) = fft(f(shft))/sN; end
if (a<0.5), a = a+1; f(shft,1) = ifft(f(shft))*sN; end
% the general case for 0.5 < a < 1.5
alpha = a*pi/2;
tana2 = tan(alpha/2);
sina = sin(alpha);
f = [zeros(N-1,1) ; interp(f) ; zeros(N-1,1)];%4N-3
%���Ҳ�ֵ����f��N���в���N-1���㣬����2N-1���ȵ�����
%ǰ����,2*(N-1)+2N-1 = 4N-3����

% chirp premultiplication
chrp = exp(-1i*pi/N*tana2/4*(-2*N+2:2*N-2)'.^2);
%gama-beta=tan(alpha/2)
%�����ֹ���
% -2*N+2:2*N-2��4N-1����
f = chrp.*f;%����ĺ���һ����
% chirp convolution
c = pi/N/sina/4;
Faf = fconv(exp(1i*c*(-(4*N-4):4*N-4)'.^2),f);%��ɾ������
Faf = Faf(4*N-3:8*N-7)*sqrt(c/pi);%����A_alpha/2deltaX
% chirp post multiplication
Faf = chrp.*Faf;
% normalizing constant
Faf = exp(-1i*(1-a)*pi/4)*Faf(N:2:end-N+1);
%Fafȥ����ͷ��N-1������Ȼ���м���Ϊ2����
%exp(-1i*(1-a)*pi/4)��һ��������a=1ʱ��ֵΪ1.
%normalizing constant��һ������

function xint=interp(x)
% ���Ҳ�ֵ sinc interpolation
N = length(x);
y = zeros(2*N-1,1);%����N-1����
y(1:2:2*N-1) = x;
xint = fconv(y(1:2*N-1), sinc((-(2*N-3):(2*N-3))'/2)); 
%��ֵ����Ҫ�õ�����㷨���������FFTʵ�ּ���
%[-(2*N-3):(2*N-3)]'/2�ȼ���-(N-1.5):0.5:N-1.5,��4N-5����
%y(1:2*N-1)��2N-1����
%���֮��4N-5+2N-1-1= 6N-7
xint = xint(2*N-2:end-2*N+3);%end = 6N - 7

function z = fconv(x,y)% ͨ��FFT������
% convolution by fft
N = length([x(:);y(:)])-1;%�൱��L=N+M-1
P = 2^nextpow2(N);%���ش���N����ӽ�N��2����(���ڻ����N)
z = ifft( fft(x,P) .* fft(y,P));
z = z(1:N);%ȡ������Ľ��