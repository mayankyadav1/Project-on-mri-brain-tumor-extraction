function test_ground_comp(hobject,event,axis9H)
global image_no;
global image_data_gt ;
global image_index_MAX_gt ;
image_data_gt = getAllFiles('E:\5-17-17\project final code\output\op1\data\ground truth');%E:\project final code\data\ground truth
%img = dicomread(image_data_gt{image_no});
%figure;
img = imread(image_data_gt{image_no});
%img = rgb2gray(img);
[b c] = size(img);
for  itr1 = 1 : b
    for  itr2 = 1 : c
        if(img(itr1,itr2) > 30)
            img(itr1,itr2) = 255;
        end
    end
end

imshow(img,'parent',axis9H);
%title('1st cluster removed');
image_no;
end