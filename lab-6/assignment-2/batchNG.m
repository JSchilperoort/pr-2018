function [return_prototypes, return_data, quantization_error] = batchNG(data, k, storage_epochs)
    % add column to data to store class
    data = [data zeros(size(data,1),1)];    
    
    % import prototypes
    prototypes = importdata('../data/clusterCentroids.mat');
    
    % set learning rate
    n = 0.05;
    
    % initialize sigma
    sigma = 1;
    
    % initialize return data
    return_prototypes = zeros(size(prototypes,1),size(prototypes,2),size(storage_epochs,2));
    return_data = zeros(size(data,1),size(data,2),size(storage_epochs,2));
    quantization_error = zeros(size(storage_epochs,2));
    
    % initialize time elapsed 
    time_elapsed = 0;
    
    % initialize storage index
    storage_index = 1;
    while time_elapsed <= storage_epochs(end) 
        % store data
        if any(storage_epochs == time_elapsed)
            % assign all data points to their nearest prototype
            for i = 1:size(data,1)
                % find nearest prototype
                [val, nearest_prototype] = min(pdist2(prototypes, data(i,1:2)));
                data(i,3) = nearest_prototype;
            end
            % store data
            return_prototypes(:,:,storage_index) = prototypes;
            return_data(:,:,storage_index) = data;
            quantization_error(storage_index) = get_quantization_error(data, prototypes);
            
            % update storage index
            storage_index = storage_index + 1;
        end
        
        % loop over data in random order
        for j = randperm(size(data,1))
            % take data sample
            x = data(j,1:2);
            
            % determine squared distance from every prototype to data sample
            distances = pdist2(prototypes, x, 'squaredEuclidean');

            % rank prototypes based on distances
            [distances, sorted_indices] = sort(distances);
            prototypes = prototypes(sorted_indices,:);

            % update prototypes
            for i = 1:size(prototypes, 1)
                rank = i - 1;
                prototypes(i,:) = prototypes(i,:) + n * exp(-rank/(sigma^2))...
                    * (x - prototypes(i,:));
            end
        end
        
        % decrease sigma
        sigma = sigma - 1/storage_epochs(end);
        if sigma <= 0
            sigma = 0.0001;
        end
        time_elapsed = time_elapsed + 1;
    end
    
end

function qe = get_quantization_error(data, prototypes)
    qe = 0;
    for i = 1:size(data, 1)
        qe = qe + pdist2(prototypes(data(i,3),:), data(i,1:2),'squaredeuclidean');
    end
    qe = qe / 2;
end