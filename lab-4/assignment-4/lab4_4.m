I = imread('HeadTool0002.bmp');
I2 = im2double(I);
J = adapthisteq(I2);
imshow(J);
[centers, radii, metric] = imfindcircles(J, [20 60], 'Sensitivity',0.9);
disp(centers);

%{
centersStrong6 = centers(1:6,:); 
radiiStrong6 = radii(1:6);
metricStrong6 = metric(1:6);
viscircles(centersStrong6, radiiStrong6,'EdgeColor','r');
%}

centersStrong2 = centers(1:2,:); 
radiiStrong2 = radii(1:2);
metricStrong2 = metric(1:2);
viscircles(centersStrong2, radiiStrong2,'EdgeColor','r');