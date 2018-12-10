function class = KNN(dims, K, data, class_labels)
  distances = zeros(size(data));
  for i=1:length(data)
   % points = [dims;data.lab3_2(i,:)];
    points = [dims;data(i,:)];
    
    distance = pdist(points, 'euclidean');
    distances(i) = distance;
  end;
  [distances_sorted, distances_order] = sort(distances);
  class_sorted = class_labels(distances_order);
  class = mode(class_sorted(1:K));
 % disp(class);
end

