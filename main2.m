clc;
clear all;
tic;
I=imread('C:\Users\dell\Desktop\��ͼ��\11.png');                                      %��ȡԭͼ
BW=preprocessing(I);                                     %Ԥ����
% figure,imshow(BW);
graphic=textseparate(BW);                                %ȥ�ַ�
% figure,imshow(graphic);
innercontour = inner_Contour(graphic);                   %���������
% figure,imshow(innercontour);












[candidateContours,num]=findallcontours(innercontour);   %�ҵ����к�ѡͼԪ
realcontours=findallrealcontours(candidateContours);     %����ͼԪ
A=realcontours{6};
[boundry,A]=myresize2(A);
A=imbinarize(A);
figure,imshow(A);












% imwrite(A,'C:\Users\dell\Desktop\test\Բ\10.png');
% imwrite(A,'C:\Users\dell\Desktop\test\����\11.png');
% imwrite(A,'C:\Users\dell\Desktop\test\ƽ���ı���\10.png');
% imwrite(A,'C:\Users\dell\Desktop\test\����\1.png');
% imwrite(A,'C:\Users\dell\Desktop\test\Բ�Ǿ���\10.png');
% imwrite(A,'C:\Users\dell\Desktop\test\������\11.png');
% imwrite(A,'C:\Users\dell\Desktop\test\��Բ\4.png');
% imwrite(A,'C:\Users\dell\Desktop\test\������\10.png');
toc;
