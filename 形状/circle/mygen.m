clc;
clear all;
file_path='C:\Users\dell\Desktop\±ÏÉè2\ÐÎ×´\circle\';
img_path_list=dir(strcat(file_path,'*.png'));
img_num=length(img_path_list);
for pn=1:img_num
    image_name = img_path_list(pn).name;
    img_origin =  imread(strcat(file_path,image_name));
    I=img_origin;
    I=imbinarize(I);
    b=bwboundaries(I);
    b=b{1};
    boundry=bound2im(b);
    [w,h]=size(boundry);
    boundrys=zeros(w+30,h+30);
    boundrys(16:w+15,16:h+15)=boundry;
    A=myresize(boundrys);
    imwrite(A,image_name);
end

