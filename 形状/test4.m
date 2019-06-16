clc;
clear all;
I = imread('C:\Users\dell\Desktop\±ÏÉè2\ÐÎ×´\rectangle\16.png');
im = imbinarize(I);
b = bwboundaries(im);
boundary = b{1};
np=length(boundary);
s=sum(boundary,1);
x=s(1,2)./np;
y=s(1,1)./np;
d=sqrt((boundary(:,2)-x).^2+(boundary(:,1)-y).^2);
x=1:np;
y=d;
N=100;
xi=linspace(1,np,N);
yi=spline(x,y,xi);
xii=(0:N-1);
yii=yi;
figure,plot(xii,yii);
hold on;
set(gca,'XLim',[0 length(xii)]);
set(gca,'YLim',[0 max(y)+30]);





fd=fft(yii,N);
% fd(1)=0;
fd=fd./abs(fd(1));
z=abs(fd);
figure,plot(z);
hold on;
% v=fd(2:31);
% 
% v=v';
% data=[real(v);imag(v)];
