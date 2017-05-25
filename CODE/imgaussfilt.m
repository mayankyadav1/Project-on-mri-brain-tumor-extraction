function [denoise_img] = imgaussfilt(denoise_img)
hsize = [3 3];
sigma = 0.5;
H = fspecial('gaussian', hsize, sigma);
denoise_img = imfilter(denoise_img,H);
end