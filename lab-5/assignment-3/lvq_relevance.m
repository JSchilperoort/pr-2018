function [Error, prototypes, lambda_A, lambda_B, lambdas] = lvq_relevance(epochs, P, data, K, n)
% Choose K random datapoints as prototypes
    init_perm_class1 = randperm(P/2, K(1)); 
    init_perm_class2 = randperm(P/2, K(2)) + P/2;

    % Initialize prototypes first half is the first class second half the other
    prototypes = [data(init_perm_class1(1:end),:); data(init_perm_class2(1:end),:)];

    % Initialize the quantization error vector
    Error = zeros(epochs, 1);
    
    % Initialize relevances
    lambda_A = 0.5;
    lambda_B = 0.5;
    n_lambda = 0.0001;
    lambdas = [0 0];
    
    % Iterate over all the epochs
    for t = 1:epochs
        % Shuffle the data using a permutation
        perm = randperm(P);
        % Iterate over all the data points
        for i = 1:P
            % Get the class for the example
            % NOTE: different order of data than in assignment 1
            example_class = 1;   
            if (rem(perm(i), 2) == 0)
                example_class = 2;
            end
%             if (perm(i) > P/2)
%                 example_class = 2;
%             end

            % Get the example vector
            example = data(perm(i), :);
            % Get the idx of the winner prototype
            distancesA = lambda_A * pdist2(prototypes(1:K(1),:), example);
            distancesB = lambda_B * pdist2(prototypes(K(1)+1:end,:), example);
            distances = [distancesA; distancesB];
            [val, winner_idx] = min(distances);
            winner_dist = pdist2(prototypes(winner_idx, :), example);
           
           
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
                if (prototype_class == 1)
                    %   Prototype A, update lambda
                    lambda_A = lambda_A + (n_lambda * winner_dist);
                else
                    %   prototype B, update lambda
                    lambda_B = lambda_B + (n_lambda * winner_dist);
                end
            else
                % classification = correct
                if (prototype_class == 1)
                    %   Winner A, update lambda
                    lambda_A = max(lambda_A - (n_lambda * winner_dist), 0);
                else
                    %   Winner B, update lambda
                    lambda_B = max(lambda_B - (n_lambda * winner_dist), 0);
                end
            end
            
            %normalize lambdas
            lambda_sum = lambda_A + lambda_B;
            lambda_A = lambda_A / lambda_sum;
            lambda_B = lambda_B / lambda_sum;
            lambdas = [lambdas; lambda_A lambda_B];
			
            % Update the winner
            prototypes(winner_idx, :) = prototypes(winner_idx,:) + n * psi *(example - prototypes(winner_idx,:));
        end
        if t > 25
            if sum(Error(t) > Error(t-25:t-1)) == 25
                Error = Error(1:t);
                break
            end
        end
    end
    fig = figure(3);
    hold on
    plot(1:t, Error(1:t))
    lambdas = lambdas(2:end,:);
%     hold on
%     plot(1:size(lambdas, 1), lambdas(:,2))
end