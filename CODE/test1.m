 function test1(hobject , event,axisg1H , axisg2H , axisg3H,axisg4H,axisg5H)
global image_no;
global image_data;
i = image_data{image_no};
%i = '000000.dcm';
%image = dicomread(i); MODIFIED ON 5/10/17
image = imread(i);
image = rgb2gray(image);
%denoise_img = imgaussfilt(image);

%5/16/17
%denoise_img = clear_image_before_processing(image);

denoise_img = histeq(image);
% figure;
% imshow(denoise_img);

%image = dicomread('VSD0089.Brain.XX.O.MR_T2.687.mha_1.dcm');
%denoise_img = histeq(image);

%denoise_img = medfilt2(image);

min_intensity = min(min(denoise_img));

%figure;
%imshow(histeq(denoise_img));
 com_img = (im2bw(denoise_img,graythresh(denoise_img) )> 0 );
 count_img = com_img > 0 ;
 count_img =sum(count_img(:));
% if count_img < 5000
%     count_img = 5000 ;
% end
img = denoise_img(:);
max_ = max(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for itr = 1 : max(size(img))
    if(itr == max_)
        img(itr) = 0;
    end
end
[x y] = size(denoise_img);
for itrx = 1 : x
    for itry = 1 : y
    if(denoise_img(itrx,itry) == max_ )
        denoise_img(itrx,itry) = 0;
    end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
freq_arr = zeros(1,max_ + 1);
[a , b] = size(img);
d = a*b;
for itr = 1:d
     freq_arr(img(itr)+1) = freq_arr(img(itr)+1) + 1;
end
freq_arr;
size(freq_arr);
index_of_act_freq_present = find(freq_arr);%indices non zero
lengthh = length(index_of_act_freq_present);
k = 4;% centroids
centroid = [];
for itr = 1 : k
centroid(itr) = (max_/(itr));
end
centroid;
iteration = 0;
while(iteration<10)
      iteration = iteration + 1;
      old_centroid = centroid;
      for itr = 1 : lengthh %size of vector
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
%centroid;
[c d] = size(image);
i = double(image);
%Assign final class. 
for itr=1:c,
  for j=1:d,
      new_val=abs(i(itr,j)-Centroid);
      class=find(new_val==min(new_val));
      new_cluster(itr,j)=class(1);
  end
end

%{
h = figure; 
h.Position = [ 75 10 1280 650 ];
axisH = axes('parent' , h);
axisH.Units = 'pixels';
axisH.Position = [  250 250 350 350 ];
axisH.Color = [1 1 1];
axisH.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

imshow(denoise_img.*6,'parent',axisH);title('Denoised Image');

axisH1 = axes('parent' , h);
axisH1.Units = 'pixels';
axisH1.Position = [  650 450 150 150 ];
axisH1.Color = [1 1 1];
axisH1.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

axisH2 = axes('parent' , h);
axisH2.Units = 'pixels';
axisH2.Position = [  650 250 150 150 ];
axisH2.Color = [1 1 1];
axisH2.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

axisH3 = axes('parent' , h);
axisH3.Units = 'pixels';
axisH3.Position = [  850 450 150 150 ];
axisH3.Color = [1 1 1];
axisH3.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

axisH4 = axes('parent' , h);
axisH4.Units = 'pixels';
axisH4.Position = [  850 250 150 150 ];
axisH4.Color = [1 1 1];
axisH4.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);
%}
%extracted_tumor = zeros(size(image));
%name = [axisg1H,axisg2H,axisg3H,axisg4H];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cluster = zeros(size(image));
for itr = 4 : 4 %3:4
    %if (itr == 4)
       pos = find(new_cluster==itr);
       cluster(pos) = new_cluster(pos);
       cluster = cluster > 0 ;
%        se = strel('disk',6);
%        p = 150;%1400
       count_cluster_img = cluster > 0;
       count_cluster_img = sum(count_cluster_img(:));
%        cluster = cluster + cluster;
    %end
end
%figure;
%imshow(cluster);
cluster = cluster > 0;
cluster;
       %figure;
       imshow(uint8(cluster*255),'parent',axisg2H);
       title('parent',axisg2H,'clster1');
       
       figure;
       imshow(uint8(cluster*255));
% AGAIN KMEANS CLUSTERING
test2(cluster,hobject , event,axisg1H , axisg2H , axisg3H,axisg4H,axisg5H);

%test2(cluster);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
for itr = 1:k
       cluster = zeros(size(image));
       pos = find(new_cluster==itr);
       cluster(pos) = new_cluster(pos);
       cluster = cluster > 0 ;
       figure;
       imshow(cluster);
       a = 'cluster';
       a = strcat(a,int2str(itr));
       title(a);
end
end
%}
 end