function f = lab4_3()
    I = rgb2gray(imread('chess.jpg'));
    BW = edge(I,'canny');
    [H,theta,rho] = hough(BW);	
    P = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:)))); 
    x = T(P(:,2));
    y = R(P(:,1));
    plot(x,y,'s','color','white');

end