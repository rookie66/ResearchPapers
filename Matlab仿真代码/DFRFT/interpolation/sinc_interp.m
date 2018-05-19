%Matlab code for sinc interpolation
function y = sinc_interp(x,u)
    %  原序列x
    m = 0:length(x)-1;
    U = length(u);
    y = zeros(1,U);
    for i=1:U
      y(i) = sum(x.*sinc(m- u(i)));%当m与u(i)相等时，sinc(0)=1
      %sinc函数在整数(除0以外)处,值都是0;
      %由于m都是整数，所以当u(i)为整数时，sinc(m-u(i))=[00...00 100..00](选中1存在的位置)
      %当u(i)不是整数的时候，此时m-u(i)就是一个序列，sinc(m-u(i))结果存在一个特征，靠近需要插入的位置
      %结果很大，约0.97之上，而其他点都很小。这样保证得出的新点满足插值的条件。
    end
end

