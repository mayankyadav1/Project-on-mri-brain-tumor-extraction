function [i]=clear_image(i)
%i = imread('1__089.jpg');
%i = rgb2gray(i);
[b c] = size(i);
im1 = i(:,1:c/2);
im2 = i(:,c/2+1:c);
[x1 x2] = size(im1);
[xx1 xx2] = size(im2);

p = 150;%1400
i = bwareaopen(i,p);
% % % figure;
% % % imshow(i);
count1 = 0;
count2 = 0;
for itr1 = 1 : x1 
    for itr2 = 1 : x2
        if(im1(itr1,itr2) > 0)
            count1 = count1 + 1;
        end
        if(im2(itr1,itr2) > 0)
            count2 = count2 + 1;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for itr1 = 2 : 3 : b-1
    for itr2 = 2 : c/2 + 2
        c1 = 0 ;
        c2 = 0;
            if(i(itr1,itr2) == 0)
                c1 = c1 + 1;
            end
            if(i(itr1,itr2+1)==0)
                c1 = c1 + 1;
            end
            if(i(itr1-1,itr2+1)==0)
                c1 = c1 + 1;
            end
            if(i(itr1-1,itr2)==0)
                c1 = c1 + 1;
            end
            
            if(i(itr1-1,itr2-1) == 0)
                c1 = c1 + 1;
            end
            if(i(itr1,itr2-1)==0)
                c1 = c1 + 1;
            end
            if(i(itr1+1,itr2-1)==0)
                c1 = c1 + 1;
            end
            if(i(itr1+1,itr2)==0)
                c1 = c1 + 1;
            end
            
            if(i(itr1+1,itr2+1)==0)
                c1 = c1 + 1;
            end
            
            %FOR C2 COUNT
             if(i(itr1,c - itr2 + 1) == 0)
                c2 = c2 + 1;
            end
            if(i(itr1,c - itr2 + 2)==0)
                c2 = c2 + 1;
            end
            if(i(itr1-1,c - itr2 + 2)==0)
                c2 = c2 + 1;
            end
            if(i(itr1-1,c - itr2 + 1)==0)
                c2 = c2 + 1;
            end
            
            if(i(itr1-1,c - itr2) == 0)
                c2 = c2 + 1;
            end
            if(i(itr1,c - itr2)==0)
                c2 = c2 + 1;
            end
            if(i(itr1+1,c - itr2)==0)
                c2 = c2 + 1;
            end
            if(i(itr1+1,c - itr2 + 1)==0)
                c2 = c2 + 1;
            end
            
            if(i(itr1+1,c - itr2 + 2)==0)
                c2 = c2 + 1;
            end
            
            if(count1 > count2) % c1 CONTAINS TUMOR
                if(c2 < 5)%im1 contains tumor 
                    %col
                    i(itr1 - 1,c - itr2 + 2) = 0;
                    i(itr1,c - itr2 + 2) = 0;
                    i(itr1 + 1,c - itr2 + 2) = 0;
                    %row
                    i(itr1 - 1,itr2 - 1) = 0;
                    i(itr1,itr2 - 1) = 0;
                    i(itr1 + 1,itr2 - 1) = 0;
                end
            end
            
            if(count2 > count1)%c2 CONTAINS TUMOR
                if(c1 < 5)%im2 contains tumor 
                    %col
                    i(itr1 - 1,c - itr2 + 2) = 0;
                    i(itr1,c - itr2 + 2) = 0;
                    i(itr1 + 1,c - itr2 + 2) = 0;
                    %row
                    i(itr1 - 1,itr2 - 1) = 0;
                    i(itr1,itr2 - 1) = 0;
                    i(itr1 + 1,itr2 - 1) = 0;
                end
            end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for itr1 = 1 : b
    for itr2 = 1 : c/2
      if((i(itr1,itr2)> 0) && (i(itr1,c - itr2+1)> 0))
        i(itr1,itr2) = 0;
        i(itr1,c - itr2) = 0;
      end
    end
end
if(count1 > count2)
    for itr1 = 1 : b
        for itr2 = c/2 : c
            i(itr1,itr2) = 0;
        end
    end
    
elseif(count2 > count2)
    
    for itr1 = 1 : b
        for itr2 = 1 : c/2
            i(itr1,itr2) = 0;
        end
    end
end
% % % figure;
% % % imshow(i);
p = 150;%1400
i = bwareaopen(i,p);
% % % figure;
% % % imshow(i);
% % % title('mayank');
 se = strel('disk',2);
        i = imdilate(i,se);
        i = imerode(i,se);
       
%        p = 150;%1400
%        b = bwareaopen(b,p);
end