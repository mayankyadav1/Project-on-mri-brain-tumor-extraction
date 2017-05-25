function MY_BUTTON_PREVIOUS (hobject , event ,axesH )
global image_no;
global image_index_MAX;
image_no = (image_no - 1);
if (image_no > image_index_MAX )
 image_no = 1 ;
end
if (image_no < 1)
    image_no = image_index_MAX;
end
global image_data;
Filename = image_data{image_no};
%i = dicomread(Filename);
i = imread(Filename);
i = rgb2gray(i);
%i = medfilt2(i);
%i = imgaussfilt(i);
%i = histeq(i);
%i = i*6;
imshow(i,'parent',axesH);
title('parent',axesH,'ORIGINAL IMAGE TO BE ANALYSED','color','b');
end














