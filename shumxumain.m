clc;
clear all;
tic;
I=imread('2.jpg');                                      %��ȡԭͼ
BW=preprocessing(I);                                     %Ԥ����
graphic=textseparate(BW);                                %ȥ�ַ�
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);                   %��������ͼ����ϸ��
innercontour = inner_Contour(graphic);                   %���������
[candidateContours,num]=findallcontours(innercontour);   %�ҵ����к�ѡͼԪ
realcontours=findallrealcontours(candidateContours);     %����ͼԪ
linesgraphic = findallLines(graphic,realcontours);       %�����߲�
primitives=xor(graphic,linesgraphic);             %����ͼԪ�ڵ��

allprimitives=findAllprimitives(primitives);      %����ͼԪ�ڵ� ���
[everylines]=seperateLines(linesgraphic);                %����������

[everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth);%�ҵ�ÿһ�������ߵĹǼܵ㣬���عǼܵ�ɨ��õ�ÿһROI�����ص�ĺ�,�������еĹǼ���
[allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll); %���Ƽ�ͷ��������
