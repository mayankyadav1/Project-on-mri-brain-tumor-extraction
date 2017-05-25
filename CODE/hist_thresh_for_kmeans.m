function  [idx_t] = hist_thresh_for_kmeans(i)
i = imread('1__089.jpg');
i = rgb2gray(i);
%i = dicomread('000000.dcm');
figure;
imshow(i);
i = medfilt2(i);
i = histeq(i);
[x y] = size(i);
id = fix(y/2);
im1 = i(:,1:id);
im2 = i(:,id+1:y);
[h1 , y1]= imhist(im1);
[h2 , y2] = imhist(im2);
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
h_diff = abs(h1 - h2);
idx_t = find(h_diff == max(h_diff));
T = (255 - idx_t)/(255);
b = im2bw(i,T);
im = zeros(size(i));
for itr = 1 : x 
    for itrr = 1 : y
        if(i(itr,itrr) > 200)
            im(itr,itrr) = 255;
        end
    end
end
% im = clear_image(im);
figure;
bar(h1);
title('LEFT IMAGE HIST.','Color','r');
figure;
bar(h_diff);
title('RIGHT IMAGE HIST.','Color','r');
figure;
imshow(im)
% figure;
% imshow((b));
% title('WITH OUT MORPHOLOGY','Color','r');
% figure;
% imshow(b);
end