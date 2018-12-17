I = imread('dogGrayRipples.png');
I = im2double(I);
f = fft2(I); 
fs= fftshift(f);
f = abs(fs);
f = log(1+f);
%imshow(f,[]);
%hold on;
%mask=zeros(size(f));
		
	
[x, y] =find(f==max(f));
disp(y);
%80 is best so far
rows = size(f,1),cols = size(f,2),radius = 80,center = [x; y];  
[xMat,yMat] = meshgrid(1:cols,1:rows);

for i =1:size(center,2)
   % disp(center);
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
end

mask=zeros(size(f));
mask(distFromCenter<=radius)=1;
%figure, imshow(~mask,[]);title('Mask')



fs=fs.*(~mask);
f = ifftshift(fs);
I = real(ifft2(f));
figure, imshow(I, []), title('s2984318');