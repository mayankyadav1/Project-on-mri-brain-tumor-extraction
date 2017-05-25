function accuracy(event,hobject,axisg1H,cluster)
global image_no;
global image_data_gt ;
global image_index_MAX_gt ;
image_data_gt = getAllFiles('E:\5-17-17\project final code\output\op1\data\ground truth');%E:\project final code\data\ground truth
%img = dicomread(image_data_gt{image_no});
%figure;
img_g = imread(image_data_gt{image_no});
img_g = rgb2gray(img_g);
[b c] = size(img_g);
img_g;
cluster = clear_image(cluster);
image_index_MAX_gt = b * c;
% figure;
imshow(cluster,'parent',axisg1H);
TT = 0;%ground truth 1 and our 1 
TF = 0;%ground truth 1 and our 0
FF = 0;%ground truth 0 and our 0
FT = 0;%ground truth 0 and our 1
count5 = 0;%ground truth > 1
count6 = 0;%ground truth < 1
for itr1 = 1 : b
    for itr2 = 1 : c
         if(img_g(itr1,itr2) > 30)
             count5 = count5 + 1;
             if(cluster(itr1,itr2) >= 1)
                 TT = TT + 1;
             else
                 TF = TF + 1;
             end
         end
         if(img_g(itr1,itr2) <= 30)
             count6 = count6 + 1;
             if(cluster(itr1,itr2) < 1)
                 FF = FF + 1;
             else
                 FT = FT + 1;
             end
         end
    end
end
global ACCURACY ;
global SENSITIVITY;
global SPECIFICITY;
if(image_no <= image_index_MAX_gt)
ACCURACY{image_no} = (TT + FF)/ (TT + TF + FF + FT)
SENSITIVITY{image_no} = (TT)/(TT + TF )
SPECIFICITY{image_no} = (FF) / (FF + FT)
image_no
end
% % TT
% % TF
% % FF 
% % FT
% % count5
% % count6
% % b
% % c
end