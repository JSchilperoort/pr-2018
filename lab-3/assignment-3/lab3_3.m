
function f = lab_3_3()
    h = 1;
    d1 = load('lab3_3_cat1.mat')
    d2 = load('lab3_3_cat2.mat');
    d3 = load('lab3_3_cat3.mat');

    x1 = d1.x_w1
    x2 = d2.x_w2;
    x3 = d3.x_w3;

    u = [0.5;1.0;0.0];
    v = [0.31;1.51;-0.50];
    w = [-1.7;-1.7;-1.7];

    fprintf("The probability density of class 1 in point u is %4.6f \n", compute_density(x1, u, 1));
    fprintf("The probability density of class 2 in point u is %4.6f \n", compute_density(x2, u, 1));
    fprintf("The probability density of class 3 in point u is %4.6f \n \n", compute_density(x3, u, 1));

    fprintf("The probability density of class 1 in point v is %4.6f \n", compute_density(x1, v, 1));
    fprintf("The probability density of class 2 in point v is %4.6f \n", compute_density(x2, v, 1));
    fprintf("The probability density of class 3 in point v is %4.6f \n \n", compute_density(x3, v, 1));

    fprintf("The probability density of class 1 in point w is %4.6f \n", compute_density(x1, w, 1));
    fprintf("The probability density of class 2 in point w is %4.6f \n", compute_density(x2, w, 1));
    fprintf("The probability density of class 3 in point w is %4.6f \n\n", compute_density(x3, w, 1));

    posterior(1);
    posterior(2);
    labels = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3];
    K = 1;
    fprintf("According to KNN (k=1), point u belongs to class %d \n", KNN(u', K, cat(1, x1, x2, x3), labels));
    fprintf("According to KNN (k=1), point v belongs to class %d \n", KNN(v', K, cat(1, x1, x2, x3), labels));
    fprintf("According to KNN (k=1), point w belongs to class %d \n\n", KNN(w', K, cat(1, x1, x2, x3), labels));
    
    K = 5;
    fprintf("According to KNN (k=5), point u belongs to class %d \n", KNN(u', K, cat(1, x1, x2, x3), labels));
    fprintf("According to KNN (k=5), point v belongs to class %d \n", KNN(v', K, cat(1, x1, x2, x3), labels));
    fprintf("According to KNN (k=5), point w belongs to class %d \n\n", KNN(w', K, cat(1, x1, x2, x3), labels));




    function f = posterior(h)
        fprintf("h = %d\n", h);
        posterior = compute_density(x1, u, h) / (compute_density(x1, u, h) + compute_density(x2, u, h) + compute_density(x3, u, h));
        fprintf("The posterior probability of class k = 1 for point u is %4.6f \n", posterior);
        posterior = compute_density(x2, u, h) / (compute_density(x1, u, h) + compute_density(x2, u, h) + compute_density(x3, u, h));
        fprintf("The posterior probability of class k = 2 for point u is %4.6f \n", posterior);
        posterior = compute_density(x3, u, h) / (compute_density(x1, u, h) + compute_density(x2, u, h) + compute_density(x3, u, h));
        fprintf("The posterior probability of class k = 3 for point u is %4.6f \n\n", posterior);

        posterior = compute_density(x1, v, h) / (compute_density(x1, v, h) + compute_density(x2, v, h) + compute_density(x3, v, h));
        fprintf("The posterior probability of class k = 1 for point v is %4.6f \n", posterior);
        posterior = compute_density(x2, v, h) / (compute_density(x1, v, h) + compute_density(x2, v, h) + compute_density(x3, v, h));
        fprintf("The posterior probability of class k = 2 for point v is %4.6f \n", posterior);
        posterior = compute_density(x3, v, h) / (compute_density(x1, v, h) + compute_density(x2, v, h) + compute_density(x3, v, h));
        fprintf("The posterior probability of class k = 3 for point v is %4.6f \n\n", posterior);

        posterior = compute_density(x1, w, h) / (compute_density(x1, w, h) + compute_density(x2, w, h) + compute_density(x3, w, h));
        fprintf("The posterior probability of class k = 1 for point w is %4.6f \n", posterior);
        posterior = compute_density(x2, w, h) / (compute_density(x1, w, h) + compute_density(x2, w, h) + compute_density(x3, w, h));
        fprintf("The posterior probability of class k = 2 for point w is %4.6f \n", posterior);
        posterior = compute_density(x3, w, h) / (compute_density(x1, w, h) + compute_density(x2, w, h) + compute_density(x3, w, h));
        fprintf("The posterior probability of class k = 3 for point w is %4.6f \n\n", posterior);
    end

    function sum = compute_density(class_data, point, h)
        sum = 0;
        for i=1:10
            density = exp(- (((point(1)-class_data(i,1))^2 + ((point(2)-class_data(i,2))^2 + ((point(3)-class_data(i,3))^2))) / 2*h^2));
            sum = sum + density;
        end
        sum = sum / (h*sqrt(2*pi))^3;
        sum = sum / 10;
    end
end
    