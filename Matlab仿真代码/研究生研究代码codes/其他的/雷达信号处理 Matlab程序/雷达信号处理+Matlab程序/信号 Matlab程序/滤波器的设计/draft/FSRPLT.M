function fsrplt
% FSRPLT Plot control for FSRGUI.


f = gcf;
ui = get(f,'userdata');
type_pop    = ui(4);
num_edt     = ui(18);
den_edt     = ui(26);

n_edt       = ui(6);
duty_edt    = ui(9);
delay_edt   = ui(34);
exp_edt     = ui(38);
width_edt   = ui(36);
cycles_edt  = ui(40);
per_edt     = ui(51);

autoplot    = ui(21);
plot_btn    = ui(22);
axs         = ui(23);
axs2        = ui(45);
line1       = ui(24);
line2       = ui(25);
line3       = ui(46);



% Verify Transfer Function 

A = eval(['[',get(den_edt,'string'),']']);
B = eval(['[',get(num_edt,'string'),']']);

if ~any(A) | ~any(B)  % String of zeros
   errordlg('Num and Den must have nonzero elements.','Input Error');
   return;
end

while A(1) == 0
    A(1) = [];
end
while B(1) == 0
   B(1) = [];
end

%if length(B) > length(A), % Causality check
%   errordlg('Need Causal System (length(Num) <= length(Den).','Input Error');
%   return;
%end




signal_type = get(type_pop,'value');


if isempty(get(n_edt,'string')),
   errordlg('No value entered for # of harmonics.','Input Error');
   return
end
if isempty(get(per_edt,'string')),
   errordlg('No value entered for time period.','Input Error');
   return
end
if isempty(get(duty_edt,'string')),
   errordlg('No value entered for duty ratio.','Input Error');
   return
end
if signal_type == 4 & isempty(get(width_edt,'string')),
   errordlg('No value entered for flat width.','Input Error');
   return
end
if signal_type == 5 & isempty(get(cycles_edt,'string'))
   errordlg('No value entered for # of cycles.','Input Error');
   return
end
if signal_type == 6 & isempty(get(exp_edt,'string')),
   errordlg('No value entered for exponent.','Input Error');
   return
end
if isempty(get(delay_edt,'string')),
  TD = 0;
else
  TD = str2num(get(delay_edt,'string'));
end


n = str2num(get(n_edt,'string'));
D = str2num(get(duty_edt,'string'));
TD = str2num(get(delay_edt,'string'));
E = str2num(get(exp_edt,'string'));
W = str2num(get(width_edt,'string')); 
C = str2num(get(cycles_edt,'string'));
T = str2num(get(per_edt,'string'));
 

% verify lengths
   if T<=0
      errordlg('Time period must be positive.','Input Error');
      return;
   end

   if D >1 | D <= 0,
      errordlg('Duty Ratio must be 0 < D < 1.','Input Error');
      return;
   end

   if n ~= round(n) | n<1,
      errordlg('Must enter a positive integer for N.','Input Error');
      return;
   end
   if n>125
      errordlg('Maximum number of harmoincs allowed is 125.','Input Error');
      return;
   end

   if signal_type == 4
   if W < 0
      errordlg('Flat Width cannot be negative.','Input Error');
      return;

   elseif W >= D,
      errordlg('Flat Width must be less than Duty Ratio.','Input Error');
      return;
 
   end
   end

   if signal_type == 5
   if C <= 0
      errordlg('Number of cycles must be positive.','Input Error');
      return;
   end
   end

%%%%%% Make delay a fraction of period
TD=TD/T;


% compute Signal

if signal_type==1,
if D<1,
x='.5*(t==D)+(t>=0 & t<D)';
else,x='1+0*t';
end
conv=1;
set(ui(42),'string','1/k');

elseif signal_type==2,
if D<1,
x='0.5*(t==D)+t.*(t>=0 & t<D)/D';
else,x='t';
end
conv=1;
set(ui(42),'string','1/k');

elseif signal_type==3,
x='2*t.*(t>0 & t<=D/2)/D+(2-2*t/D).*(t>D/2 & t<=D)';
conv=2;
set(ui(42),'string','1/(k^2)');

elseif signal_type==4,

t1=0.5*(D-W);
t2=t1+W;
x='t.*(t>0&t<=t1)/t1+(t>t1&t<=t2)+(t-D).*(t>t2&t<=D)/(t2-D)';
conv=2;
set(ui(42),'string','1/(k^2)');

elseif signal_type==5,

if D<1,
x='sin(2*pi*t*C/D).*(t>=0 & t<D)+.5*sin(2*pi*C)*(t==D)';
else,
x='sin(2*pi*t*C/D)';
end
   if C/0.5==round(C/0.5),
      conv=2;
      set(ui(42),'string','1/(k^2)');
    else
      conv=1;
      set(ui(42),'string','1/k');
   end


elseif signal_type==6,

if D<1,
x='0.5*exp(D*E)*(t==D)+exp(E*t).*(t>=0 & t<D)';
else,
x='exp(E*t)';
end
conv=1;
set(ui(42),'string','1/k');
end

conv = conv+length(A)-length(B);
if conv == 1
      set(ui(44),'string','1/k');
else
      set(ui(44),'string',['1/(k^' int2str(conv) ')']);
end


% Compute FS Coeffs

td=rem(TD,1);
td=rem(1+td,1); % makes sure it is positive


del=1024;

t=0:1/del:1;
y=eval(x);


y(1)=0.5*(y(1)+y(length(y)));
ny=length(y)-1;


j=sqrt(-1);F=fft(y(1:ny))/ny;
dk=F(1:n+1);dk=dk.*(abs(dk)>100*eps);
dk=dk.*exp(-j*(0:n)*2*pi*td);
c0=dk(1);

ck=2*abs(dk(2:n+1));
tk=180*angle(dk(2:n+1))/pi;
i=find(180-abs(tk)<10000*eps);tk(i)=-180*ones(size(i));





axs_han=get(ui(7),'userdata');
m_title = get(axs_han,'title');
%m_xlabel = get(axs_han,'xlabel');
nbr = int2str(n);




la=length(A);
lb=length(B);
tr=0:1/400:1;
yr=c0+0*tr;

yw=c0*B(lb)/A(la)+0*tr; %dc output

if td == 0
t_data = t; y_data = y;
else
t_data = [t+td-1 t+td]; y_data = [y y];
end




for k=1:n,
sm=ck(k)*cos(2*k*pi*tr+tk(k)*pi/180);
h=polyval(B,j*k*2*pi/T)/polyval(A,j*k*2*pi/T);
sm1=abs(h)*ck(k)*cos(2*k*pi*tr+angle(h)+tk(k)*pi/180);
yr=yr+sm;
yw=yw+sm1;
end
%yrmax=max(yr);yrmin=min(yr);
yrmax=max([y_data yr]);yrmin=min([y_data yr]);
if yrmin~=0
yrmin=yrmin-0.05*yrmax;
end
yrmax=1.05*yrmax;
set(axs,'xlim',[0,T],'ylim',[yrmin,yrmax]);
%%% new  %%%
set(line1,'xdata',t_data*T,'ydata',y_data);
set(line2,'xdata',tr*T,'ydata',yr);
op_tit = ['Input(y) and Reconstructed Input(g) to k = ' nbr];
set(m_title,'string',op_tit);

ywmax=max(yw);ywmin=min(yw);
if ywmin~=0,
ywmin=ywmin-0.05*ywmax;
end
ywmax=1.05*ywmax;

set(axs2,'xlim',[0,T],'ylim',[ywmin,ywmax]);
set(line3,'xdata',tr*T,'ydata',yw);

%%%%%%%%%%%

