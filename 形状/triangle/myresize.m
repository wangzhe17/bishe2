function [im]=myresize(A)
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
im1=imresize(im1,[350,350]);
im=im1;

