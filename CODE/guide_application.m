close all;
clear;
clc;
h =  figure ; 
h.Position = [ 75 10 1280 680 ];
%%pos = [ 0.4 0.2 0.2 0.2 ] ;
global image_no ;
%%global image_no1 ;
image_no = 0;
%%image_no1 = 10;
%%PANNEL
pannelH = uipanel ( 'parent' , h );
pannelH.Title = 'Pannel';
pannelH.Units = 'pixels';
pannelH.BackgroundColor = [0 1 1];
pannelH.ForegroundColor = [1 1 1];
pannelH.Position = [ 0 0 1280 650];
%%AXIS IMAGE for original image
axisH = axes('parent' , pannelH );
axisH.Units = 'pixels';
axisH.Position = [ 450 250 350 350 ];
axisH.Color = [1 1 1];
axisH.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);
%%AXIS GRAPH 1 for kmeans
axisg1H = axes('parent' , pannelH );
axisg1H.Units = 'pixels';
axisgH1.BoxStyle = 'back';
axisg1H.LineWidth = 1;
axisg1H.Position = [ 50 280 150 150 ];
axisg1H.Color = [1 1 1];
axisg1H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 2 for kmeans
axisg2H = axes('parent' , pannelH );
axisg2H.Units = 'pixels';
axisg2H.BoxStyle = 'back';
axisg2H.LineWidth = 1;
axisg2H.Position = [ 50 450 150 150 ];
axisg2H.Color = [1 1 1];
axisg2H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 3 for kmeans
axisg3H = axes('parent' , pannelH );
axisg3H.Units = 'pixels';
axisg3H.BoxStyle = 'back';
axisg3H.LineWidth = 1;
axisg3H.Position = [ 250 280 150 150 ];
axisg3H.Color = [1 1 1];
axisg3H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 4 for kmeans
axisg4H = axes('parent' , pannelH );
axisg4H.Units = 'pixels';
axisg4H.BoxStyle = 'back';
axisg4H.LineWidth = 1;
axisg4H.Position = [ 250 450 150 150 ];
axisg4H.Color = [1 1 1];
axisg4H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 5 for kmeans
axisg5H = axes('parent' , pannelH );
axisg5H.Units = 'pixels';
axisg5H.BoxStyle = 'back';
axisg5H.LineWidth = 1;
axisg5H.Position = [ 50 8 250 250 ];
axisg5H.Color = [1 1 1];
axisg5H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 6 for histograms of left part of image
axisg6H = axes('parent' , pannelH );
axisg6H.Units = 'pixels';
axisg6H.BoxStyle = 'back';
axisg6H.LineWidth = 1;
axisg6H.Position = [ 900 460 150 150 ];
axisg6H.Color = [1 1 1];
axisg6H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 7 for histograms of right part of image
axisg7H = axes('parent' , pannelH );
axisg7H.Units = 'pixels';
axisg7H.BoxStyle = 'back';
axisg7H.LineWidth = 1;
axisg7H.Position = [ 1080 460 150 150 ];
axisg7H.Color = [1 1 1];
axisg7H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 8 for histogram segmentation without morphology
axisg8H = axes('parent' , pannelH );
axisg8H.Units = 'pixels';
axisg8H.BoxStyle = 'back';
axisg8H.LineWidth = 1;
axisg8H.Position = [ 1080 270 150 150 ];
axisg8H.Color = [1 1 1];
axisg8H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%AXIS GRAPH 9 for histogram segmentation with morphology
axisg9H = axes('parent' , pannelH );
axisg9H.Units = 'pixels';
axisg9H.BoxStyle = 'back';
axisg9H.LineWidth = 1;
axisg9H.Position = [ 976 8 240 240 ];
axisg9H.Color = [1 1 1];
axisg9H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);

%%BUTTON FOR IMAGE SLICE NO
axisg10H = axes('parent' , pannelH );
axisg10H.Units = 'pixels';
axisg10H.BoxStyle = 'back';
axisg10H.LineWidth = 1;
axisg10H.Position = [ 976 8 240 240 ];
axisg10H.Color = [1 1 1];
axisg10H.Box = 'on';
set(gca,'Color',[0.8 0.8 0.8]);




%%BUTTON LOAD IMAGE
buttonH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'LOAD IMAGE' , 'units' , 'normalized' );
buttonH.Units = 'pixels';
buttonH.Position  = [ 520 180 200 40 ] ;
set(buttonH , 'callback' , {@MY_BUTTON ,axisH});%%FUNCTIONCALL


%%BUTTON NEXT IMAGE

buttonlH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'NEXT IMAGE' , 'units' , 'normalized' );
buttonlH.Units = 'pixels';
buttonlH.Position  = [ 520 130 200 40 ] ;
set(buttonlH , 'callback' , {@MY_BUTTON_L ,axisH});

%%BUTTON PREVIOUS IMAGE

button_GLCMH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'PREVIOUS IMAGE' , 'units' , 'normalized' );
button_GLCMH.Units = 'pixels';
button_GLCMH.Position  = [ 520 80 200 40 ] ;
set(button_GLCMH , 'callback' , {@MY_BUTTON_PREVIOUS , axisH});

%%BUTTON FOR TUMOR EXTRACTION

button_PH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'RUN ANALYSIS' , 'units' , 'normalized' );
button_PH.Units = 'pixels';
button_PH.Position  = [ 520 30 200 40 ] ;
set(button_PH , 'callback' , {@gui ,axisH , axisg1H , axisg2H , axisg3H,axisg4H,axisg5H,axisg6H,axisg7H,axisg8H,axisg9H});

%%BUTTON TO RUN ANALYSIS

button_PH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'RUN ANALYSIS' , 'units' , 'normalized' );
button_PH.Units = 'pixels';
button_PH.Position  = [ 520 30 200 40 ] ;
set(button_PH , 'callback' , {@gui ,axisH , axisg1H , axisg2H , axisg3H,axisg4H,axisg5H,axisg6H,axisg7H,axisg8H,axisg9H});

%%BUTTON FOR IMAGE SLICE NO
button_INOH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'Go TO IMAGE NUMBER' , 'units' , 'normalized' );
button_INOH.Units = 'pixels';
button_INOH.Position  = [ 750 80 200 60 ] ;
set(button_INOH , 'callback' , {@set_image_no,axisH});

% % % %%BUTTON TO COLLECT ALL DATA
% % % button_H =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'COLLECT DATA' , 'units' , 'normalized' );
% % % button_H.Units = 'pixels';
% % % button_H.Position  = [ 310 80 200 60 ] ;
% % % set(button_H , 'callback' , {@collect_data,axisH});

%{
%%histogram with morphology
button_PH =  uicontrol('parent' , pannelH , 'style' , 'pushbutton' , 'string' , 'histogram-1' , 'units' , 'normalized' );
button_PH.Units = 'pixels';
button_PH.Position  = [ 560 130 80 40 ] ;
set(button_PH , 'callback' , {@my_kmeans ,axisH });
%}






























