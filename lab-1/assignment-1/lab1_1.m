function out = lab1_1()

data = importdata('X:\My Documents\MATLAB\Pattern Recognition\Lab 1\assignment 1\lab1_1.mat');

out = corrcoef(data);

height = data(:,1);
age = data(:,2);
weight = data(:,3);

f1 = figure;
f2 = figure;

figure(f1);
scatter(height, weight, [], 'red')
title('Largest')
xlabel('Feature 1: Height in centimeters')
ylabel('Feature 3: Weight in kilograms')

figure(f2);
scatter(age, weight, [], 'green', 's')
title('Second largest')
xlabel('Feature 2: Age in years')
ylabel('Feature 3: Weight in kilograms')