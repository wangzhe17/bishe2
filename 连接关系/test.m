clc
clear
load my5;
% node1=allNodes{1};
% node4=allNodes{4};
% line1=everySeperateLines{1};
% se1=strel('disk',1);
% node1=imdilate(node1,se1);
% node4=imdilate(node4,se1);
% line1=imdilate(line1,se1);
% all=or(or(node1,node4),line1);
% [A,node1]=zhang(~node1);
% [A,node4]=zhang(~node4);
% [A,line1]=zhang(~line1);
% [A,all]=zhang(~all);
% figure,imshow(~node1);
% figure,imshow(~node4);
% figure,imshow(~line1);
% figure,imshow(~all);
% all=~all;
% jointpoints1=findjointpoints(all);
% line1=~line1;
% figure,imshow(line1);
% hold on;
% point1=jointpoints1{1};
% x1=point1(1,2);
% y1=point1(1,1);
% plot(y1,x1,'+');
% point2=jointpoints1{2};
% x2=point2(1,2);
% y2=point2(1,1);

relation1=relations{1};
for i=1:length(allNodeInfo)
    idA=relation1.idA;
    if i~=idA
        continue;
    end
    if i==idA
        node1=allNodeInfo{idA};
    end
    node1Image=node1.image;
end
for i=1:length(allNodeInfo)
    idB=relation1.idB;
    if i~=idB
        continue;
    end
    if i==idB
        node2=allNodeInfo{idB};
    end
    node2Image=node2.image;
end
for i=1:length(everySeperateLines)
    idline=relation1.idline;
    if i~=idline
        continue;
    end
    if idline==i
        line=everySeperateLines{i};
    end
end
se1=strel('disk',1);
node1Image=imdilate(node1Image,se1);
node2Image=imdilate(node2Image,se1);
line=imdilate(line,se1);
all=or(node1Image,line);
[A,node1Image]=zhang(~node1Image);
[A,node2Image]=zhang(~node2Image);
[A,line]=zhang(~line);
[A,all]=zhang(~all);
node1Image=~node1Image;
node2Image=~node2Image;
line=~line;
all=~all;
figure,imshow(line);
jointpoints1=findjointpoints(all);
endpoints=findAllendPoints(line);

point1=endpoints{1};
point2=endpoints{2};
point3=jointpoints1{1};
dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);
dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);
if dis1<dis2 %若dis1比dis2小 则point1离point3更近，即端点point1与分支点更近，端点point1与图元node1相连
    %加入信息，即图元node1与端点point1其相连
elseif dis1>dis2
    %加入信息，即图元node2与端点point1其相连
end
    