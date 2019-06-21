clc;
clear;
tic;
I=imread('my7.png');                                      %��ȡԭͼ
BW=preprocessing(I);                                     %Ԥ����
graphic=textseparate(BW);                                %ȥ�ַ�
flowchartThin=thinFlowchart(graphic); 
graphiclinewidth1=calculateGraphiclinewidth(graphic,flowchartThin);  %��ͼ���߿����ֵ

innercontour = inner_Contour(graphic);                   %���������
[candidateContours,num]=findallcontours(innercontour);   %�ҵ����к�ѡͼԪ
realcontours=findallrealcontours(candidateContours);     %����ͼԪ
lines = findallLinesflowchart(graphic,realcontours,graphiclinewidth1);  %���þ�����Ĥ�ҵ�ͼԪ

figure,imshow(lines);