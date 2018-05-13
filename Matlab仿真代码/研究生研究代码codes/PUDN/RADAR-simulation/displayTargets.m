function displayTargets(handles,mode)

placeLegend = 0;
switch mode
    case 'in diffrent figure'
        if ishandle(handles.targetsFigure)
            if strcmp(get(handles.targetsFigure,'tag'),'targets')
                figure(handles.targetsFigure);
            else
                handles.targetsFigure = figure('tag','targets');
            end
        else
            handles.targetsFigure = figure('tag','targets');
        end
        hAxes = gca;
        placeLegend = 1;
    case 'in radar display'
        hAxes = handles.miniDisplay;
end

hold (hAxes,'off');
h = [-1 ; -1];
for n=1:length(handles.Targets)
    v = handles.Targets(n).v;
    cor = handles.Targets(n).XY;
    RCS = handles.Targets(n).RCS;
    h(1) = quiver(hAxes,cor(1),cor(2),v(1),v(2),100,'color','b','linewidth',2,'marker','X','MarkerSize',5*RCS);
    hold(hAxes,'on');
end
for n=1:length(handles.mountains)
    cor = handles.mountains(n).XY;
    h(2) = plot(hAxes,cor(1),cor(2),'^k','MarkerFaceColor','k');
    hold(hAxes,'on');
end

plot(hAxes,0,0,'+g','MarkerSize',20,'LineWidth',5);
set(hAxes,'xlim',[-100 100]*1e3, 'ylim', [-100 100]*1e3);
axis (hAxes,'equal');
grid on;
set(hAxes,'layer','bottom');

ind = find(ishandle(h));
legendStr = {'Planes' ; 'Mountains'};
if placeLegend
    plotDistLines(hAxes,8);
    h=legend( h(ind), legendStr{ind} ,'FontSize',7,'boxoff' );
    f = findobj(h,'type','text');
    set(f,'FontSize',7);
else
    plotDistLines(hAxes,6);    
    % removing the ticks...
    set(hAxes,'xtick',[],'ytick',[]);
end
