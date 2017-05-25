function test2(cluster1,hobject , event,axisg1H , axisg2H , axisg3H,axisg4H,axisg5H)%(cluster1)
%image = dicomread('VSD0089.Brain.XX.O.MR_T2.687.mha_1.dcm');
global image_no;
global image_data;
i = image_data{image_no};
%i = '000000.dcm';
%image = dicomread(i); MODIFIED ON 5/10/17
image = imread(i);
image = rgb2gray(image);
%denoise_img = imgaussfilt(image);
denoise_img = histeq(image);

%12/5/17
im = denoise_img;
%denoise_img = medfilt2(image);

min_intensity = min(min(denoise_img));
%%%%%%%%%%%%%%%%%%%%%
[x ,y] = size(denoise_img);
       for itri = 1 : x
           for itrj = 1 : y
                 if(cluster1(itri,itrj)>0)
                     denoise_img(itri,itrj)=min_intensity;%min_intensity;
                 end
           end
       end
       imshow(denoise_img,'parent',axisg5H);%denoise_img
    % figure;
    % imshow(cluster1);
%%%%%%%%%%%%%%%%%%%%%
% denoise_img = 1;
%hist_thresh_for_kmeans(denoise_img);
img = denoise_img(:);
max_ = max(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
for itr = 1 : max(size(img))
    if(itr == max_)
        img(itr) = 0;
    end
end
max_ = max(img);
[x y] = size(denoise_img);
for itrx = 1 : x
    for itry = 1 : y
    if(denoise_img(itrx,itry) == max_ )
        denoise_img(itrx,itry) = 0;
    end
    end
end
%}
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
k = 5;% centroids
centroid = [];
% for itr = 1 : k
% centroid(itr) = (max_/(itr));
% end
centroid = [1 60 105 230 250];

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
for itr=1:c,
  for j=1:d,
      new_val=abs(i(itr,j)-Centroid);
      class=find(new_val==min(new_val));
      new_cluster(itr,j)=class(1);
  end
end
new_cluster;
%name = [axisg1H,axisg2H,axisg3H,axisg4H];
minn = min(min(im));
[x1 y1] = size(image);
new_image = zeros(x1,y1);
%figure;
%imshow(cluster1);
for itr1 = 1: x1
    for itr2 = 1:y1
        
     if(new_cluster(itr1,itr2) == 1)
         new_image(itr1,itr2) = 0 ;
     elseif(new_cluster(itr1,itr2)==2)
             new_image(itr1,itr2) = 0;
         elseif(new_cluster(itr1,itr2) == 3)
                 new_image(itr1,itr2) = 100;
     elseif (new_cluster(itr1,itr2)==4)
         new_image(itr1,itr2) = 255;
     else
         new_image(itr1,itr2) = 0;
     end
        if(cluster1(itr1,itr2) > 0)
            new_image(itr1,itr2) = 0;
        end
    end
end
new_image;
accuracy(event,hobject,axisg4H,new_image);
% cluster_img = zeros(x1,y1);
% for itr = 1:k
%        cluster = zeros(size(image));
%        pos = find(new_cluster==itr);
%        cluster(pos) = new_cluster(pos);
%        cluster = cluster > 0 ;
%        figure;
%        
%        for itr1 = 1:x1
%            for itr2 = 1:x2
%                if(cluster(itr1,itr2) > 0 && itr == 1)
%                     cluster_img(itr1,itr2) = 0;
%                elseif(cluster(itr1,itr2) > 0 && itr == 2)
%                        cluster_img = 100;
%                elseif(cluster(itr1,itr2) >0 && itr == 3)
%                            cluster_img(itr1,itr2) = 180;
%                        else
%                            cluster_img(itr1,itr2) = 255;
%               end
%            end
%        end
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        image_ = im;%image variable for threshold cluster
%        
%        for itr1 = 1 : x1
%            for itr2 = 1 : y1
%            if(cluster(itr1,itr2) == 1)
%                image_(itr1,itr2) = 0;
%            else if(cluster(itr1,itr2)==2)
%               image_(itr1,itr2) = 100;
%                else if (cluster(itr1,itr2)==3)
%                        image_(itr1,itr2)=180;
%                    else image_(itr1,itr2)=255;
%                    end
%                end
%            end
%            end
%        end
      %{
 t = hist_thresh_for_kmeans(image_);
       for itr1 = 1 : x1
           for itr2 = 1 : y1
           if(image_(itr1,itr2) < t )
               image_(itr1,itr2) = minn;
               cluster(itr1,itr2) = 0;
           end
           end
       end
       %}
       
       
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       % p = 150;%1400
       %cluster = bwareaopen(cluster,p);
       %se = strel('disk',2);
       %cluster = imdilate(cluster,se);
       %cluster = imerode(cluster,se);
       
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %imshow(cluster,'parent' , name(itr));
       %imshow(cluster,'parent',name(itr));
%        figure;
%        imshow(image_);%cluster
%        a = 'cluster';
%        a = strcat(a,int2str(itr));
%       title(a);
%       image_ = im;
%figure;
[s1 s2] = size(new_image);
nw = zeros(size(new_image));
for itr1 = 1 : s1
    for itr2 = 1 : s2
    if new_image(itr1,itr2) > 0     
        nw(itr1 ,itr2) = 255;
    end
    end
end
    imshow(uint8(nw),'parent',axisg1H);
    figure;
    imshow(uint8(nw));
    
end

