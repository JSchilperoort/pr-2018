function f = lab4_3()
    I = rgb2gray(imread('chess.jpg'));
    BW = edge(I,'canny');
    [H,T,R] = hough(BW);	

    imshow(imadjust(mat2gray(H)),[], 'XData',T,'YData',R,'InitialMagnification','fit');
    xlabel('\theta	(degrees)');
    ylabel('\rho')
    axis on
    axis normal	
	hold on
    colormap(hot)
    
    P = houghpeaks(H, 15, 'threshold', ceil(0.3*max(H(:))));
    x = T(P(:,2));
    y = R(P(:,1));
    plot(x, y, 'Marker', 's', 'LineWidth', 2, 'MarkerSize', 7, 'LineStyle', 'none');
    
    
    
    
    
    fig = figure(2);
    
    lines = houghlines(BW, T, R, P, 'FillGap', 50, 'MinLength', 1);
    imshow(I);
    hold on;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth', 1, 'Color', 'green');
        
        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    end
    
    
    
end
