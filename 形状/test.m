clc;
clear all;
I1 = imread('12.png');
I2=imresize(I1,2);
im1 = im2bw(I1);
im2 = im2bw(I2);
b1 = bwboundaries(im1);
b2 = bwboundaries(im2);
boundary1 = b1{1};
boundary2 = b2{1};
s1 = boundary1(:, 1) + 1j*boundary1(:, 2);
s2 = boundary2(:, 1) + 1j*boundary2(:, 2);
descriptors1 = fft(s1);
descriptors2 = fft(s2);
descriptors1(1)=0;
descriptors2(1)=0;
np1=length(descriptors1);
np2=length(descriptors2);
descriptors1=descriptors1./abs(descriptors1(2));
descriptors2=descriptors2./abs(descriptors2(2));
descriptors1(50:np1)=0;
descriptors2(50:np2)=0;
ss1=ifft(descriptors1);
ss2=ifft(descriptors2);
descriptors1=abs(descriptors1);
descriptors2=abs(descriptors2);
figure,plot(descriptors1);
figure,plot(descriptors2);
sss1(:, 1)=real(ss1);
% sss(:, 1)=sss(:, 1)*1000;
sss1(:, 2)=imag(ss1);
% sss(:, 2)=sss(:, 2)*1000;
sss2(:, 1)=real(ss2);
% sss(:, 1)=sss(:, 1)*1000;
sss2(:, 2)=imag(ss2);
% sss(:, 2)=sss(:, 2)*1000;
bb1=bound2im(sss2);
% figure,imshow(bb1);

