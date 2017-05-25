image_data =  getAllFiles('E:\mayank1\DOI\W1');
size(image_data)
numel(image_data);
B = [];
for itr = 1 : max(size(image_data))
   i = dicomread(image_data{itr});
   image_tumor = my_kmeans(i);
   [stats stats1 stats2] = run_GLCM(image_tumor);
   A = [stats stats1 stats2];
   B = cat(1,A,B);
   itr
end
