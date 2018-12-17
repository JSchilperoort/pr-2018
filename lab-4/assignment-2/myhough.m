function [H, theta, rho_range] = myhough(edge_map)
       
    % load image and create edge map
    [y,x] = find(edge_map);
    
    % values for theta:
    theta_step = 0.1;
    theta = -90:theta_step:90;
    
    % initialize cell aray for rho. Each cell in this array is a function
    % rho(theta)
    rho = cell(1,length(x));
    
    % used for finding minimal end maximum vlaues for rho
    min_rho = 99999;
    max_rho = -99999;
    
    for i = 1:length(x)
        % for each value of theta, the corresponding rho is computed
        this_rho = floor(x(i).*cosd(theta) + y(i).*sind(theta));
        rho{i} = this_rho;
        
        % update min/max rho
        if min(this_rho) < min_rho
            min_rho = min(this_rho);
        elseif max(this_rho) > max_rho
            max_rho = max(this_rho);
        end
    end
    % set min/max rho and corresponding range
    min_rho = floor(min_rho - 0.1*abs(min_rho));
    max_rho = floor(max_rho + 0.1*abs(max_rho));
    rho_range = min_rho:max_rho;
    
    % initialize H(rho, theta) as zeros
    H = zeros(length(rho_range), length(theta));
    
    % loop over all items in the rhow cell array
    for i = 1:length(x)
        row = rho{i};
        for i = 1:length(theta)
            % in the H matrix, update cordinate(rho, theta) with +1
            t = theta(i);
            H(row(i)+abs(min_rho)+1, i) = H(row(i)+abs(min_rho)+1, i) + 1;
        end
    end
end