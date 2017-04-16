function [extracted_tumor]=my_kmeans(image)  %my_kmeans(hobject , event,axis_H,i)
%clear;
%clc;
global image_no;
global image_data;
%i = image_data{image_no};
%i = '000004.dcm';
%image = dicomread(i);
 denoise_img = medfilt2(image);%to compare with size of orig img.
 com_img = (im2bw(denoise_img,graythresh(denoise_img) )> 0 );
 count_img = com_img > 0 ;
 count_img =sum(count_img(:));
 if count_img < 5000
     count_img = 5000 ;
 end
 %figure; %just showing the portion of brain to be compared with
 %imshow(com_img);
img = denoise_img(:);
max_ = max(img);
freq_arr = zeros(1,max_ + 1);
[a , b] = size(img);
d = a*b;
for itr = 1:d
     freq_arr(img(itr)+1) = freq_arr(img(itr)+1) + 1;
end
freq_arr;
size(freq_arr);
index_of_act_freq_present = find(freq_arr);
lengthh = length(index_of_act_freq_present);
k = 4;% centroids
centroid = [];
for itr = 1 : k
centroid(itr) = (max_/(itr));
end
%max1 = double(max_);
%Centroid=(1:k)*max1/(k+1);
centroid;
iteration = 0;
while(iteration<1)
      iteration = iteration + 1;
      old_centroid = centroid;
      for itr = 1 : lengthh
          a = abs(index_of_act_freq_present(itr) - centroid);
          class = find(a == min(a));
          mem(index_of_act_freq_present(itr)) = class(1);
      end
      for itr=1:k,
      class_i=find(mem==itr);
      Centroid(itr)=sum(class_i.*freq_arr(class_i))/sum(freq_arr(class_i)); 
      end
      if(Centroid == old_centroid) 
      break;
      end
end
centroid;
[c d] = size(image);
i = double(image);
for itr=1:c,
  for j=1:d,
      new_val=abs(i(itr,j)-Centroid);
      class=find(new_val==min(new_val));
      new_cluster(itr,j)=class(1);
  end
end
%{
 MODIFIED_LATER
h = figure; 
h.Position = [ 75 10 1280 650 ];
axisH = axes('parent' , h);
axisH.Units = 'pixels';
axisH.Position = [  50 250 350 350 ];
axisH.Color = [1 1 1];
axisH.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

imshow(denoise_img.*6,'parent',axisH);title('Denoised Image');

axisH1 = axes('parent' , h);
axisH1.Units = 'pixels';
axisH1.Position = [  650 250 350 350 ];
axisH1.Color = [1 1 1];
axisH1.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);
MODIFIED_LATER
%}
extracted_tumor = zeros(size(image));

for itr = 1:k
       cluster = zeros(size(image));
       pos = find(new_cluster==itr);
       cluster(pos) = new_cluster(pos);
       
       cluster = cluster > 0 ;
  
       se = strel('disk',6);
       %cluster = imerode(cluster,se);
       cluster = imdilate(cluster,se);
       cluster = imerode(cluster,se);
       p = 150;%1400
       cluster = bwareaopen(cluster,p);
       %cluster = imopen(cluster,se);
       %cluster = imclose(cluster,se);
       %cluster = imfill(cluster,'holes');
       count_cluster_img = cluster > 0;
       count_cluster_img = sum(count_cluster_img(:));
       if (count_cluster_img > 50 && count_cluster_img < (0.4*count_img) )
           cluster = cluster + extracted_tumor ;
           cluster = cluster > 0 ;
       %imshow(cluster,'parent',name(itr));title('K-means');
           extracted_tumor = cluster ; 
       end 
       
       data=cluster;
end
 %imshow(extracted_tumor,'parent',axisH1);title('EXTRACTED TUMOR');
mem;
end

