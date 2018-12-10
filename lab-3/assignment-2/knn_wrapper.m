clear all;
load lab3_2.mat;

K=1;
samples=64;
data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

error_rate_K3 = LOOCV(data, class_labels, 3);
error_rate_K17 = LOOCV(data, class_labels, 17);
fprintf("LOOCV error rate for K = 3: %4.6f\n", error_rate_K3);
fprintf("LOOCV error rate for K = 17: %4.6f\n", error_rate_K17);

error_plot_data = zeros(1,30);
for i=1:30
    error_rate = LOOCV(data, class_labels, i);
    error_plot_data(i) = error_rate;
end



plot(error_plot_data);
xlabel('K');
ylabel('LOOCV Classification Error');

[M,I] = min(error_plot_data);
fprintf("Optimal value for K = %4.6f where classification error = %4.6f \n", I, M);

% Sample the parameter space


result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    result(j,i) = KNN([X Y],K,data,class_labels);
  end;
end;

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');


