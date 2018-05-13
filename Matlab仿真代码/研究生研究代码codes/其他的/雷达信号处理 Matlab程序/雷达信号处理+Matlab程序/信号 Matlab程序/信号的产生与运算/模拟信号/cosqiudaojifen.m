%余弦函数的求导和积分
t=(-2:0.01:2)*pi;x=cos(t);
pp=spline(t,x);
int_pp=fnint(pp);
der_pp=fnder(pp);
subplot(2,2,1);
fnplt(pp,'b-');grid on;legend('x(t)');
subplot(2,2,2);
fnplt(int_pp,'r-');grid on;legend('S(t)');
subplot(2,2,3);
fnplt(der_pp,'k-');grid on;legend('dx/dt');