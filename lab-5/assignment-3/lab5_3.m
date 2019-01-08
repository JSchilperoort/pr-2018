function f = lab5_3()
    folds = 10;
    A = importdata('../assignment-1/data_lvq_A.mat');
    B = importdata('../assignment-1/data_lvq_B.mat');
    
    % data_order contains a random order of the indices of both arrays
    data_order = [randperm(size(A,1)); randperm(size(B,1))];
    
    % initialize data
    data = zeros((size(A,1) + size(B,1)),2);
    i = 1;
    j = 1;
    while i < (size(A,1) + size(B,1))
        % take random point of A and B alternately and add to data
        data(i,:) = A(data_order(1,j),:);
        i = i + 1;
        data(i,:) = B(data_order(2,j),:);
        i = i + 1;
        j = j + 1;
    end
    % convert data into 'folds' equally sized partitions
    [r,c] = size(data);
    partitions = permute(reshape(data',[c,r/folds,folds]),[2,1,3]);
    epochs = 200;
    n = 0.01;
    K = [2, 1];
    training_error = zeros(folds,1);
    classification_error = zeros(folds,1);
    for i = 1:folds
        disp(i)
        [train_data, test_data] = get_train_data(partitions, i, folds);
        P_train = size(train_data, 1);
        P_test = size(test_data, 1);
        
        [error, prototypes, lambda_A, lambda_B] = lvq_relevance(epochs, P_train, train_data, K, n);
        training_error(i) = (error(end) / P_train * 100);
        classification_error(i) = (test_error(prototypes, test_data, K, lambda_A, lambda_B) / P_test * 100);
    end
    testing_error = mean(classification_error);
    fig = figure();
    bar(training_error);
    hold on
    plot(xlim,[testing_error testing_error], 'r');
    xlabel("Fold");
    ylabel("Training error in %");
    title("Training error for each of the 10 folds. Red line represents test error");
    saveas(fig,"lab5_3.png");

end

function error = test_error(prototypes, test_data, K, lambda_A, lambda_B)
    prototypes_A = prototypes(1:K(1),:);
    prototypes_B = prototypes(K(1)+1:end,:);
    error = 0;
    for i = 1:size(test_data, 1)

        dist_to_A = min(lambda_A * pdist2(test_data(i,:), prototypes_A));
        dist_to_B = min(lambda_B * pdist2(test_data(i,:), prototypes_B));
        if dist_to_A < dist_to_B
            if (rem(i, 2) == 0)
                error = error + 1;
            end
        else
            if (rem(i, 2) == 1)
                error = error + 1;
            end
        end
    end
end


function [train_data, test_data] = get_train_data(partitions, i, folds)
    test_data = partitions(:, :, i);
    train_data = zeros(1,2);
    for j = 1:folds
        if j ~= i
            train_data = [train_data; partitions(:, :, j)];
        end
    end
    train_data = train_data(2:end,:);
end