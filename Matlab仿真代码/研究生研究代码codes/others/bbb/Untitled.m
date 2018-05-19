%%demo of chirp signal after matched filter
T=10e-6;                            %pulse duration10us
B=30e6;                             %chirp frequency modulation bandwidth 30MHz
K=B/T;                              %chirp slope
Fs=10*B;Ts=1/Fs;                    %sampling frequency and sample spacing
N=T/Ts;
t=linspace(-T/2,T/2,N);
St=exp(j*pi*K*t.^2);                   %chirp signal
Ht=exp(-j*pi*K*t.^2);                  %matched filter
Sot=conv(St,Ht);                      %chirp signal after matched filter
subplot(211)
L=2*N-1;
t1=linspace(-T,T,L);
Z=abs(Sot);Z=Z/max(Z);                %normalize 
Z=20*log10(Z+1e-6);
Z1=abs(sinc(B.*t1));                   %sinc function
Z1=20*log10(Z1+1e-6);
t1=t1*B;                                         
plot(t1,Z,t1,Z1,'r.');
axis([-15,15,-50,inf]);grid on;
legend('emulational','sinc');
xlabel('Time in sec \times\itB');
ylabel('Amplitude,dB');
title('Chirp signal after matched filter');
subplot(212)                          %zoom
N0=3*Fs/B;
t2=-N0*Ts:Ts:N0*Ts;
t2=B*t2;
plot(t2,Z(N-N0:N+N0),t2,Z1(N-N0:N+N0),'r.');
axis([-inf,inf,-50,inf]);grid on;
set(gca,'Ytick',[-13.4,-4,0],'Xtick',[-3,-2,-1,-0.5,0,0.5,1,2,3]);
xlabel('Time in sec \times\itB');
ylabel('Amplitude,dB');
title('Chirp signal after matched filter (Zoom)');

