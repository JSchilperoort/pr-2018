function [prototypes, data, all_prototypes, quantization_error] = k_means(data, k)
    
    % random order of all indices
    indices = randperm(size(data,1));
    % take first k indices of data as initial prototypes
    prototypes = data(indices(1:k),:);
    all_prototypes = zeros(k, 2, 999999);
    p_i = 1;
    all_prototypes(:,:,p_i) = prototypes;
    % add column to data to store class
    data = [data zeros(size(data,1),1)];
    
    has_changed = 1;
    while has_changed
        has_changed = 0;
        
        % assign all data points to their nearest prototype
        for i = 1:size(data,1)
            % find nearest prototype
            [val, nearest_prototype] = min(pdist2(prototypes, data(i,1:2)));
            data(i,3) = nearest_prototype;
        end
        
        % update prototypes as the mean of their clusters
        for i = 1:size(prototypes,1)
            for j = 1:k
                new_prototype = mean(data(data(:,3)==j,1:2));
                % check whether the prototype changes, if so set
                % has_changed
                if prototypes(j,:) ~= new_prototype
                    prototypes(j,:) = new_prototype;
                    p_i = p_i + 1;
                    all_prototypes(:,:,p_i) = prototypes;
                    has_changed = 1;
                end
            end
        end  
    end 
    quantization_error = get_quantization_error(data, prototypes);
    all_prototypes = all_prototypes(:,:,1:p_i);
end

function qe = get_quantization_error(data, prototypes)
    qe = 0;
    for i = 1:size(data, 1)
        qe = qe + pdist2(prototypes(data(i,3),:), data(i,1:2),'squaredeuclidean');
    end
    qe = qe / 2;
end