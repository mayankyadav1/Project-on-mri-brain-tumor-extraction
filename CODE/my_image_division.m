function  my_image_division(hobject,event,axisg6H,axisg7H,axisg8H) %[idx_t] =
global image_no;
global image_data;
im = image_data{image_no};
%i = dicomread('000000.dcm');
i = dicomread(im);
i = medfilt2(i);
i = histeq(i);
[x y] = size(i);
id = fix(y/2);
im1 = i(:,1:id);
im2 = i(:,id+1:y);
[h1 , y1]= imhist(im1,256);
[h2 , y2] = imhist(im2,256);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size(h1);
h1;
size(h2);
h2;
size(y1);
y1;
size(y2);
y2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h_diff = int16(h1 - h2);
idx_t = find(h_diff == max(h_diff));
T = (65535 - idx_t)/(65535);
b = im2bw(i,T);
bar(h1,'parent',axisg6H);
title(axisg6H,'LEFT IMAGE HIST.','Color','r');
bar(h1,'parent',axisg7H);
title(axisg7H,'RIGHT IMAGE HIST.','Color','r');
imshow(b,'parent',axisg8H);
title(axisg8H,'WITH OUT MORPHOLOGY','Color','r');
%figure;
%imshow(b);
end