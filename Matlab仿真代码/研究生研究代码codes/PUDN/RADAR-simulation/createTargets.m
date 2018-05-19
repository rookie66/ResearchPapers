function handles = createTargets(hObject,handles)
% handles = createTargets(hObject,handles);
% This function creates initial targets (mountains and planes)
% The function randomize the position and velocity of each target
    
    numMountains = get(handles.nMountains,'value')-1;
    for n =1: numMountains
        XY = ( rand(1,2)*1.8 - 0.9*ones(1,2) )*1e5;
        handles = placeClutter(handles,XY);
    end

    N = get(handles.nTargets,'value')-1;
    if N
        RCSc = cell(N,1);
        vc = cell(N,1);
        XYc = cell(N,1);
        ac = cell(N,1);
        maneuverability = cell(N,1);

        RCS = get(handles.RCS,'value');
        temp = rand(1,N);
        targetsRCS = (1+temp) * RCS;
        targetsCordinates = ( rand(N,2)*1.8 - 0.9*ones(N,2) )*1e5;  %Targets X & Y initial cordinates
        targetsVelocity = randn(N,2)*1e2;   % Targets initial velocity m/s
        for n=1:N
            RCSc{n} = targetsRCS(n);
            vc{n} = targetsVelocity(n,:);
            XYc{n} = targetsCordinates(n,:);
            ac{n} = [0 0];
            maneuverability{n} = 1 + temp(n)*20;  % small planes will perform more maneuvers
        end
        handles.Targets = struct('RCS',RCSc, 'XY',XYc, 'v', vc, 'a',ac, 'maneuverability',maneuverability);
        handles.targetManeuverTime = ones(N,1)*handles.currentTime;
    else
        handles.Targets = [];
    end
    handles.plotedTargets = [];
    
    
