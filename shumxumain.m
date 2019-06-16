clc;
clear all;
tic;
I=imread('2.jpg');                                      %读取原图
BW=preprocessing(I);                                     %预处理
graphic=textseparate(BW);                                %去字符
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);                   %对整个框图进行细化
innercontour = inner_Contour(graphic);                   %获得内轮廓
[candidateContours,num]=findallcontours(innercontour);   %找到所有候选图元
realcontours=findallrealcontours(candidateContours);     %所有图元
linesgraphic = findallLines(graphic,realcontours);       %连接线层
primitives=xor(graphic,linesgraphic);             %生成图元节点层

allprimitives=findAllprimitives(primitives);      %所有图元节点 标记
[everylines]=seperateLines(linesgraphic);                %单个连接线

[everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth);%找到每一条连接线的骨架点，并沿骨架点扫描得到每一ROI内像素点的和,保存所有的骨架线
[allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll); %估计箭头所在坐标
