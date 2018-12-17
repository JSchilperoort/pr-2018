		
c = imread('Cameraman.tif');

edges = edge(c, 'canny');

[hc,theta,rho]	=	hough(edges);

% Code for question 3
%{
imagesc(hc);
xlabel('\theta(degrees)');
ylabel('\rho');
title('s2984318');
%}

hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;

P	=	houghpeaks(hc,5);
x	=	theta(P(:,2));	
y	=	rho(P(:,1));	

% Code for question 5
%{
	figure	
		imshow(imadjust(mat2gray(hc)),[],...	
				'XData',theta,...	
				'YData',rho,...	
				'InitialMagnification','fit');	
		xlabel('\theta	(degrees)')	
		ylabel('\rho')	
		axis	on	
		axis	normal	
		hold	on	
		colormap(hot)	
        
plot(x,y,'s','color','black');	
xlabel('\theta(degrees)');
ylabel('\rho');
title('s2984318');
%}

% Code for question 7
imshow(c);
title('s2984318');

for i=1:1
    y = rho(P(i,1));
    x = theta(P(i,2));
    myhoughline(c, y, x);
end

function myhoughline(image,r,theta)

[x,y]=size(image);
angle=deg2rad(theta);

if sin(angle)==0
    line([r r],[0,y],'Color','red')
  
else
    line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
end    
end



