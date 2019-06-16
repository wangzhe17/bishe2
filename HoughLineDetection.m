function [point1,point2,max_len] = HoughLineDetection( input_pic)

%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%����hough�任����ͼ����ֱ�߼��
%   �˴���ʾ��ϸ˵��
%% input:��ֵ��ͼ��
%% output���ֱ�ߵ�x,y���꣬���ֱ�ߵĳ���
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

