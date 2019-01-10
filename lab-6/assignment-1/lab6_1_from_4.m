function f = lab6_1_from_4()
    f = waitbar(0,'1','Name','Calculating clusters...',...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(f,'canceling',0);
    
    
    data = importdata('../data/kmeans1.mat');
    
    kmax = 5;
    ks = 1:kmax;
    
    j_k = zeros(kmax,1);
    r_k = zeros(kmax,1);
    

    for i = 1:size(ks,2)
        % Check for clicked Cancel button
        if getappdata(f,'canceling')
            break
        end
        [prototypes, clusters, all_prototypes, quantization_error] = k_means(data, ks(i));
        j_k(i) = quantization_error;
         % Update waitbar and message
        waitbar(i/size(ks,2),f,sprintf('Running...'))
    end
    for i = 1:size(ks,2)
        r_k(i) = j_k(1)*ks(i)^(-2/2);
    end
    d_k = r_k./j_k;
    
    [val, k_opt] = max(d_k);
    
    fig1 = figure(1);
    plot(1:size(d_k), d_k);
    hold on
    scatter(k_opt, val);
    legend("D(k)", "k_{opt}");
    ylabel("D(k)")
    xlabel("k")
    saveas(fig1,"lab6_4.png");
    
    fig2 = figure(2);
    plot(1:size(j_k), j_k);
    hold on
    plot(1:size(r_k), r_k);
    x=[k_opt k_opt];
    y=[0 max(max(j_k), max(r_k))];
    plot(x,y,'k')
    legend("J(k)", "R(k)", "k_{opt}");
    ylabel("Quantization error")
    xlabel("k")
    

    
    delete(f)
end