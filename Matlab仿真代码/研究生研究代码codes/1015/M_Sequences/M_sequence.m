%%Matlab本源多项式生成M序列1-m-sequence
%本原多项式
% x^2+x+1;            g=[1;1];
% x^3+x+1;            g=[1;0;1];
% x^4+x+1;            g=[1;0;0;1];
% x^5+x^2+1;          g=[0;1;0;0;1];
% x^6+x+1;            g=[1;0;0;0;0;1];
% x^7+x^3+1;          g=[0;0;1;0;0;0;1];
% x^8+x^4+x^3+x^2+1;  g=[0;1;1;1;0;0;0;1];
% x^9+x^4+1;          g=[0;0;0;1;0;0;0;0;1];
% x^10+x^3+1;         g=[0;0;1;0;0;0;0;0;0;1];

% g=[1;0;0;1];
%g=[1;0;0;0;0;1];
%g=[0;1;1;1;0;0;0;1];
g=[1;0;1;0;0;0;1;0;0;1];
n=length(g);
m_minlen=2^n;
blk=1;
m_len=(m_minlen-1)*blk;
a=zeros(1,n);
a(1)=1;
m_sequence_out_s=zeros(1,m_len);

for ii=1:m_len
    m_sequence_out_s(ii)=a(n);
    %tmp=mod(a(1)+a(4),2);
    tmp=mod(a*g,2);
    a=[tmp a(1:n-1)];
end

m_sequence_out_d=1-2*m_sequence_out_s;
stairs(m_sequence_out_d); 

r_len=512;
r_m_value=zeros(1,r_len);

% for jj=1:m_len
%     m_sequence_delay=[m_sequence_out_d(jj:m_len) m_sequence_out_d(1:jj-1)];
%     r_m_value(jj)=sum(m_sequence_out_d.*m_sequence_delay)/m_len;
% end

for jj=1:r_len
    for ii=1:m_len;
    r_m_value(jj)=r_m_value(jj)+(m_sequence_out_d(ii)*m_sequence_out_d(mod(ii+jj-2,m_len)+1))/m_len;
    end
end
%length(r_m_value)
figure;plot(r_m_value);