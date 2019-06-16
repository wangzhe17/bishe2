function [point1,point2,max_len] = HoughLineDetection( input_pic)

%UNTITLED2 此处显示有关此函数的摘要
%利用hough变换进行图像块的直线检测
%   此处显示详细说明
%% input:二值化图像
%% output：最长直线的x,y坐标，及最长直线的长度
%%

[H, theta , rho] = hough (input_pic,'RhoResolution',1,'Theta',-90:0.2:89.5);
P = houghpeaks(H,1,'threshold',ceil(0.95*max(H(:))));
lines = houghlines(input_pic,theta,rho,P,'FillGap',10,'MinLength',10);
max_len  = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
point1=xy_long(1,:);
point2=xy_long(2,:);


end

