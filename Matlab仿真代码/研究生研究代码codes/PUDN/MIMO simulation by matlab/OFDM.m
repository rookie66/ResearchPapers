%==========================================================================
%
%Chuong trinh chinh OFDM
%
%==========================================================================

clear all;
NFFT=64;			%Number of subcarriers
G=9;					%khoang bao ve
M_ary=16;
t_a=50*10^(-9);
%load rho.am -ascii;
%khai luon rho, khong load tu file
rho=[1.0, 0.6095, 0.4945, 0.3940, 0.2371, 0.19, 0.1159, 0.0699, 0.0462]
h=sqrt(rho);
N_P=length(rho);

H=fft([h, zeros(1,NFFT-N_P)]);			%bien doi Fourier
NofOFDMSymbol=100;									%thoi gian ky tu OFDM
length_data=(NofOFDMSymbol)*NFFT;

%tao ma tran binary
source_data=randint(length_data,sqrt(M_ary));

%chuyen thanh decimal
symbols=bi2de(source_data);

%Dieu che OFDM bang tan co so
%QAM_Symbol=dmodce(symbols,1,1,'qam',M_ary);
h = modem.qammod('M',M_ary,'SymbolOrder','gray', 'InputType', 'integer');
QAM_Symbol=modulate(h,symbols);
df = 20;%ÆµÂÊ·Ö±æÂÊ
QAM_Symbol= repmat(QAM_Symbol,df,1);
N = 1000
QAM_Symbol = reshape(QAM_Symbol,[1,length(QAM_Symbol)]);


Data_Pattern=[];
for i=0:NofOFDMSymbol-1;
    QAM_tem=[];
    for n=1:NFFT;
        QAM_tem=[QAM_tem,QAM_Symbol(i*NFFT+n)];
    end;
    Data_Pattern=[Data_Pattern;QAM_tem];
    clear QAM_tem;
end;
ser=[];
snr_min=0;
snr_max=25;
step=1;
for snr=snr_min:step:snr_max;
    snr=snr-10*log10((NFFT+G)/NFFT);
    rs_frame=[];
    for i=0:NofOFDMSymbol-1;

        %Dieu che OFDM
        OFDM_signal_tem= OFDM_Modulator(Data_Pattern(i+1,:), NFFT, G);
        rs=conv(OFDM_signal_tem,h);
        rs=awgn(rs, snr, 'measured','dB');						%them nhieu trang gaussian
        rs_frame=[rs_frame;rs];
        clear OFDM_signal_tem;
    end;
    
        %Thu OFDM
    Receiver_Data=[];
    d=[];
    data_symbol=[];
for i=1:NofOFDMSymbol;
    if (N_P>G+1)&(i>1)
        previous_symbol=rs_frame(i-1,:);			%row i-1, all column
        ISI_term=previous_symbol(NFFT+2*G+1:NFFT+G+N_P-1);
        ISI=[ISI_term, zeros(1,length(previous_symbol)-length(ISI_term))];
        rs_i=rs_frame(i,:)+ISI;
    else
        rs_i=rs_frame(i,:);				%row i, all column
    end

       % Giai dieu che OFDM
    Demodulated_signal_i=OFDM_Demodulator(rs_i,NFFT,NFFT,G);
    d=Demodulated_signal_i./H;
    demodulated_symbol_i=ddemodce(d,1,1,'QAM',M_ary);			%giai dieu che
    data_symbol=[data_symbol,demodulated_symbol_i];
end;
data_symbol=data_symbol';
%Compute number of symbol errors and symbol error rate
[number,ratio]=symerr(symbols,data_symbol);
ser=[ser,ratio];
end;
%ve do thi
snr=snr_min:step:snr_max;
semilogy(snr,ser,'bo-', 'linewidth', 2);
Title('Estimate SNR - BER','fontsize', 16);
ylabel('BER','fontsize', 14);
xlabel('SNR in dB of OFDM Channel','fontsize', 14);
grid on;
save OFDM_Res;
hold on;