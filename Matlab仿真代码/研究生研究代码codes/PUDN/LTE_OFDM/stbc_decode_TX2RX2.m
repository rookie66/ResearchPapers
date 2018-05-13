function output=stbc_decode_TX2RX2(H,R)
%----------------------------------------------------------------------
%在两发两收条件下对接收信号进行译码
%H为接收端已知的信道矩阵，H的第一列与第二列分别为第一个发送天线与第一个接收天线和第二个接收天线间的信道参数；
%H的第三列与第四列分别为第二个发送天线与第一个接收天线和第二个接收天线间的信道参数；
%H的行数为OFDM符号的子载波数；
%H为频域的信道；
%R是接收的信号，R的列与H的列相对应；
%output是接收端进行合并后的信号
%-----------------------------------------------------------------------
Nc=size(H,1);%子载波数
H11=H(:,1);%1发送天线--》1接收天线信道参数
H12=H(:,2);%1发送天线--》2接收天线信道参数
H21=H(:,3);%2发送天线--》1接收天线信道参数
H22=H(:,4);%2发送天线--》2接收天线信道参数
R11=R(:,1);%1发送天线发送的第一个符号
R12=R(:,2);%1发送天线发送的第二个符号
R21=R(:,3);%2发送天线发送的第一个符号
R22=R(:,4);%2发送天线发送的第二个符号
for i=1:1:Nc
    Xe(i,1)=(R11(i)*conj(H11(i))+conj(R12(i))*H21(i)+R21(i)*conj(H12(i))+conj(R22(i))*H22(i))/( H11(i)*conj(H11(i)) + H21(i)*conj(H21(i)) + H12(i)*conj(H12(i)) + H22(i)*conj(H22(i)));
    Xo(i,1)=(R11(i)*conj(H21(i))-conj(R12(i))*H11(i)+R21(i)*conj(H22(i))-conj(R22(i))*H12(i))/( H11(i)*conj(H11(i)) + H21(i)*conj(H21(i)) + H12(i)*conj(H12(i)) + H22(i)*conj(H22(i)));
end
output=2*[Xe Xo];