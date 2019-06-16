clc;
clear all;
file_path='C:\Users\dell\Desktop\毕设2\形状\diamond\';
img_path_list=dir(strcat(file_path,'o*.png'));
img_num=length(img_path_list);
for pn=1:img_num
    image_name = img_path_list(pn).name;
    img_origin =  imread(strcat(file_path,image_name));
    I=rgb2gray(img_origin);
    I=imbinarize(I);
    b=bwboundaries(I);
    b=b{1};
    boundry=bound2im(b);
    [w,h]=size(boundry);
    boundrys=zeros(w+30,h+30);
    boundrys(16:w+15,16:h+15)=boundry;
    for i=1:10
        A=imresize(boundrys,1+0.2*i);
        A=myresize(A);
        imwrite(A,strcat('C:\Users\dell\Desktop\毕设2\形状\diamond\',[num2str((pn-1)*10+i),'.png']));
    end
end

