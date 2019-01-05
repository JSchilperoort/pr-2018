function f = lab5_1()
    % Load in the data and set the number of examples P and vector dimension N
    d1 = load('data_lvq_A.mat');
    d2 = load('data_lvq_B.mat');
    data_A = d1.matA;
    data_B = d2.matB;
    data = cat(1,data_A,data_B);
    
    % plot the classes in a scatter plot blue for class A, red for class B
    fig1 = figure(1);
    scatter(data_A(:,1), data_A(:,2), 'MarkerEdgeColor',[0 0 0.7]);
    hold on
    scatter(data_B(:,1), data_B(:,2), 'MarkerEdgeColor',[0.7 0 0]);
    legend('A','B');
    title("Scatterplot of the classes")
    saveas(fig1,"lab5_1.png")

    % Get amount of examples P and dimension N
    [P, N] = size(data);

    % Set parameters, K is number of prototypes per class ([A, B]), 
    % N the learning rate and epochs the number of epochs
    K = [2, 1];
    n = 0.01;
    epochs = 200;

    [Error, prototypes] = lvq1(epochs, P, data, K, n);
    
    hold on
    prototypes_A = prototypes(1:K(1),:);
    prototypes_B = prototypes(K(1)+1:end,:);
    scatter(prototypes_A(:,1), prototypes_A(:,2), 'MarkerFaceColor',[0 0 0.7]);
    hold on
    scatter(prototypes_B(:,1), prototypes_B(:,2), 'MarkerFaceColor',[0.7 0 0]);
    legend('A','B','prototype A','prototype B');
    
    hold off
    fig2 = figure(2);

    %Plot the error over time
    plot(1:epochs, Error ./ P .* 100);
    ylim([0 100]);
    xlabel("Time");
    ylabel("Misclassificaion error in %");
    title("Error over time");
    saveas(fig2,"lab5_4.png");
    
    hold off
    fig3 = figure(3);
    fig4 = figure(4);
    Ks = [1 1; 1 2; 2 1; 2 2];
    for i = 1:4
        figure(3);
        hold on
        K = Ks(i, :);
        [Error, prototypes] = lvq1(epochs, P, data, K, n);
        %Plot the errors over time
        plot(1:epochs, Error ./ P .* 100);
        ylim([0 100]);
        
        
        figure(4);
        subplot(2,2,i);
        hold on
        prototypes_A = prototypes(1:K(1),:);
        prototypes_B = prototypes(K(1)+1:end,:);
        [data_A, data_B] = assign_to_prototype(data, prototypes_A, prototypes_B);
        scatter(data_A(:,1), data_A(:,2), 'MarkerEdgeColor',[0 0 0.7]);
        scatter(data_B(:,1), data_B(:,2), 'MarkerEdgeColor',[0.7 0 0]);
        scatter(prototypes_A(:,1), prototypes_A(:,2), 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[0 0 0.7], 'LineWidth',3);
        scatter(prototypes_B(:,1), prototypes_B(:,2), 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor',[0.7 0 0], 'LineWidth',3);
        legend("A", "B");
        title(strcat("A = ", num2str(K(1)), ", B = ", num2str(K(2))));
    end
    
    figure(3);
    legend('A=1, B=1','A=1, B=2','A=2, B=1','A=2, B=2');
    xlabel("Time");
    ylabel("Misclassificaion error in %");
    title("Error over time");
    saveas(fig3,"lab5_5.png");
    
    figure(4);
    sgtitle("Final distribution of classes assigned to their prototypes");
    saveas(fig4,"lab5_6.png");
    
    
end

function [data_A, data_B] = assign_to_prototype(data, prototypes_A, prototypes_B)
    data_A = [0 0];
    data_B = [0 0];
    for i = 1:size(data, 1)
        dist_to_A = min(pdist2(data(i,:), prototypes_A));
        dist_to_B = min(pdist2(data(i,:), prototypes_B));
        if dist_to_A < dist_to_B
            data_A = [data_A; data(i,:)];
        else
            data_B = [data_B; data(i,:)];
        end
    end
    data_A = data_A(2:end,:);
    data_B = data_B(2:end,:);

end

function [Error, prototypes] = lvq1(epochs, P, data, K, n)
% Choose K random datapoints as prototypes
    init_perm_class1 = randperm(P/2, K(1)); 
    init_perm_class2 = randperm(P/2, K(2)) + P/2;

    % Initialize prototypes first half is the first class second half the other
    prototypes = [data(init_perm_class1(1:end),:); data(init_perm_class2(1:end),:)];

    % Initialize the quantization error vector
    Error = zeros(epochs, 1);
    
    % Iterate over all the epochs
    for t = 1:epochs
        % Shuffle the data using a permutation
        perm = randperm(P);
        % Iterate over all the data points
        for i = 1:P
            % Get the class for the example
            example_class = 1;        
            if (perm(i) > P/2)
                example_class = 2;
            end

            % Get the example vector
            example = data(perm(i), :);
            % Get the idx of the winner prototype
            [val, winner_idx] = min(pdist2(prototypes, example));
            % Update the winner

            % Get the class for the prototype
            prototype_class = 1;
            if (winner_idx > K(1))
                prototype_class = 2;
            end

            % Calculate psi
            psi = 1;
            if (prototype_class ~= example_class) 
                psi = -1;
                % Misclassified if it reaches this so add one to error
                Error(t) = Error(t) + 1;
            end
            % Update the winner
            prototypes(winner_idx, :) = prototypes(winner_idx,:) + n * psi *(example - prototypes(winner_idx,:));
        end   
    end
end