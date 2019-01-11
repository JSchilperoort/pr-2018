function f = lab6_1_from_6()
    % initialize progress bar
    f = waitbar(0,'1','Name','Calculating clusters...',...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(f,'canceling',0);
    
    % import the data
    data = importdata('../data/checkerboard.mat');
    
    % total number of series.
    series = 10;
    
    % number of times the clustering is performed per value of k
    repetitions = 20;
    
    % initialize k
    k = 100;
    
    % possible initializations
    initializations = ["regular"; "++"];
    
    % initialize min_qe
    min_qe_series = zeros(size(initializations,1),series);
    
    % total number of iterations, required for the progress bsar
    running_size = series * size(initializations,1);
    tic
    for s = 1:series
        % initialize min_qe
        min_qe = zeros(size(initializations,1),1);

        % loop over both initializations
        for i = 1:size(initializations,1)
            initialization = initializations(i);
            % repeat 'repetitions' times over k
            qe = 0;
            for reps = 1:repetitions
                % check for clicked cancel button
                if getappdata(f,'canceling')
                    break
                end
                % perform k_means++ clustering
                [prototypes, clusters, all_prototypes, quantization_error] = k_means(data,k,initialization);

                % store quantization error
                qe = [qe quantization_error];
  
            end
            % update progress bar
            ETA = ((1 - ((s-1) * size(initializations,1) + i)/running_size)...
                / (((s-1) * size(initializations,1) + i)/running_size)) * toc;
            waitbar(((s-1) * size(initializations,1) + i)/running_size,f,sprintf('ETA = %0.1f minutes', ETA/60))

            % take minimum quantization error over repetitions
            min_qe(i) = min(qe(2:end));
        end
        fprintf('Minimal quantization error for regular initialization = %f\n', min_qe(1));
        fprintf('Minimal quantization error for ++ initialization = %f\n', min_qe(2));
        min_qe_series(:,s) = min_qe;
    end
    save('lab6_1_9_12_final','min_qe_series')

    % delete figure used for progress bar
    delete(f)
end