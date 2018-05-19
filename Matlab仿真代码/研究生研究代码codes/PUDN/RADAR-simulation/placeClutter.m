function h=placeClutter(h,XY)
% h=placeClutter(h,XY)
% This function adds a mountain (clutter) at cordinate XY    

    mountains = h.mountains;
    RCS = 1e4;
    mountains(end+1).RCS =RCS;
    mountains(end).XY = XY;
    mountains(end).v = [0 0];
    mountains(end).a = [0 0];
    mountains(end).maneuverability = 0;
    h.mountains = mountains(:);
    guidata(h.radarDisplay,h);