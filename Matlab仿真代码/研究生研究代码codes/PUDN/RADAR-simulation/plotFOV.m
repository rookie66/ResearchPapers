function [handles] = plotFOV(handles,t,w,radarSector,maxDist,isPersistentDisplay)
% this function updates the radar display

%     figure(handles.figure1);
    % Deleting old targets (which the scan just past it)
    radarAngle = mod(w*t, 2*pi);
    deletedTargets = [];
    
    N = length(handles.foundTargets);
    for n = 1: N
        dAngle = calcDiffAngle( radarAngle,handles.foundTargets(n).angle );
        if dAngle < 2*radarSector && dAngle > 0 
            if ishandle(handles.foundTargets(n).hPlot) 
                if isPersistentDisplay
                    c = [0.6 0.3 0.3];
                    set(handles.foundTargets(n).hPlot,'color',c,'MarkerFaceColor',c);
                    handles.persistentPlotHandle = [handles.persistentPlotHandle handles.foundTargets(n).hPlot];
                else
                    delete (handles.foundTargets(n).hPlot);
                end
                deletedTargets = [deletedTargets n];
            end
        end
    end
    handles.foundTargets(deletedTargets) = [];

    if ~isPersistentDisplay && ~isempty( handles.persistentPlotHandle )
        delete( handles.persistentPlotHandle );
        handles.persistentPlotHandle = [];
    end
    
    if ishandle(handles.FOV)
        delete(handles.FOV);
    end
    x = [0 cos(w*t)]*maxDist;
    y = [0 sin(w*t)]*maxDist;
    handles.FOV = plot(handles.radarDisplay,x,y,'g');

    pause(0.0001);    % To allow the GUI to response...