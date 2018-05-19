function h = plotTarget( target,handles)
% This function plots a target in the radar display

    x = target.pos(1);
    y = target.pos(2);
%     targetsAngle = mod(atan2(y,x),2*pi);
    targetsAngle = atan2(y,x);
    v = target.v;
    switch v
    case 12345
        % This target was detected without MTI so it isn't known if it is
        % clutter or plane...
        c = 'r';
        h = plot(handles.radarDisplay, x,y,'X','MarkerSize',7,'linewidth',2,'tag','foundTarget','color',c);
    case 0
        % this is clutter (mountain)
        h = plot(handles.radarDisplay,x,y,'^k','MarkerFaceColor','k','tag','foundTarget');
    otherwise
        yDir = -sign(y);
        xDir = -1;
        h = quiver(handles.radarDisplay,x,y,xDir*v*cos(targetsAngle),yDir*v*abs(sin(targetsAngle)),20,...
            'color','r','linewidth',1,'marker','X','MarkerSize',7,'tag','foundTarget');
    end
