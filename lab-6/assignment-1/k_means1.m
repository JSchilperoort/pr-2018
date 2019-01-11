function [prototypes, data, all_prototypes] = k_means1(data, k)
    % initialize prototypes
    prototypes = regular_prototype_initialization(data, k);
    
    % initialize set of all prototypes as initial prototypes
    all_prototypes = prototypes;

    % add column to data to store class
    data = [data zeros(size(data,1),1)];
    
    % maximum number of iterations the algorithm is allowed to take
    max_epoch = 50;
    
    has_changed = 1;
    time_elapsed = 0;
    while has_changed
        time_elapsed = time_elapsed + 1;
        if time_elapsed > max_epoch
            break
        end
        has_changed = 0;
        
        % assign all data points to their nearest prototype
        for i = 1:size(data,1)
            % find nearest prototype
            [val, nearest_prototype] = min(pdist2(prototypes, data(i,1:2)));
            data(i,3) = nearest_prototype;
        end
        % update prototypes as the mean of their clusters
        for j = 1:k
            new_prototype = mean(data(data(:,3)==j,1:2));
            % check whether the prototype changes, if so set
            % has_changed
            if prototypes(j,:) ~= new_prototype
                prototypes(j,:) = new_prototype;
                % append prototypes to set of all prototypes
                all_prototypes = cat(3,all_prototypes,prototypes);
                has_changed = 1;
            end
        end
    end 
end

function prototypes = regular_prototype_initialization(data, k)
    % random order of all indices
    indices = randperm(size(data,1));
    % take first k indices of data as initial prototypes
    prototypes = data(indices(1:k),1:2);
end