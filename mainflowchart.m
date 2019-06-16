clc;
clear;
tic;
I=imread('my5.png');                                      %��ȡԭͼ
BW=preprocessing(I);                                     %Ԥ����
graphic=textseparate(BW);                                %ȥ�ַ�
% figure,imshow(graphic);
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);
figure,imshow(thinGraphic);

innercontour = inner_Contour(graphic);                   %���������
[candidateContours,num]=findallcontours(innercontour);   %�ҵ����к�ѡͼԪ
realcontours=findallrealcontours(candidateContours);     %����ͼԪ

linesgraphic = findallLines(graphic,realcontours);       %�����߲�
% figure,imshow(linesgraphic);
% figure,imshow(graphic);
primitives=xor(graphic,linesgraphic);             %����ͼԪ�ڵ��
allprimitives=findAllprimitives(primitives);
% figure,imshow(primitives);
[everylines]=seperateLines(linesgraphic);                %����������

[seperateLinesGraphics,ids,jointpoints,linewidth]=LinesFromJointpointLines(everylines);%�ҵ����з�֧����������Լ���Ӧ���id������֧��Ͽ�
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids);   %�����ɶϿ���֧���������߲�
% figure,imshow(allSeperateLinesGraphics);
jointpointsNodes=xor(linesgraphic,allSeperateLinesGraphics); %��֧����Ϊ�ڵ㴦�����ɷ�֧���
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
% figure,imshow(jointpointsNode);
nodes=or(primitives,jointpointsNodes); %��ͷ�֧�������ͼԪ���ɽڵ�
allNodes=findAllNodes(nodes);

% figure,imshow(nodes);


everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);                    %���µ������߲���б�ǣ���ȡ����������
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes);                %�������ݽṹ�������нڵ�����ǡ�
