
function f = lab_3_3()
h = 1;
d1 = load('lab3_3_cat1.mat');
d2 = load('lab3_3_cat2.mat');
d3 = load('lab3_3_cat3.mat');

x1 = d1.x_w1;
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
fprintf("The probability density of class 3 in point w is %4.6f \n", compute_density(x3, w, 1));

function sum = compute_density(class_data, point, h)
    sum = 0;
    for i=1:10
        density = exp(- (((point(1)-class_data(i,1))^2 + ((point(2)-class_data(i,2))^2 + ((point(3)-class_data(i,3))^2))) / 2*h^2));
        sum = sum + density;
    end;
    sum = sum / (h*sqrt(2*pi))^3;
    sum = sum / 10;



    