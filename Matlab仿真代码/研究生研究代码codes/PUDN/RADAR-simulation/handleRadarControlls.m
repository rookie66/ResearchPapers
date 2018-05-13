function handleRadarControlls(handles,mode)

    str = {
        'PRI';
        'ZSA';
        'updateRate';
        'samplingRate';
        'bufferSize';
        'digitizerNoiseLevel';
        'PW';
        'antenaMode';
        'displayTargets';
        'placeMaountins';
        'RFnoise';
        'bufferAnalyze';
        'stagger';
%         'persistentDisplay';
        };
    
    N = length(str);
    h = zeros(N,1);
    for n =1:N
        h(n) = handles.(str{n});
    end
    
    set(h,'enable',mode);