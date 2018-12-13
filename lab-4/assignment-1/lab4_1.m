		
c = imread('Cameraman.tif');

edges = edge(c, 'canny');

%hc = hough(edges);
[hc,theta,rho]	=	hough(edges);	
%{
imagesc(hc);
xlabel('\theta(degrees)');
ylabel('\rho');
title('s2984318');
%}

hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;
%imagesc(hcTh);

P	=	houghpeaks(hc,5);	
x	=	(P(:,2));	
y	=	(P(:,1));	


%{
imagesc(hc);
hold on;

plot(x,y,'s','color','black');	
xlabel('\theta(degrees)');
ylabel('\rho');
title('s2984318');
%}

%imagesc(c);
imshow(c);
hold on;
%myhoughline(c, y, x);


for i=1:1
    x = (P(i,1));
    y = (P(i,2));

    myhoughline(edges, y, x);
end



%lines	=	houghlines(edges,theta,rho,P,'FillGap',5,'MinLength',7);

%{
lines	=	houghlines(edges,theta,rho,P);
max_len	=	0;	
		for	k	=	1:length(lines)	
					xy	=	[lines(k).point1;	lines(k).point2];	
					plot(xy(:,1),xy(:,2),'LineWidth', 2,'Color','green');	
		end	
%}


function myhoughline(image,r,theta)

[x,y]=size(image);
angle=deg2rad(theta);

if sin(angle)==0
    line([r r],[0,y],'Color','red')
  
else
    line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
end    
end

%{
function myhoughline(edges,r,theta)

[x,y]=size(image);
angle=deg2rad(theta);

if sin(angle)==0
    line([r r],[0,y],'Color','red')
  
else
    line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
end    
end
%}