function [stats stats2 stats3] = runglcm(i)
offsets0 = [zeros(40,1) (1:40)'];
offsets1 = [-(40 + (-40:-1))' zeros(40,1)];
offsets2 = [-(40 + (-40:-1))' (40 + (-40:-1))'];
glcm = graycomatrix(i,'offset',offsets0,'Symmetric',true,'GrayLimits',[]);%%[] to give range as in original image
glcm2 = graycomatrix(i,'offset',offsets1,'Symmetric',true,'GrayLimits',[]);
glcm3 = graycomatrix(i ,'offset',offsets2,'Symmetric',true,'GrayLimits',[]);
stats = graycoprops(glcm , {'contrast','homogeneity','energy','correlation'});
stats2 = graycoprops(glcm2 , {'contrast','homogeneity','energy','correlation'});
stats3 = graycoprops(glcm3 , {'contrast','homogeneity','energy','correlation'});
%%MODIFICATION ON 12-24-16

%%MODIFICATION END
glcm;
 stats.Contrast ;
 stats.Homogeneity ;
 stats.Energy ;
 stats.Correlation ;
end