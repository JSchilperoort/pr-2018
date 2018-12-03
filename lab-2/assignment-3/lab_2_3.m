function F = lab_2_3()
    x = -10:0.1:10;
    y = -10:0.1:10;
    [X,Y] = meshgrid(-10:0.1:10);
    mu = [3 4];
    sigma = [1, 0; 0, 2];
    
    F = mvnpdf([X(:) Y(:)],mu,sigma);
    F = reshape(F,length(x),length(y));
    mesh(X, Y, F);
    
    xlabel("X");
    ylabel("Y");
    zlabel("Z");
    
    point = [10 10; 0 0; 3 4; 6 8];
    
    n = 10000;
    d = 0;
    for i = 1:n
        d = d + mahal(point, mvnrnd(mu, sigma, 100000));
    end
    d = d / n;
    
    for i = 1:size(d, 1)
        fprintf("Distance from %s to mean = %4.5f\n", mat2str(point(i, :)), d(i));
    end
    

end