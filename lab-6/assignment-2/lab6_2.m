function f = lab6_2()
    data = importdata('../data/checkerboard.mat');

    k = 100;
   
    % Neural gas
    % maximum number of iterations the algorithm is allowed to take
    storage_epochs = [20 100 200 500];
    
    fig1 = figure(1);
    hold on
    sgtitle("Final clusters from neural gas");
    [prototypes, clusters, qe] = batchNG(data, k, storage_epochs);
    for i = 1:size(storage_epochs,2)
        subplot(2, 2, i);
        title(strcat("Clusters after ", num2str(storage_epochs(i)), " epochs,  qe = ", num2str(qe(i))));
        hold on
        for j = 1:k
            cluster = clusters(clusters(:,3,i)==j,1:2);
            scatter(cluster(:,1), cluster(:,2));
        end
        scatter(prototypes(:,1,i), prototypes(:,2,i),...
            'MarkerEdgeColor',[1 1 1],...
            'MarkerFaceColor',[0 0 0])
        voronoi(prototypes(:,1,i),prototypes(:,2,i))
    end

    % K-means
    fig2 = figure(2);
    hold on
    [prototypes, clusters, all_prototypes, qe] = k_means(data, k, 'from_data');
    title(strcat("Final clusters from k-means, qe =  ", num2str(qe)));
    for j = 1:k
        cluster = clusters(clusters(:,3)==j,1:2);
        scatter(cluster(:,1), cluster(:,2));
    end
    scatter(prototypes(:,1), prototypes(:,2),...
        'MarkerEdgeColor',[1 1 1],...
        'MarkerFaceColor',[0 0 0])
    voronoi(prototypes(:,1),prototypes(:,2))
        
    saveas(fig1,"lab6_2_2.png")
    saveas(fig2,"lab6_2_3.png")
    
    
    
end