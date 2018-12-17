function f = lab4_2()
    c = imread('Cameraman.tif');
    edge_map = edge(c, 'canny');
    
    % plot of own implementation
    subplot(1,2,1);
    [H,theta,rho] = myhough(edge_map);	
    imshow(imadjust(mat2gray(H)),[], 'XData',theta,'YData',rho,'InitialMagnification','fit');
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