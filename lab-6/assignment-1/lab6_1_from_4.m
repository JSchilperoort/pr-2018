function f = lab6_1_from_4()
    % initialize progress bar
    f = waitbar(0,'1','Name','Calculating clusters...',...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(f,'canceling',0);
    
    % import the data
    data = importdata('../data/kmeans1.mat');
    
    % number of times the clustering is performed per value of k
    repetitions = 5;
    
    % set the number of k's that have to be tested
    kmax = 25;
    ks = 1:kmax;
    
    % initialize J(k) and R(k)
    j_k = zeros(kmax,1);
    r_k = zeros(kmax,1);
    
    % total number of iterations, required for the progress bar
    running_size = repetitions * size(ks,2);
    
    % iterate in random order to avoid bias in progress bar
    random_order = randperm(size(ks,2));
    
    % loop over all values of k
    for index = 1:kmax
        i = random_order(index);
        % repeat 'repetitions' times over every value of k
        for reps = 1:repetitions
            % check for clicked cancel button
            if getappdata(f,'canceling')
                break
            end
            % perform clustering
            [prototypes, clusters, all_prototypes, quantization_error] = k_means(data, ks(i), 'regular');
            
            % store quantization error
            j_k(i) = j_k(i) + quantization_error;
            
             % update progress bar
            waitbar(((index-1) * repetitions + reps)/running_size,f,sprintf('Running...'))
        end
        % average quantization error over repetitions
        j_k(i) = j_k(i) / repetitions;
    end
    
    % compute R(k)
    for i = 1:size(ks,2)
        r_k(i) = j_k(1)*ks(i)^(-2/2);
    end
    % compute D(k)
    d_k = r_k./j_k;
    
    % compute k_opt
    [val, k_opt] = max(d_k);
    
    % plot figure for assignment 1, question 4
    fig1 = figure(1);
    plot(1:size(d_k), d_k);
    hold on
    scatter(k_opt, val);
    x = [k_opt k_opt];
    y = ylim;
    plot(x,y,'k--')
    legend("D(k)", "k_{opt}");
    ylabel("D(k)")
    xlabel("k")
    title("Plot showing the curve of D(k)")
    saveas(fig1,"lab6_1_4.png");
    
    % plot figure for assignment 1, question 5
    fig2 = figure(2);
    plot(1:size(j_k), j_k);
    hold on
    plot(1:size(r_k), r_k);
    x = [k_opt k_opt];
    y = ylim;
    plot(x,y,'k--')
    legend("J(k)", "R(k)", "k_{opt}");
    ylabel("Quantization error")
    xlabel("k")
    title("Plot showing the curves of J(k) and R(k)")
    saveas(fig2,"lab6_1_5.png");
    

    % delete figure used for progress bar
    delete(f)
end