clc;
clear;
load my5;

relation1=relations{8};
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
if strcmp(node1.type,'primitive')&strcmp(node2.type,'primitive')  %两个节点都是图元的情况
    se1=strel('disk',1);
    node1Image=imdilate(node1Image,se1);
    node2Image=imdilate(node2Image,se1);
    line=imdilate(line,se1);
    all=or(node1Image,line);
    [A,node1Image]=zhang(~node1Image);
    [A,line]=zhang(~line);
    [A,all]=zhang(~all);
    line=~line;
    all=~all;
    jointpoints1=findjointpoints(all);
    endpoints=findAllendPoints(line);
    point1=endpoints{1};
    point2=endpoints{2};
    point3=jointpoints1{1};
    dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);  
    dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);  %图元连接点与两个端点的距离
end


if (strcmp(node1.type,'primitive')&strcmp(node2.type,'jointpoint')) | (strcmp(node1.type,'jointpoint')&strcmp(node2.type,'primitive')) %两个节点中一个是图元，一个是分支点
    if strcmp(node1.type,'primitive')
        se1=strel('disk',1);
        node1Image=imdilate(node1Image,se1);
        line=imdilate(line,se1);
        all=or(node1Image,line);
        [A,node1Image]=zhang(~node1Image);
        [A,line]=zhang(~line);
        [A,all]=zhang(~all);
        line=~line;
        all=~all;
        jointpoints1=findjointpoints(all);
        endpoints=findAllendPoints(line);
        point1=endpoints{1};
        point2=endpoints{2};
        point3=jointpoints1{1};
        dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);  
        dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);  %图元连接点与两个端点的距离
    else
        se1=strel('disk',1);
        node2Image=imdilate(node2Image,se1);
        line=imdilate(line,se1);
        all=or(node2Image,line);
        [A,node2Image]=zhang(~node2Image);
        [A,line]=zhang(~line);
        [A,all]=zhang(~all);
        line=~line;
        all=~all;
        jointpoints1=findjointpoints(all);
        endpoints=findAllendPoints(line);
        point1=endpoints{1};
        point2=endpoints{2};
        point3=jointpoints1{1};
        dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);  
        dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);  %图元连接点与两个端点的距离
    end
end

if strcmp(node1.type,'jointpoint')&strcmp(node2.type,'jointpoint')  %两个节点都是虚拟节点的情况
    se1=strel('disk',1);
    node1centroid=node1.centroid;
    line=imdilate(line,se1);
    [A,line]=zhang(~line);
    line=~line;
    endpoints=findAllendPoints(line);
    point1=endpoints{1};
    point2=endpoints{2};
    dis1=sqrt((point1(1,1)-node1centroid(1,1))^2+(point1(1,2)-node1centroid(1,2))^2);  
    dis2=sqrt((point2(1,1)-node1centroid(1,1))^2+(point2(1,2)-node1centroid(1,2))^2);  %图元连接点与两个端点的距离
    
end