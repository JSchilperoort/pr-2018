function f = lab6_1()
    data = importdata('../data/kmeans1.mat');
    
    ks = [2 4 8];
    
    for i = 1:size(ks,2)
        fig = figure(1);
        hold on
        [prototypes, clusters, all_prototypes] = k_means(data, ks(i));
        subplot(2,2,i);
        hold on
        for j = 1:ks(i)
            cluster = clusters(clusters(:,3)==j,1:2);
            scatter(cluster(:,1), cluster(:,2));
        end
        scatter(prototypes(:,1), prototypes(:,2),...
            'MarkerEdgeColor',[1 1 1],...
            'MarkerFaceColor',[0 0 0])
        
        fig2 = figure(2);
        hold on
        subplot(2,2,i);
        hold on
        for j = 1:ks(i)
            for l = 2:size(all_prototypes,3)
                color = [0.1 0.1 0.1];
                plot_arrow(all_prototypes(j,1,l-1), all_prototypes(j,2,l-1),...
                    all_prototypes(j,1,l), all_prototypes(j,2,l),...
                    'facecolor',color,'edgecolor',color,...
                    'color',color,'linewidth',1);
            end
        end
        
    end
    
    
end