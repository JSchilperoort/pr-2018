function f = lab_2_1()

    v = [4, 5, 6; 6, 3, 9; 8, 7, 3; 7, 4, 8; 4, 6, 5];
    means = zeros(1, size(v, 2));
    for i = 1:size(v, 2)
        means(i) = mean(get_feature(i));
        fprintf("Mean of feature vector %4.0f = %4.2f\n", i, means(i));
    end
    b_cov = biased_cov();
    fprintf("\nUnbiased covariance matrix:\n");
    disp(b_cov);
    
    X = [5, 5, 6];
    fprintf("Probability density in [5 5 6] = %4.6f\n", mvnpdf(X, means, b_cov));
    X = [3, 5, 7];
    fprintf("Probability density in [3 5 7] = %4.6f\n", mvnpdf(X, means, b_cov));
    X = [4, 6.5, 1];
    fprintf("Probability density in [4 6.5 1] = %4.6f\n", mvnpdf(X, means, b_cov));
    
    function f = get_feature(index)
    f = v(:, index);

    end

    function uc = biased_cov()
        % uc(row, column)
        uc = zeros(size(v, 2), size(v, 2));
        N = size(v, 1);
        width = size(v, 2);
        height = size(v, 2);
        
        for i = 1:width % column
            for j = 1:height % row
                sum = 0;
                for n = 1:N
                    sum = sum + (v(n, i) - means(i)) * (v(n, j) - means(j));
                end
                uc(j, i) = sum / N;
            end
        end
        
    end

end


