function out = lab3_1()
    data = importdata('lab3_1.mat');
    mu1 = 5;
    mu2 = 7;
    variance = 4;
    sigma = sqrt(variance);
    
    x = -5:0.1:20;
    
    y1 = normpdf(x, mu1, sigma);
    y2 = normpdf(x, mu2, sigma);
%     plot(x, y1, x, y2)
    
    xdc = 10;
    h = 1 - normcdf(xdc, mu2, sigma);
    fa = 1 - normcdf(xdc, mu1, sigma);
    
    fprintf("Probability of a hit with x' = %d: %f\n", xdc, h);
    fprintf("Probability of a false alarm with x' = %d: %f\n", xdc, fa);
    
    
    fprintf("Discriminability with mu = [%d, %d], sigma = %d: %.1f\n", mu1, mu2, sigma, discriminability(mu1, mu2, sigma));
    mu2 = 9;
    fprintf("Discriminability with mu = [%d, %d], sigma = %d: %.1f\n", mu1, mu2, sigma, discriminability(mu1, mu2, sigma));
    d = 3;
    fprintf("mu2 with mu1 = %d, sigma = %d and d' = %d: %.1f\n", mu1, sigma, d, find_mu2(mu1, d, sigma));
    
    cp = 0; % 1 1
    fn = 0; % 1 0
    fp = 0; % 0 1
    cn = 0; % 0 0
    
    for i = 1:size(data(), 1)
        row = data(i, :);
        if row(1) == 1
            if row(2) == 1
                cp = cp + 1;
            elseif row(2) == 0
                fn = fn + 1;
            end
        elseif row(1) == 0
            if row(2) == 1
                fp = fp + 1;
            elseif row(2) == 0
                cn = cn + 1;
            end
        end
    end
    fprintf("h = %d, fn = %d, fa = %d, cn = %d\n", cp, fn, fp, cn);
    fprintf("hit rate = %.3f, fals alarm rate = %.3f\n", cp/(cp+fn), fp/(fp+cn));
    scatter(fp/(fp+cn), cp/(cp+fn))
    
	x_star = -10000:0.1:10000;
    
    d = 2.1231728;
    sigma = 10;
    a = sigma * d;
    x = 1 - normcdf(x_star, 10, sigma);
    y = 1 - normcdf(x_star, 10 + a, sigma);
    hold on
    plot(x, y);
    xlabel("false positive rate");
    ylabel("true positive rate");
%     for d = 2.12317280176:0.00000000001:2.12317280177
%         a = sigma * d;
%         xx = 1 - normcdf(x_star, 10, sigma);
%         yy = 1 - normcdf(x_star, 10 + a, sigma);
%         hold on;
%         plot(xx, yy);
%         xlabel("false positive rate");
%         ylabel("true positive rate");
%     end
   
    
end

function mu2 = find_mu2(mu1, d, sigma)
    mu2 = d * sigma + mu1;
end

function d = discriminability(mu1, mu2, sigma)
    d = abs(mu1 - mu2)/sigma;
end