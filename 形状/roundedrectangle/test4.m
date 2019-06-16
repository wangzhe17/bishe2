clc;
clear all;
file_path='C:\Users\dell\Desktop\±ÏÉè2\ĞÎ×´\circle\';
img_path_list=dir(strcat(file_path,'*.png'));
img_num=length(img_path_list)
for pn=1:img_num
    image_name = img_path_list(pn).name;
    img_origin =  imread(strcat(file_path,image_name));
    im = imbinarize(img_origin);
    b = bwboundaries(im);
    boundary = b{1};
    np=length(boundary);
    s=sum(boundary,1);
    x=s(1,2)./np;
    y=s(1,1)./np;
    d=sqrt((boundary(:,2)-x).^2+(boundary(:,1)-y).^2);
    x=1:np;
    y=d;
    N=300;
    xi=linspace(1,np,N);
    yi=spline(x,y,xi);
    xii=(0:N-1);
    yii=yi;
    fd=fft(yii,N);
    fd(1)=0;
    fd=fd./abs(fd(2));
    v=fd(2:101);
    v=v';
    data=[real(v);imag(v)];
    filename=[num2str(pn) '.mat'];
    save(filename,'data');
end