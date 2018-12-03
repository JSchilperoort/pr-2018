function db = lab_2_5()
    [X,Y] = meshgrid(-10:.01:20);
    db = -0.25 * X.^2 + 0.375 * Y.^2 + 2.0 * X + 0.25 * Y + -6.471573590279974;
   

    mesh(X, Y, db);
    xlabel("X");
    ylabel("Y");
    zlabel("DB");

end