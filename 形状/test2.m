clc;
clear all;
I=imread('23.png');
b=boundaries(I);
U=b{1};
X=U(:,1);
Y=U(:,2);
z=complex(X,Y);
FD=fft(z);
F=abs(FD);
FD(1)=0;
FD=FD/abs(FD(2));

figure,plot(F);