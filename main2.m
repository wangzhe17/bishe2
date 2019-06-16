clc;
clear all;
tic;
I=imread('C:\Users\dell\Desktop\框图集\11.png');                                      %读取原图
BW=preprocessing(I);                                     %预处理
% figure,imshow(BW);
graphic=textseparate(BW);                                %去字符
% figure,imshow(graphic);
innercontour = inner_Contour(graphic);                   %获得内轮廓
% figure,imshow(innercontour);












[candidateContours,num]=findallcontours(innercontour);   %找到所有候选图元
realcontours=findallrealcontours(candidateContours);     %所有图元
A=realcontours{6};
[boundry,A]=myresize2(A);
A=imbinarize(A);
figure,imshow(A);












% imwrite(A,'C:\Users\dell\Desktop\test\圆\10.png');
% imwrite(A,'C:\Users\dell\Desktop\test\矩形\11.png');
% imwrite(A,'C:\Users\dell\Desktop\test\平行四边形\10.png');
% imwrite(A,'C:\Users\dell\Desktop\test\菱形\1.png');
% imwrite(A,'C:\Users\dell\Desktop\test\圆角矩形\10.png');
% imwrite(A,'C:\Users\dell\Desktop\test\六边形\11.png');
% imwrite(A,'C:\Users\dell\Desktop\test\椭圆\4.png');
% imwrite(A,'C:\Users\dell\Desktop\test\三角形\10.png');
toc;
