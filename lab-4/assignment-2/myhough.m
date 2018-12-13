function accumulator_array = myhough(edge_map)

    c = imread('Cameraman.tif');
    edge_map = edge(c, 'canny');
    theta = -90:90;
    
    imshow(edge_map);
    [y,x] = find(edge_map);

    rho = cell(1,length(x));
    
    for i = 1: length(x)
        rho{i} = x(i).*cos(theta) + y(i).*sin(theta);
    end

end