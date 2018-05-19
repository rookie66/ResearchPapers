%%demo of LFM pulse radar
%=========================================================

function LFM_radar(T,B,Rmin,Rmax,R,RCS)
if nargin==0
    T=10e-6;                           %pulse duration 10us
    B=30e6;                            %chirp frequency modulation bandwidth 30MHz
    Rmin=10000;Rmax=15000;            %range bin
    R=[10500,11000,12000,12008,13000,13002]; %position of ideal point targets
    RCS=[1 1 1 1 1 1];                   %radar cross section
end
%=========================================================
%%Parameter
C=3e8;                                 %propagation speed
K=B/T;                                 %chirp slope
Rwid=Rmax-Rmin;                        %receive window in meter
Twid=2*Rwid/C;                          %receive window in second
Fs=5*B;Ts=1/Fs;                         %sampling frequency and sampling spacing
Nwid=ceil(Twid/Ts);                       %receive window in number
%==================================================================
%%Gnerate the echo      
t=linspace(2*Rmin/C,2*Rmax/C,Nwid);       %receive window
                                       %open window when t=2*Rmin/C
                                       %close window when t=2*Rmax/C                            
M=length(R);                            %number of targets                                        
td=ones(M,1)*t-2*R'/C*ones(1,Nwid);
Srt=RCS*(exp(j*pi*K*td.^2).*(abs(td)<T/2));%radar echo from point targets  
%=========================================================
%%Digtal processing of pulse compression radar using FFT and IFFT
Nchirp=ceil(T/Ts);                          %pulse duration in number
Nfft=2^nextpow2(Nwid+Nwid-1);             %number needed to compute linear 
                                         %convolution using FFT algorithm
Srw=fft(Srt,Nfft);                           %fft of radar echo
t0=linspace(-T/2,T/2,Nchirp); 
St=exp(j*pi*K*t0.^2);                       %chirp signal                
Sw=fft(St,Nfft);                             %fft of chirp signal
Sot=fftshift(ifft(Srw.*conj(Sw)));              %signal after pulse compression
%=========================================================
N0=Nfft/2-Nchirp/2;
Z=abs(Sot(N0:N0+Nwid-1));
Z=Z/max(Z);
Z=20*log10(Z+1e-6);
%figure
subplot(211)
plot(t*1e6,real(Srt));axis tight;
xlabel('Time in u sec');ylabel('Amplitude')
title('Radar echo without compression');
subplot(212)
plot(t*C/2,Z)
axis([10000,15000,-60,0]);
xlabel('Range in meters');ylabel('Amplitude in dB')
title('Radar echo after compression');
%=========================================================
