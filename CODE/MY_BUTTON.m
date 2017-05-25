function MY_BUTTON (hobject,event , axesH)
%%msgbox('Its Gonna Be Owsome');
global image_no;
global image_data ;
global image_index_MAX ;
image_data =  getAllFiles('E:\5-17-17\project final code\output\op1\data\patient id');%E:\project final code\data\ids_training_data
image_no = 1 ;
image_index_MAX = numel(image_data);
%i = dicomread(image_data{1});
i = imread(image_data{1});
i = rgb2gray(i);
%i = dicomread('000000.dcm');
i = medfilt2(i);
i = imgaussfilt(i);
%i = histeq(i);
%i = i*6;
imshow(i,'parent',axesH);
title('parent',axesH,'ORIGINAL IMAGE TO BE ANALYSED','color','b');
%%imshow(i,'parent',axesH); 
end