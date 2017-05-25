function set_image_no(hobject , event,axesH)
global image_no;
%x = inputdlg('input image number');
x = input('input image number');
image_no = x;
%display(image_no);

global image_data;
i = image_data{image_no};
%i = '000000.dcm';
%image = dicomread(i); MODIFIED ON 5/10/17
image = imread(i);
image = rgb2gray(image);
denoise_img = imgaussfilt(image);
denoise_img = histeq(denoise_img);
imshow(image,'parent',axesH);
title('parent',axesH,'ORIGINAL IMAGE TO BE ANALYSED','color','b');
end