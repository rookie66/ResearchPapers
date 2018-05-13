% function Sim_MIMO_OFDM()
% mcc -m -B sgl Sim_MIMO_OFDM

clear all; clc; fprintf('Start! Please waiting to inspect the results ...\n\n');

% Initial Processing:
% Define the slot structure
Nc = 512; Ng = 32; Ns = Nc + Ng; Nu = Nc; Num_Block = 1;
Fs = 20e6; T = 1/Fs; Tg = T * Ng; Tu = T * Nc; Ts = T * Ns; DeltaF = 1/Tu; B = DeltaF*Nu;
ModScheme = '16QAM'; M = 16; Num_TxAnt = 4; Num_RxAnt = 4;

Num_Bit_Frame = Num_Block * Nu * log2( M ) * Num_TxAnt; Num_Sym_Frame = Num_Bit_Frame / log2(M);

Gen_Poly = [13 15]; Len_Constr = 4; Len_Mem = 3; k = 1; n = 3; Rate = k / n; Trellis = poly2trellis( Len_Constr,Gen_Poly,Gen_Poly(1) );
Alg = 1; Num_Iter_Decode = 8; Num_InforBit = 2048; Num_CodeBit = Num_InforBit / Rate + Len_Mem * 4;
Puncture_Pattern = [1 1; 1 0; 0 1]; [1; 1; 1]; [1 1; 1 0; 0 1]; [1 1 1 1; 1 0 0 0; 0 0 1 0]; [1 1 1 1 1 1; 1 0 0 0 0 0; 0 0 0 1 0 0]; [1 1 1 1 1 1 1 1 1 1; 1 0 0 0 1 0 0 1 0 0; 0 0 1 0 0 1 0 0 0 1];
Len_Pattern = prod( size( Puncture_Pattern ) ); Num_Reserved = sum( sum( Puncture_Pattern,1 ),2 ); Num_Punctured = Len_Pattern - Num_Reserved;
Rate = size( Puncture_Pattern,2 ) / Num_Reserved;

Puncture_Pattern = reshape( Puncture_Pattern,1,Len_Pattern ) ;
if ( Num_Bit_Frame - fix( Num_Bit_Frame / Num_Reserved ) * Num_Reserved ) == 0;
Num_CodeBit_Frame = fix( Num_Bit_Frame / Num_Reserved ) * Len_Pattern;
else

for i = 1 : Len_Pattern
if sum( Puncture_Pattern( 1:i ) ) == ( Num_Bit_Frame - fix( Num_Bit_Frame / Num_Reserved ) * Num_Reserved )
Num_CodeBit_Frame = fix( Num_Bit_Frame / Num_Reserved ) * Len_Pattern + i;
end
end
end
while mod( Num_CodeBit_Frame,Num_CodeBit ) ~= 0
Num_InforBit = Num_InforBit - 1; Num_CodeBit = Num_InforBit * n / k + Len_Mem * 4;
end
Num_CodeBlock = Num_CodeBit_Frame / Num_CodeBit; Num_InforBit_Frame = Num_InforBit * Num_CodeBlock; Rate_Source = Num_InforBit_Frame / Num_Bit_Frame;
[Temp, Inner_Interlver] = sort( rand( 1,Num_InforBit ) ); Inner_Interlver = Inner_Interlver -1;
[Temp, Outer_Interlver] = sort( rand( 1,Num_Bit_Frame ) );


% Define the channel profile
% Path_Gain = [ 1 ]; Path_Delay = [0]; ChannelProfile = 'AWGN';
% Path_Gain = [0.9977 0.0680]; Path_Delay = [0 2]; ChannelProfile = 'ITU Pedestrian A';
% Path_Gain = [0.6369 0.5742 0.3623 0.2536 0.2595 0.0407]; Path_Delay = [0 1 4 6 11 18]; ChannelProfile = 'ITU Pedestrian B';
Path_Gain = [0.6964 0.6207 0.2471 0.2202 0.1238 0.0696]; Path_Delay = [0 1 2 3 4 5] + 1; ChannelProfile = 'ITU Vehicular A';
%Path_Gain = [0.4544 0.4050 0.3610 0.3217 0.2867 0.2555 0.2277 0.2030 0.1809 0.1612 0.1437 0.1281...
% 0.1141 0.1017 0.0907 0.0808 0.0720 0.0642 0.0572 0.0510 0.0454 0.0405 0.0361 0.0322];
%Path_Delay = [0 7 14 22 29 37 45 52 59 67 75 82 90 97 104 112 119 127 135 142 150 157 164 172] + 1; ChannelProfile = 'Exponential Decay Model';
Num_Path = length( Path_Gain ); Max_Delay = max( Path_Delay );
Fc = 3e9; V = 3; Fd = V * Fc / 3e8 * 1000 / 3600; Phase = 2 * pi * rand( 1,Num_Path*Num_RxAnt*Num_TxAnt );


% Save simulation parametes
% FileName = 'Sim_MIMO_OFDM.dat';
% % % FileName = 'Sim_MIMO_OFDM.dat';
% Fid = fopen(FileName,'a+'); fprintf(Fid,'\n\n');fprintf(Fid,['%% Created by ZZG from <' mfilename '.m> at ' datestr(now),'\n']);
% fprintf(Fid,'%% Num_Path = %d vehicle speed = %d carrier frequency = %e doppler frequency spread = %f normalized doppler shift = %f\n',Num_Path,V,Fc,Fd,Fd*Ts);
% fprintf(Fid,'%% system bandwidth = %e number of subcarriers = %d subcarrier spacing = %e\n',B,Nc,DeltaF);
% fprintf(Fid,'%% sampling duration = %e symbol duration = %e guard duration = %e \n',T,Ts,Tg);
% fprintf(Fid,'%% (%d, %d, %d) Generator = %s Num_InforBit = %d Num_CodeBlock = %d Num_InforBit_Frame = %d Rate = %f \n',n,k,Len_Constr,num2str( Gen_Poly ),Num_InforBit,Num_CodeBlock,Num_InforBit_Frame,Rate);
% fprintf(Fid,'%% Num_Block = %d ModScheme = %s Num_TxAnt = %d Num_RxAnt = %d\n',Num_Block,ModScheme,Num_TxAnt,Num_RxAnt);
% fprintf(Fid,'%% channel profile = %s\n',ChannelProfile );
% fprintf(Fid,'%% SNR BER FER \n\n'); fclose(Fid);

% [(0 : 1 : 3) (4 : 0.5 : 6)]
% Main loop
SNR = [( 9:1:9 ) ]; MinSNR = min(SNR); MaxSNR = max(SNR); BER = []; FER = []; Num_Iter = 6; Num_Frame = 10;

for Index = 1 : length( SNR )
% profile on -detail builtin
StartPoint = 0; snr = SNR( Index )
EbN0 = 10^( snr / 10 ); Es = 1; N0 = Es * Num_RxAnt / ( EbN0 * Rate * Nu/Ns * log2(M) * Num_TxAnt ); Var = N0;
ErrNum_Bit = zeros( 1,Num_Iter ); ErrNum_Frame = zeros( 1,Num_Iter ); ErrRate_Bit = zeros( 1,Num_Iter ); ErrRate_Frame = zeros( 1,Num_Iter );


for Frame = 1 : Num_Frame
tic;
% Transmitter
Data_In = randint( 1,Num_InforBit_Frame );
for i = 1 : Num_CodeBlock
 Data_EnCode( (i-1)*Num_CodeBit+(1:Num_CodeBit) ) = Enc_Conv( Data_In( (i-1)*Num_InforBit+(1:Num_InforBit) ),Trellis,InitState,Terminated );
%Data_EnCode( (i-1)*Num_CodeBit+(1:Num_CodeBit) ) = Enc_Turbo_3gpp( Data_In( (i-1)*Num_InforBit+(1:Num_InforBit) ),Gen_Poly,Len_Constr,Inner_Interlver );
end
Data_EnCode = Puncture( Data_EnCode,Puncture_Pattern );
Sym_In = reshape( Mapping( Data_EnCode( Outer_Interlver ),ModScheme ),Num_TxAnt,Nu*Num_Block ) / sqrt( Num_TxAnt );
for TxAnt = 1 : Num_TxAnt
Temp = reshape( Sym_In( TxAnt,: ),Nc,Num_Block ); Temp = ifft( Temp,Nc,1 ) * sqrt( Nc );
TransSig( TxAnt,: ) = reshape( [Temp( Nc-Ng+1:Nc,: );Temp],1,Ns*Num_Block );
end

% Channel
ChannelCoeff = MultiPathChannel( repmat( Path_Gain,1,Num_RxAnt*Num_TxAnt ),Fd,Ts,Num_Block,StartPoint,Phase ); StartPoint = StartPoint + Num_Block;
% ChannelCoeff = diag( repmat( Path_Gain,1,Num_RxAnt*Num_TxAnt ) ) * ( randn( Num_Path*Num_RxAnt*Num_TxAnt,Num_Block ) + sqrt( -1 ) * randn( Num_Path*Num_RxAnt*Num_TxAnt,Num_Block ) ) / sqrt( 2 );
ChannelOut = zeros( Num_RxAnt,Ns*Num_Block+Max_Delay-1 );
for TxAnt = 1 : Num_TxAnt
h( Path_Delay,1:Num_Block ) = ChannelCoeff( (RxAnt-1)*Num_Path*Num_TxAnt + (TxAnt-1)*Num_Path + (1:Num_Path) );
H( RxAnt,TxAnt,: ) = reshape( fft( h,Nc,1 ),1,Nc*Num_Block );
for i = 1 : Num_Block
Temp = ChannelOut( RxAnt, (i-1)*Ns + (1:Ns+Max_Delay-1) );
ChannelOut( RxAnt,(i-1)*Ns + (1:Ns+Max_Delay-1) ) = Temp + conv( h(:,i),TransSig( TxAnt,(i-1)*Ns + (1:Ns) ) );
end
end
end
RecSig = ChannelOut + sqrt( Var ) * ( randn( size( ChannelOut ) ) + sqrt( -1 ) * randn( size( ChannelOut ) ) ) / sqrt( 2 );
clear ChannelCoeff h ChannelOut;

% Receiver
RecSig = RecSig( :,1:Ns*Num_Block );
for RxAnt = 1 : Num_RxAnt
Temp = reshape( RecSig( RxAnt,: ),Ns,Num_Block ); RecSig_Fre( RxAnt,: ) = reshape( fft( Temp( Ng+1:Ns,: ) ) / sqrt( Nc ),1,Nc*Num_Block );
end
Y = RecSig_Fre; HH = H / sqrt( Num_TxAnt );

clear RecSig RecSig_Fre H;

Lu_Pri = zeros( 1,Num_InforBit_Frame ); Lc_Pri = zeros( 1,Num_Bit_Frame );
for Iter = 1 : Num_Iter
Lc_Extr = MMSE_Equ( Y,HH,Lc_Pri,Num_RxAnt,Num_TxAnt,ModScheme,Var,1);
DeInterlv( Outer_Interlver ) = Lc_Extr;
Lc_Pri = DePuncture( DeInterlv,Num_CodeBit_Frame,Puncture_Pattern );
for i = 1 : Num_CodeBlock
% [Temp, Lc_Extr( (i-1)*Num_CodeBit+(1:Num_CodeBit) )] = ......
% LOG_MAP( zeros( 1,Num_InforBit + Len_Mem ),Lc_Pri( (i-1)*Num_CodeBit+(1:Num_CodeBit) ),Trellis,1 );
% Data_Out( (i-1)*Num_InforBit+(1:Num_InforBit) ) = ( sign( Temp( 1:Num_InforBit ) ) + 1 ) / 2;
[Data_Out( (i-1)*Num_InforBit+(1:Num_InforBit) ),Lu_Extr( (i-1)*Num_InforBit+(1:Num_InforBit) ),Lc_Extr( (i-1)*Num_CodeBit+(1:Num_CodeBit) )] = ......
Dec_Turbo_3gpp( Lu_Pri( (i-1)*Num_InforBit+(1:Num_InforBit) ),Lc_Pri( (i-1)*Num_CodeBit+(1:Num_CodeBit) ),Trellis,Inner_Interlver,Alg,Num_Iter_Decode );
end
Lc_Extr = Puncture( Lc_Extr,Puncture_Pattern ); Lc_Pri = Lc_Extr( Outer_Interlver );
Error = sum( sum( sign( abs( Data_Out - Data_In ) ) ) ); ErrNum_Bit( 1,Iter ) = ErrNum_Bit( 1,Iter ) + Error;
 if ( Error ~= 0 )
    ErrNum_Frame( 1,Iter ) = ErrNum_Frame( 1,Iter ) + 1;
 end
ErrRate_Bit( 1,Iter ) = ErrNum_Bit( 1,Iter ) / Frame / Num_InforBit_Frame; ErrRate_Frame( 1,Iter ) = ErrNum_Frame( 1,Iter ) / Frame;
end
Frame
ErrRate_Bit
ErrRate_Frame
toc;
end
