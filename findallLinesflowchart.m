function lines = findallLinesflowchart(graphic,realcontours,graphiclinewidth1)

[h,w]=size(graphic);
C=zeros(h,w);
t=graphic;
for i=1:length(realcontours)
    B=imfill(realcontours{i},'holes');
    [r,c]=find(B==1);
    for x=1:size(r)
        C(r(x,1),c(x,1))=1;
    end
    [L,num]=bwlabel(B,8);
    boundingBox=regionprops(L,'BoundingBox');
    boundingBox=boundingBox.BoundingBox;
    x1=boundingBox(1,1)-2.5*graphiclinewidth1;
    y1=boundingBox(1,2)-2.5*graphiclinewidth1;
    width=boundingBox(1,3)+5*graphiclinewidth1;
    high=boundingBox(1,4)+5*graphiclinewidth1;
    x2=boundingBox(1,1)-2.5*graphiclinewidth1+width;
    y2=boundingBox(1,2)-2.5*graphiclinewidth1+high;
    boundingBoxT=[x1,y1,width,high];
    r=[x1,x1,x2,x2];
    c=[y1,y2,y2,y1];
    BW=roipoly(B,r,c);
    mask=BW;
    se=strel('disk',2);
    mask=imdilate(mask,se);
    [r,c]=find(mask==1);
    for x=1:size(r)
        t(r(x,1),c(x,1))=0;
    end
end
t = bwareaopen(t,40,8);
lines=t;
% B=imfill(realcontours{1},'holes');
% [r,c]=find(B==1);
% for x=1:size(r)
%     C(r(x,1),c(x,1))=1;
% end
% % figure,imshow(B);
% [L,num]=bwlabel(B,8);
% boundingBox=regionprops(L,'BoundingBox');
% boundingBox=boundingBox.BoundingBox;
% % rectangle('position',boundingBox,'edgecolor','r','LineWidth',1);%最小外接矩形，还需加上线宽
% x1=boundingBox(1,1)-1.8*graphiclinewidth1;
% y1=boundingBox(1,2)-1.8*graphiclinewidth1;
% width=boundingBox(1,3)+2*graphiclinewidth1*1.8;
% high=boundingBox(1,4)+2*graphiclinewidth1*1.8;
% x2=boundingBox(1,1)-1.8*graphiclinewidth1+width;
% y2=boundingBox(1,2)-1.8*graphiclinewidth1+high;
% boundingBoxT=[x1,y1,width,high];
% r=[x1,x1,x2,x2];
% c=[y1,y2,y2,y1];
% BW=roipoly(B,r,c);
% % figure,imshow(BW);
% mask=BW;  %用最小外接矩形+线宽作掩膜
% [r,c]=find(mask==1);
% t=graphic;
% for x=1:size(r)
%     t(r(x,1),c(x,1))=0;
% end
% figure,imshow(t);
% rectangle('position',boundingBoxT,'edgecolor','r','LineWidth',1);%最小外接矩形，已经加上线宽