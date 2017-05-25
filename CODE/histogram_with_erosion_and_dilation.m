function  histogram_with_erosion_and_dilation(hobject,event,axisg9H)
im = imread('1__093.jpg');
i = rgb2gray(im); 
denoised_image = medfilt2(i);
[b c] = size(denoised_image);
im1 = denoised_image(:,1:c/2);
im2 = denoised_image(:,(c/2+1):c);
figure;
subplot(1,2,1);
imshow((im1));
subplot(1,2,2);
imshow((im2));

im11 = ( im1(:));
im22 = ( im2(:));
l1 = length(im11);
l2 = length(im22);

max_1 = max(im11)
max_2 = max(im22)

if max_1 > max_2
    max_ = max_1;
else 
    max_ = max_2;
end

freq1 = zeros(1,max_+1);
freq2 = zeros(1,max_+1);

for itr  = 1 : max_+1
    freq1(im11(itr)+1) = freq2(im11(itr)+1) + 1 ;
    freq2(im22(itr)+1) = freq2(im22(itr)+1) + 1 ; 
end

freq_diff = abs(freq1 - freq2);
freq_diff;

t1 = find(freq_diff == max(freq_diff));
[b c] = size(im);
for itr1 = 1 : b
    for itr2 = 1 : c
        if(im(itr1,itr2) < t1)
            im(itr1,itr2) = 255;
        else
            im(itr1,itr2) = 0;
        end
    end
end
figure;
imshow(im);
%[g1 g2 t2] = my_segmentation(i);
t1
%t2;
%t = (t1+t2)/2;
t = t1;
end