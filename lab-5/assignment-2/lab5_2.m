function f = lab5_2()
    k = 10;
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
    % convert data into K equally sized partitions
    [r,c] = size(data);
    partitions = permute(reshape(data',[c,r/k,k]),[2,1,3]);
    
    Ka = 2;
    Kb = 1;
    P = size(data, 1);
    epochs = 200;
    n = 0.01;
    [error, prototypes] = lvq1(epochs, P, data, [Ka Kb], n);
    disp(error(end));

end
