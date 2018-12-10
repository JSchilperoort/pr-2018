function error_rate = LOOCV(data, class_labels, K)
    error_rate = 0;
    total_correct = 0;
    total_incorrect = 0;
    for i=1:length(data)
       %i is the datapoint
       correct_class = class_labels(i);
       new_data = data;
       new_data(i,:)=[];
       found_class = KNN(data(i,:),K,new_data,class_labels);
       if correct_class == found_class
           total_correct = total_correct + 1;
       else
           total_incorrect = total_incorrect + 1;
       end
       error_rate = total_incorrect / total_correct;
       
    end
end