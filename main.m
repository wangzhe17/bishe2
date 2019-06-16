clc;
clear all;
tic;
I=imread('208.png');                                      %读取原图
BW=preprocessing(I);                                     %预处理
graphic=textseparate(BW);                                %去字符
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);                   %对整个框图进行细化
thinGraphic=~thinGraphic;

% figure,imshow(thinGraphic);
allEndPoints=findAllendPoints(thinGraphic);

innercontour = inner_Contour(graphic);                   %获得内轮廓
[candidateContours,num]=findallcontours(innercontour);   %找到所有候选图元
realcontours=findallrealcontours(candidateContours);     %所有图元
linesgraphic = findallLines(graphic,realcontours);       %连接线层
% figure,imshow(linesgraphic);
% hold on;
primitives=xor(graphic,linesgraphic);             %生成图元节点层
allprimitives=findAllprimitives(primitives);      %所有图元节点 标记
[everylines]=seperateLines(linesgraphic);                %单个连接线
[seperateLinesGraphics,ids,jointpoints,linewidth]=LinesFromJointpointLines(everylines);%找到含有分支点的连接线以及对应编号id，将分支点断开
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids);   %生产成断开分支点后的连接线层
figure,imshow(allSeperateLinesGraphics);

hold on;
jointpointsNodes=xor(linesgraphic,allSeperateLinesGraphics); %分支点作为节点处理，生成分支点层
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
nodes=or(primitives,jointpointsNodes); %组和分支点与基本图元构成节点
% figure,imshow(nodes);
allNodes=findAllNodes(nodes);
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes);                %建立数据结构，对所有节点分类标记。

everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);                    %对新的连接线层进行标记，提取单个连接线
[everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth);%找到每一条连接线的骨架点，并沿骨架点扫描得到每一ROI内像素点的和,保存所有的骨架线
[allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll); %估计箭头所在坐标

AllSkeletonLines=combineAllSkeletonLines(everySkeletonLines);   %所有骨架分支的组合
[allArrowImages,allArrowSkeletonImages]=findAllArrowImages(allArrowPoints,linesgraphic,linewidth,AllSkeletonLines);  %提取所有箭头与箭头骨架线
allLineInfo=genAllLineInfo(everySeperateLines,allArrowPoints,allArrowImages);
% figure,imshow(AllSkeletonLines);
% hold on;
for i=1:length(allArrowPoints)
    ArrowPoint=allArrowPoints{i};
    if ~isempty(ArrowPoint)
        plot(ArrowPoint(1,2),ArrowPoint(1,1),'+');
        x=ArrowPoint(1,2)-2*linewidth;
        y=ArrowPoint(1,1)-2*linewidth;
        rectangle('Position',[x,y,4.5*linewidth,4.5*linewidth],'EdgeColor','r','LineWidth',3);
    end
end

toc;

% for i=1:length(allArrowImages)
%     arrow=allArrowImages{i};
%     if isempty(arrow)
%         continue;
%     end
%     imwrite(arrow,strcat('C:\Users\dell\Desktop\箭头集\c',num2str(i),'.png'));
% end

% filename='my5.mat';
% save(['C:\Users\dell\Desktop\毕设2\data\',filename]);
