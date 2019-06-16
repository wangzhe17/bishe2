function [boundry,M]=myresize2(A1)
b = bwboundaries(A1);
b = b{1};
boundry=bound2im(b);
boundry=myresize(boundry);
[w,h]=size(boundry);
A1=zeros(w+16,h+16);
A1(9:w+8,9:h+8)=boundry;


boundry=imresize(A1,[300,300]);
% figure,imshow(boundry);
b2=bwboundaries(boundry);
b2=b2{1};
boundry2=bound2im(b2);
% figure,imshow(boundry2);
boundry2=myresize(boundry2);
[w,h]=size(boundry2);
A=zeros(w+40,h+40);
A(21:w+20,21:h+20)=boundry2;
A=imresize(A,[150,150]);
% figure,imshow(A);
M=A;