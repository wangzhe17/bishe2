clc;
clear;
tic;
I=imread('my5.png');                                      %读取原图
BW=preprocessing(I);                                     %预处理
graphic=textseparate(BW);                                %去字符
% thinGraphic1=thin(graphic);
% thinGraphic=thinner(thinGraphic1);
innercontour = inner_Contour(graphic);                   %获得内轮廓
[candidateContours,num]=findallcontours(innercontour);   %找到所有候选图元
realcontours=findallrealcontours(candidateContours);     %所有图元

linesgraphic = findallLines(graphic,realcontours);       %连接线层


primitives=xor(graphic,linesgraphic);             %生成图元节点层
allprimitives=findAllprimitives(primitives);

[everylines]=seperateLines(linesgraphic);                %单个连接线
[seperateLinesGraphics,ids,jointpoints,linewidth]=LinesFromJointpointLines(everylines);%找到含有分支点的连接线以及对应编号id，将分支点断开
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids);   %生产成断开分支点后的连接线层
jointpointsNodes=xor(linesgraphic,allSeperateLinesGraphics); %分支点作为节点处理，生成分支点层
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
nodes=or(primitives,jointpointsNodes); %组和分支点与基本图元构成节点
allNodes=findAllNodes(nodes);




everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);                    %对新的连接线层进行标记，提取单个连接线
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes);                %建立数据结构，对所有节点分类标记。

relations=genRelations(allNodeInfo,everySeperateLines);

% filename='my5.mat';
% save(['C:\Users\dell\Desktop\毕设2\连接关系\',filename]);