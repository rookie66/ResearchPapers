%矩形函数的求导与积分
t=-4:0.01:4;
x=rect(t);
pp=spline(t,x);
int_pp=fnint(pp) ;
der_pp=fnder(pp);
subplot(2,2,1);
fnplt(pp,'b-');grid on;axis([-4 4 -0.5 1.5]);legend('rect(t)');
subplot(2,2,2);
fnplt(int_pp,'r-');grid on;legend('S(t)');
subplot(2,2,3);
fnplt(der_pp,'k-');grid on;legend('dx/dt');