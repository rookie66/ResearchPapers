function fsrgui(mode)


if nargin == 0, mode = 0; end

if mode ~= 0,
   f = gcf;
   ui = get(f,'userdata');
   filter_pop  = ui(4);
   n_edt       = ui(6);
   cutoff_edt  = ui(9);
   autoplot    = ui(21);
   plot_btn    = ui(22);
%   axs         = ui(23);
%   axs2        = ui(45);
   sig_axs     = ui(23);
   opr_axs     = ui(45);
   curs_btn = ui(15);
   curs_dsp = ui(11:14);
end

if mode == 0,


   grey = [0.5,0.5,0.5];
   ltgrey = grey*1.5;
   dkgrey = grey*0.5;
   scrn_size = get(0,'screensize');
   fig_w = 620; fig_h = 450;
   flft = (scrn_size(3) - fig_w)/2;
   fbtm = (scrn_size(4) - fig_h)/2;


   ver_str = version;
   ver4    = length(findstr('4.',ver_str));
   if ver4,
      int_str = 'yes';
      f = figure('pos',[flft,fbtm,fig_w,fig_h],'menubar','none',...
            'name','Fourier Series Response','numbertitle','off',...
            'resize','off','vis','off','interruptible',int_str,...
            'color',dkgrey,'defaultaxesfontsize',10,...
            'defaulttextfontsize',10,'windowbuttondownfcn','fsrgui(5)');
   else
      int_str = 'on';
      eval('f = colordef(''new'',''none'');');
      set(f,'pos',[flft,fbtm,fig_w,fig_h],'menubar','none',...
           'name','Fourier Series Response','numbertitle','off',...
           'resize','off','vis','off','interruptible',int_str,...
           'color',dkgrey,'defaultaxesfontsize',10,...
           'defaultuicontrolback',[0.5,0.5,0.5],...
           'defaulttextfontsize',10,'windowbuttondownfcn','fsrgui(5)');
   end



   uim(1) = uimenu('label','Info');
   uim(2) = uimenu(uim(1),'label','Help','callback','fsrhlp');
%   uim(3) = uimenu(uim(1),'label','Export data','separator','on',...
%                          'callback','');
   uim(4) = uimenu(uim(1),'label','Exit','separator','on',...
                          'callback','close(gcf)');




   lft = 10; btm = fig_h - 5;

   ui(1) = uicontrol('style','frame','pos',[5,btm-142+22-22,175,140-22+22],...
           'back',grey,'fore',ltgrey);

   btm = btm - 26;
   ui(2) = uicontrol('style','text','pos',[lft,btm,160,17],...
           'horiz','left','fore','r','string','Periodic Pulse Input');

   btm = btm - 22;
   ui(3) = uicontrol('style','text','pos',[lft,btm,40,17],...
           'string','Type','horiz','left');
   ui(4) = uicontrol('style','popup','pos',[lft+45,btm,120,20],...
           'string',['Rectangular|Sawtooth|Triangular|Trapezoidal|',...
                     'Sine Pulse|Exponential'],...
           'back','w','callback','fsrgui(1)');

   btm = btm - 22;
   ui(50) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','Time Period');
   ui(51) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','1','callback','fsrgui(3)');
   btm = btm - 22;
   ui(8) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','Duty Ratio');
   ui(9) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','0.5','callback','fsrgui(3)');

   btm = btm - 22;
   ui(33) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','Time Delay');
   ui(34) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','0','callback','fsrgui(3)');

   btm = btm - 22;
   ui(35) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','Flat Width','vis','off');
   ui(36) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','0.2','callback','fsrgui(3)','vis','off');

   ui(37) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','Exponent','vis','off');
   ui(38) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','-1','callback','fsrgui(3)','vis','off');

   ui(39) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','# of cycles','vis','off');
   ui(40) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','0.5','callback','fsrgui(3)','vis','off');


   uicontrol('style','frame','pos',[5,btm-40,175,27],...
           'back',grey,'fore',ltgrey);

   btm = btm - 35;

%   btm = btm - 22;
   ui(5) = uicontrol('style','text','pos',[lft,btm,100,17],...
           'horiz','right','string','# of Harmonics');
   ui(6) = uicontrol('style','edit','pos',[lft+105,btm,60,17],...
           'back','w','string','25','callback','fsrgui(3)');


%   btm = btm - 29;
   btm = btm - 35;
   ui(7) = uicontrol('style','frame','pos',[5,btm-130+55,175,120-20],...
           'back',grey,'fore',ltgrey);




   ui(16) = uicontrol('style','text','pos',[lft,btm,165,17],...
           'string','System Transfer Function','horiz','left','fore','c');

   btm = btm - 22; 
   %lft = lft + 5;
   ui(17) = uicontrol('style','text','pos',[lft,btm,30,17],...
           'string','Num','horiz','left');
   ui(18) = uicontrol('style','edit','pos',[lft+35,btm,130,17],...
           'back','w','string','1');

   btm = btm - 22;
   ui(19) = uicontrol('style','text','pos',[lft,btm,30,17],...
           'string','Den','horiz','left');
   ui(26) = uicontrol('style','edit','pos',[lft+35,btm,130,17],...
           'back','w','string','1');


   btm = btm - 25;

   ui(27) = uicontrol('style','push','pos',[lft+10,btm,70,20],...
           'string','Accept','callback','fsrplt');


   ui(28) = uicontrol('style','push','pos',[lft+89,btm,70,20],...
           'string','Reset','callback','fsrgui(2)');



   ui(20) = uicontrol('style','frame','pos',[5,btm-40,175,27],...
           'back',grey,'fore',ltgrey);

   btm = btm - 35;
   ui(21) = uicontrol('style','check','pos',[lft,btm,80,17],...
           'string','AutoPlot','callback','fsrgui(4)',...
           'value',0);
   ui(22) = uicontrol('style','push','pos',[lft+95,btm-2,70,20],...
           'string','Plot','callback','fsrplt');


   btm = btm -40+12;
   uicontrol('style','frame','pos',[5,btm-10-2-50,175,27+50],...
           'back',grey,'fore',ltgrey);

   btm = btm - 10;
   uicontrol('style','text','pos',[lft,btm,90,17],...
           'string','Convergence','fore','c');

   btm = btm - 22;
   ui(41) = uicontrol('style','text','pos',[lft,btm,90,17],...
           'string','Input','horiz','right');
   ui(42) = uicontrol('style','text','pos',[lft+95,btm,70,17],...
           'string','1/k','back',ltgrey);

   btm = btm - 22;
   ui(43) = uicontrol('style','text','pos',[lft,btm,90,17],...
           'string','Output','horiz','right');
   ui(44) = uicontrol('style','text','pos',[lft+95,btm,70,17],...
           'string','1/k','back',ltgrey);


%%%%%%%%%%%%%%%%%%%%% change position %%%%%%%%%%%%%%%%%%%%
   btm = btm -35;
   ui(15) = uicontrol('style','check','pos',[lft+95,btm,70,20],...
           'string','Cursor','back','y','callback','fsrgui(6)');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   pos = get(f,'pos');
   lef = pos(3)-166;
   bot = pos(4)-21;

%%%%%%   This also works
%   lef = fig_w-166;
%   bot = fig_h-21;

   ui(11) = uicontrol('style','text','pos',[lef,bot,20,20],...
           'string','X ','horiz','right');
   ui(12) = uicontrol('style','text','pos',[lef+20,bot,60,20],...
           'string','','back','w');
   ui(13) = uicontrol('style','text','pos',[lef+85,bot,20,20],...
           'string','Y ','horiz','right');
   ui(14) = uicontrol('style','text','pos',[lef+105,bot,60,20],...
           'string','','back','w');

   set(ui(11:14),'vis','off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%   ui(23) = axes('units','pixel','pos',[210,50,390,350],'box','on',...
%            'xlim',[0,1],'color','k');
   ui(23) = axes('units','pixel','pos',[210,255,390,160],'box','on',...
            'xgrid','on','ygrid','on','xlim',[0,1],'color','k');

   title('Periodic and Reconstructed Input ');
   xlabel('Time  [s]');

   ui(24) = line('xdata',0,'ydata',0,'color','y');
   ui(25) = line('xdata',0,'ydata',0,'color','g');
%   ui(45) = line('xdata',0,'ydata',0,'color','c');
   ui(45) = axes('units','pixel','pos',[210,40,390,160],'box','on',...
            'xgrid','on','ygrid','on','xlim',[0,1],'color','k');

   title('Reconstructed Output ');
   xlabel('Time  [s]');

   ui(46) = line('xdata',0,'ydata',0,'color','c');

   set(f,'userdata',ui);
   set(ui(7),'userdata',ui(23));




   fsrplt;

   drawnow;
   set(f,'vis','on');

elseif mode == 1, % signal popup

   signal_type = get(filter_pop,'value');

   if signal_type == 4
      set(ui(37:40),'vis','off');
      set([ui(35),ui(36)],'vis','on');
   elseif signal_type == 5
      set(ui(35:38),'vis','off');
      set([ui(39),ui(40)],'vis','on');
   elseif signal_type == 6
      set(ui(35:36),'vis','off');
      set(ui(39:40),'vis','off');
      set([ui(37),ui(38)],'vis','on');
   else
      set(ui(35:40),'vis','off');
   end

   if get(autoplot,'value'), fsrplt; end

elseif mode == 2, % reset
    set([ui(18),ui(26)],'string','1');
    fsrplt


elseif mode == 3, % edit fields
   if get(autoplot,'value'), fsrplt; end


elseif mode == 4, % auto plot

   if get(autoplot,'value'),
      set(plot_btn,'enable','off');
      fsrplt;
   else
      set(plot_btn,'enable','on');
   end

elseif mode == 5, % mouse functionality
   sel_type = get(f,'selectiontype');
   cur_obj = gco;
   cur_par = get(cur_obj,'parent');
   if cur_par == f,
      cur_axs = cur_obj;
   else
      cur_axs = cur_par;
   end
   if any(cur_axs == [sig_axs,opr_axs]),
      axes(cur_axs);
      if strcmp(sel_type,'open'),
%         tit_str = get(get(cur_axs,'title'),'string');
         axs_pos = get(cur_axs,'pos');
         if axs_pos(4) == 160, % need to maximize
               set([sig_axs,opr_axs],'vis','off');
            set(cur_axs,'pos',[210,40,390,370],'vis','on');

         else % minimization
              set(sig_axs,'pos',[210,255,390,160],'vis','on');
              set(opr_axs,'pos',[210,40,390,160],'vis','on');
         end
      else
      fsrgui(6);

      end
   end

elseif mode == 6, % cursor
    if get(curs_btn,'value')
    set(curs_dsp,'vis','on');

    set(f,'WindowButtonMotionFcn','fsrgui(7)');

    else

  set(f,'Pointer','arrow','WindowButtonMotionFcn','');


   set(curs_dsp,'vis','off')
   set(curs_btn,'value',0),

    end


elseif mode == 7, % cursor movement
       h=gca;
       set(f,'currentaxes',h);
       lim=get(h,'pos');  % get current axis position
       c_p = [lim(1) lim(1)+lim(3) lim(2) lim(2)+lim(4)];
       f_p=get(f,'CurrentPoint'); % get co-ordinates of current point

     if f_p(1) < c_p(1) | f_p(1) > c_p(2) | f_p(2) < c_p(3) | f_p(2) > c_p(4)
        set(f,'Pointer','arrow');

        set(curs_dsp(2),'string','');
        set(curs_dsp(4),'string','');

     else
        curr_pt=get(h,'CurrentPoint');  % get current mouse position
        set(f,'Pointer','crosshair');
        set(curs_dsp(2),'string',num2str(curr_pt(1,1)));
        set(curs_dsp(4),'string',num2str(curr_pt(1,2)));
     end

end


