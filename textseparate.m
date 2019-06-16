function graphic = textseparate(BW)
[L,num]=bwlabel(BW,8);
for i=1:num
    [r,c]=find(L==i);
    for x=1:size(r)
       COPY(r(x,1),c(x,1))=1; 
    end
    sumi=sum(COPY(:));
    sums(i,1)=sumi;
end
maxs=max(sums);                    %计算所有连通域的最大值
u=round(0.05*maxs);                %系数取0.05
graphic = bwareaopen(BW,u,8);