function changeGuiColors( handles )
    
obj = fieldnames(handles);
for n = 1 : length(obj)
   h = handles.(obj{n});
   if ~isempty(h)
    flipColor( h );
   end
end

function flipColor( h )
    if isprop( h,'children')
        children = get( h,'children' );
        for n =1: length(children)
            flipColor( children(n) );
        end
    end
    for n=1:numel(h)
        if isprop( h(n), 'color' )
            c = get( h(n),'color' );
            c = 1 - c;
            set( h(n),'color',c );
        end
    end