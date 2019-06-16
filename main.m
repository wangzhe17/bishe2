clc;
clear all;
tic;
I=imread('208.png');                                      %��ȡԭͼ
BW=preprocessing(I);                                     %Ԥ����
graphic=textseparate(BW);                                %ȥ�ַ�
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);                   %��������ͼ����ϸ��
thinGraphic=~thinGraphic;

% figure,imshow(thinGraphic);
allEndPoints=findAllendPoints(thinGraphic);

innercontour = inner_Contour(graphic);                   %���������
[candidateContours,num]=findallcontours(innercontour);   %�ҵ����к�ѡͼԪ
realcontours=findallrealcontours(candidateContours);     %����ͼԪ
linesgraphic = findallLines(graphic,realcontours);       %�����߲�
% figure,imshow(linesgraphic);
% hold on;
primitives=xor(graphic,linesgraphic);             %����ͼԪ�ڵ��
allprimitives=findAllprimitives(primitives);      %����ͼԪ�ڵ� ���
[everylines]=seperateLines(linesgraphic);                %����������
[seperateLinesGraphics,ids,jointpoints,linewidth]=LinesFromJointpointLines(everylines);%�ҵ����з�֧����������Լ���Ӧ���id������֧��Ͽ�
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids);   %�����ɶϿ���֧���������߲�
figure,imshow(allSeperateLinesGraphics);

hold on;
jointpointsNodes=xor(linesgraphic,allSeperateLinesGraphics); %��֧����Ϊ�ڵ㴦�����ɷ�֧���
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
nodes=or(primitives,jointpointsNodes); %��ͷ�֧�������ͼԪ���ɽڵ�
% figure,imshow(nodes);
allNodes=findAllNodes(nodes);
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes);                %�������ݽṹ�������нڵ�����ǡ�

everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);                    %���µ������߲���б�ǣ���ȡ����������
[everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth);%�ҵ�ÿһ�������ߵĹǼܵ㣬���عǼܵ�ɨ��õ�ÿһROI�����ص�ĺ�,�������еĹǼ���
[allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll); %���Ƽ�ͷ��������

AllSkeletonLines=combineAllSkeletonLines(everySkeletonLines);   %���йǼܷ�֧�����
[allArrowImages,allArrowSkeletonImages]=findAllArrowImages(allArrowPoints,linesgraphic,linewidth,AllSkeletonLines);  %��ȡ���м�ͷ���ͷ�Ǽ���
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
%     imwrite(arrow,strcat('C:\Users\dell\Desktop\��ͷ��\c',num2str(i),'.png'));
% end

% filename='my5.mat';
% save(['C:\Users\dell\Desktop\����2\data\',filename]);
