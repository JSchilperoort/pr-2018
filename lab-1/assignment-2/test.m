function a = test()

mn = 0.499;
stdev = 0.032;



% ((stdev^2) * (1 - stdev^2)) / (mn)
% ((stdev) * (1 - stdev)) / (mn^2)
% ((stdev^2) * (1 - stdev^2)) / (mn^2)
% ((stdev) * (1 - stdev)) / (mn)
% ((stdev) * (1 - stdev)) / (stdev^2)
% ((mn^2) * (1 - mn^2)) / (stdev^2)
% ((mn) * (1 - mn)) / (stdev)