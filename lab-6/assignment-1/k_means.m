function [prototypes, data, all_prototypes, quantization_error] = k_means(data, k, prototype_initialization)
    if prototype_initialization == "++"
        prototypes = plusplus_prototype_initialization(data, k);
    else
        prototypes = regular_prototype_initialization(data, k);
    end
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
    quantization_error = get_quantization_error(data, prototypes);
end

function prototypes = regular_prototype_initialization(data, k)
    % random order of all indices
    indices = randperm(size(data,1));
    % take first k indices of data as initial prototypes
    prototypes = data(indices(1:k),1:2);
end

function prototypes = plusplus_prototype_initialization(data, k)
    % initialize first prototype as random data point from 'data'
    index = randi(size(data,1));
    prototypes = data(index,:);
    
    
    % initialize distances
    d_x = pdist2(data(:,1:2), prototypes).^2;
    
    min_d_x = zeros(size(data,1), 1);
    
    % set the other prototypes
    for p = 2:k
        % loop over all data points
        for i = 1:size(data,1)
                % find min distance to prototype
%                 min_d_x(i) = min(pdist2(prototypes, data(i,1:2))).^2;
                min_d_x(i) = min(d_x(i,:));
        end
        % random index with probability based on the squared distances to
        % the nearest prototype 

        index = ceil(randpdf(min_d_x, 1:size(min_d_x,1), [1 1]));
        
        new_prototype = data(index,1:2);
        prototypes = [prototypes; new_prototype];
        d_x = [d_x pdist2(data(:,1:2), prototypes(p,:)).^2];
        
    end

end

function qe = get_quantization_error(data, prototypes)
    qe = 0;
    for i = 1:size(data, 1)
        qe = qe + pdist2(prototypes(data(i,3),:), data(i,1:2),'squaredeuclidean');
    end
    qe = qe / 2;
end