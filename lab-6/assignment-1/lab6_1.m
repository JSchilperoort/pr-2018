function f = lab6_1()
    data = importdata('../data/kmeans1.mat');
    
    ks = [2 4 8];
    
    c = get(gca,'colororder');
    
    for i = 1:size(ks,2)
        fig1 = figure(1);
        hold on
        [prototypes, clusters, all_prototypes] = k_means1(data, ks(i));
        subplot(2,2,i);
        title(strcat('k=', num2str(ks(i))));
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
        title(strcat('k=', num2str(ks(i))));
        xlim([-4.5, 6]);
        ylim([-4, 4]);
        hold on
        for j = 1:ks(i)
            for l = 2:size(all_prototypes,3)
                color_index = rem(j,size(c,1)+1);
                if color_index == 0
                    color_index = 1;
                end
                color = c(color_index,:);
                plot_arrow(all_prototypes(j,1,l-1), all_prototypes(j,2,l-1),...
                    all_prototypes(j,1,l), all_prototypes(j,2,l),...
                    'facecolor',color,'edgecolor',color,...
                    'color',color,'linewidth',1);
            end
            
        end
        
        
    end
    saveas(fig1,"lab6_1_2.png")
    saveas(fig2,"lab6_1_3.png")
    
    
end