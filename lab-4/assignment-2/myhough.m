function [H, theta, rho] = myhough(edge_map)
       
    % load image and create edge map
    c = imread('Cameraman.tif');
    edge_map = edge(c, 'canny');
    imshow(edge_map);
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
    
    % plot of own implementation
    subplot(1,2,1);
    imshow(imadjust(mat2gray(H)),[], 'XData',theta,'YData',rho_range,'InitialMagnification','fit');
    xlabel('\theta	(degrees)');
    ylabel('\rho')
    axis on
    axis normal	
    colormap(hot)
    title('myhough.m')
    
    % plot of built-in function
    subplot(1,2,2);
    [H2,theta2,rho2] = hough(edge_map);	
    imshow(imadjust(mat2gray(H2)),[], 'XData',theta2,'YData',rho2,'InitialMagnification','fit');
    xlabel('\theta	(degrees)');
    ylabel('\rho')
    axis on
    axis normal	
    colormap(hot)
    title('Matlab built-in function')
end