function [g1 , g2 ,t]= my_segmentation(a)
a = dicomread('000001.dcm');

%h=fspecial('average', [3 3]);
%a =  medfilt2(a);
%a= imfilter(a, h);
se = strel('disk',6);
       a = imerode(a,se);
       a= imdilate(a,se);
class(a);
figure;
imshow(a);

a =  uint8(a);
%t = mean2(a);
t = mean2(a);
dt = 1;
g1=[];
g2=[];
class(a);
%s = max(size(a));
%s = s*s
while(dt>0.0005)
    p =  uint8(a > t);
   
    g1 = a .* p;
    g1;
   % max(g1)
    q = uint8((a <= t));
    
    g2 = a .* q;
    g2;
   % max(g2)
    G1 = mean2(g1);
    G2 = mean2(g2);
    G1;
    G2;  
    t_new = (G1 + G2)/2;
    %t_new
    %t
    dt = abs(t_new - t);
    t = t_new;
    
end
dt;
t;
%sum(sum(p))
%sum(sum(q))
T = (65535 - t)/(65535);
%b =  int16(a >= t);
%b = im2bw(b);
%size(b);

b = im2bw(a,T);
figure;
subplot(2,1,1);
imshow(g1);
subplot(2,1,2);
imshow(g2);
min(min(a));
t
end
