%Matlab code for sinc interpolation
function y = sinc_interp(x,u)
    %  ԭ����x
    m = 0:length(x)-1;
    U = length(u);
    y = zeros(1,U);
    for i=1:U
      y(i) = sum(x.*sinc(m- u(i)));%��m��u(i)���ʱ��sinc(0)=1
      %sinc����������(��0����)��,ֵ����0;
      %����m�������������Ե�u(i)Ϊ����ʱ��sinc(m-u(i))=[00...00 100..00](ѡ��1���ڵ�λ��)
      %��u(i)����������ʱ�򣬴�ʱm-u(i)����һ�����У�sinc(m-u(i))�������һ��������������Ҫ�����λ��
      %����ܴ�Լ0.97֮�ϣ��������㶼��С��������֤�ó����µ������ֵ��������
    end
end

