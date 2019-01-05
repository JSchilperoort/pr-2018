% Load in the data and set the number of examples P and vector dimension N
d1 = load('data_lvq_A(1).mat');
d2 = load('data_lvq_B(1).mat');
data_A = d1.matA;
data_B = d2.matB;
data = cat(1,data_A,data_B);
class1_data = d1.matA;
class2_data = d2.matB;

% Get amount of examples P and dimension N
[P, N] = size(data);

% Set parameters, K is number of prototypes, N the learning rate and
% epochs the number of epochs
K = 2;
N = 0.01;
epochs = 200;

% Choose K random datapoints as prototypes
init_perm_class1 = randperm(P/2, K); 
init_perm_class2 = randperm(P/2, K) + P/2;

% Initialize prototypes first half is the first class second half the other
prototypes = [data(init_perm_class1(1:end),:); data(init_perm_class2(1:end),:)];

% Initialize the quantization error vector
Error = zeros(epochs, 1);

%{
% Create scatter graph of data points
hold on
xlabel("x")
ylabel("y")
title("Learning vector quantization on the data")
scatter(class1_data(:, 1), class1_data(:, 2), 20, 'k', 'filled');
scatter(class2_data(:, 1), class2_data(:, 2), 20, 'b')
%}

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
        if (winner_idx > K)
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
        prototypes(winner_idx, :) = prototypes(winner_idx,:) + N * psi *(example - prototypes(winner_idx,:));
    end   
end

hold off

%Plot the error over time

plot(1:epochs, Error ./ P .* 100);
ylim([0 100]);
xlabel("Time")
ylabel("Misclassificaion error in %")
title("Error over time")

