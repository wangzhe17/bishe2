clc;
clear;
tic;
I=imread('my7.png');                                      %读取原图
BW=preprocessing(I);                                     %预处理
graphic=textseparate(BW);                                %去字符
flowchartThin=thinFlowchart(graphic); 
graphiclinewidth1=calculateGraphiclinewidth(graphic,flowchartThin);  %框图的线宽估计值

innercontour = inner_Contour(graphic);                   %获得内轮廓
[candidateContours,num]=findallcontours(innercontour);   %找到所有候选图元
realcontours=findallrealcontours(candidateContours);     %所有图元
lines = findallLinesflowchart(graphic,realcontours,graphiclinewidth1);  %利用矩形掩膜找到图元

figure,imshow(lines);