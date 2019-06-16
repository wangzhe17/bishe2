function [boundry,M]=myresize1(A1)
b = bwboundaries(A1);
b = b{1};
boundry=bound2im(b);
[w,h]=size(boundry);
A=zeros(w+30,h+30);
A(16:w+15,16:h+15)=boundry;
[w,h]=size(A);
if w>h
    d=w-h;
    h1=h+d;
    w1=w;
    im1=zeros(w1,h1);
    im1(1:w1,d/2+1:h1-d/2)=A(1:w,1:h);
end
if w<h
    d=h-w;
    w1=w+d;
    h1=h;
    im1=zeros(w1,h1);
    im1(d/2+1:w1-d/2,1:h1)=A(1:w,1:h);
end
if w==h
    im1=A;
end
im1=imresize(im1,[300,300]);
im1=imbinarize(im1);
M=im1;
