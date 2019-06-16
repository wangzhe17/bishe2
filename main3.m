clc;
clear;
tic;
I=imread('my5.png');                                      %��ȡԭͼ
BW=preprocessing(I);                                     %Ԥ����
graphic=textseparate(BW);                                %ȥ�ַ�
% thinGraphic1=thin(graphic);
% thinGraphic=thinner(thinGraphic1);
innercontour = inner_Contour(graphic);                   %���������
[candidateContours,num]=findallcontours(innercontour);   %�ҵ����к�ѡͼԪ
realcontours=findallrealcontours(candidateContours);     %����ͼԪ

linesgraphic = findallLines(graphic,realcontours);       %�����߲�


primitives=xor(graphic,linesgraphic);             %����ͼԪ�ڵ��
allprimitives=findAllprimitives(primitives);

[everylines]=seperateLines(linesgraphic);                %����������
[seperateLinesGraphics,ids,jointpoints,linewidth]=LinesFromJointpointLines(everylines);%�ҵ����з�֧����������Լ���Ӧ���id������֧��Ͽ�
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids);   %�����ɶϿ���֧���������߲�
jointpointsNodes=xor(linesgraphic,allSeperateLinesGraphics); %��֧����Ϊ�ڵ㴦�����ɷ�֧���
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
nodes=or(primitives,jointpointsNodes); %��ͷ�֧�������ͼԪ���ɽڵ�
allNodes=findAllNodes(nodes);




everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);                    %���µ������߲���б�ǣ���ȡ����������
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes);                %�������ݽṹ�������нڵ�����ǡ�

relations=genRelations(allNodeInfo,everySeperateLines);

% filename='my5.mat';
% save(['C:\Users\dell\Desktop\����2\���ӹ�ϵ\',filename]);