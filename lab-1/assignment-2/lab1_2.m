function [S, D] = lab1_2()
    data = load_data();
    S = get_S(data);
    D = get_D(data);
    
    h1 = histogram(S);
    h1.BinWidth = 0.033333333333;
    hold on
    h2 = histogram(D);
    h2.BinWidth = 0.033333333333;
    xlabel('Normalized Hamming distance')
    ylabel('frequencies')
    x = 0:0.001:0.8;
    ys = normpdf(x, mean(S), std(S)) * (1300/4);
    yd = normpdf(x, mean(D), std(D)) * (1300/4);

    plot(x, ys, x, yd)

    fprintf('Mean of S = %.4f\n', mean(S));
    fprintf('Variance of S = %.5f\n', var(S));
    fprintf('Mean of D = %.4f\n', mean(D));
    fprintf('Variance of D = %.5f\n', var(D));
    fprintf('Degrees of freedom = %.f\n', degrees_of_freedom(D));
    
    % PART 2:
    d = 7/30;
    S_ncdf = normcdf(d, mean(S), std(S));
    D_ncdf = normcdf(d, mean(D), std(D));
    
    fprintf('Correct accept = %.6f\n', S_ncdf);
    fprintf('False rejection rate = %.6f\n', 1-S_ncdf);
    
%     fprintf('Correct reject = %.6f\n', 1-D_ncdf);
%     fprintf('False acceptance error = %.6f\n', D_ncdf);
    test_person_id = find_test_person(data);
    fprintf('Test person is most likely person "%.f"\n', test_person_id);
    

end


function tp = find_test_person(data)
    test_person = importdata('X:\My Documents\MATLAB\Pattern Recognition\Lab 1\assignment 2\testperson.mat'); 
    smallest_hd = 99999.0;
    test_person_id = 99;
    for person = 1:20
        hd = 0;
        for row = 1:20
            hd = hd + get_hd(test_person, data(row,:, person));  
        end
        if hd < smallest_hd
            smallest_hd = hd;
        	test_person_id = person;
        end
    end
    tp = test_person_id;
end


function dof = degrees_of_freedom(D)
    mD = mean(D);
    stD = std(D);
    dof = ((mD) * (1 - mD)) / (stD ^ 2);
end


function D = get_D(data)
    n = 10000;
    D = zeros(1, n);
    for i = 1:n
        person1 = randi([1, 20], 1);
        person2 = randi([1, 20], 1);
        while person2 == person1
            person2 = randi([1, 20], 1);
        end
        row1_index = randi([1, 20], 1);
        row2_index = randi([1, 20], 1);

        row1 = data(row1_index, :, person1);
        row2 = data(row2_index, :, person2);
        HD = get_hd(row1, row2);
        D(i) = HD;
    end

end


function S = get_S(data)
    n = 10000;
    S = zeros(1, n);
    for i = 1:n
        person = randi([1, 20], 1);
        
        row1_index = randi([1, 20], 1);
        row2_index = randi([1, 20], 1);
        while row2_index == row1_index
            row2_index = randi([1, 20], 1);
        end
        
        row1 = data(row1_index, :, person);
        row2 = data(row2_index, :, person);
        HD = get_hd(row1, row2);
        S(i) = HD;
        
    end

end


function HD = get_hd(row1, row2)
    s = size(row1, 2);
    HD = 0;
    for i = 1:s
        if row1(i) ~= 2 && row2(i) ~= 2 % missing value
            HD = HD + abs(row1(i) - row2(i));
        end
    end
    HD = HD/30;
end


function data = load_data()
    data = zeros(20, 30, 20);
    for i = 1:20
        % person, rows, line
        data(:,:,i) = importdata(get_filename(i));
    end
end


function filename = get_filename(id)
    dir = 'X:\My Documents\MATLAB\Pattern Recognition\Lab 1\assignment 2\person';
    if (id < 10)
        ps = join(['0', string(id), '.mat'], '');
    else
        ps = join([string(id), '.mat'], '');
    end
    filename = join([dir, ps], '');
end