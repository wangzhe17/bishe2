clc;
clear all;
N=95;
%%
D = dir('C:\Users\dell\Desktop\毕设2\形状\circle\*.mat');
data1 =[];
for i = 1:N
    load(['C:\Users\dell\Desktop\毕设2\形状\circle\',D(i).name]);
    a = data;
    data1 = [data1,a];
end
data1 = data1';    %圆形
save('data1.mat');
%%
D = dir('C:\Users\dell\Desktop\毕设2\形状\diamond\*.mat');
data2 = [];
for i = 1:N
    load(['C:\Users\dell\Desktop\毕设2\形状\diamond\',D(i).name]);
    a = data;
    data2 = [data2,a];   %菱形
end
data2 = data2';
save('data2.mat');
%%

D = dir('C:\Users\dell\Desktop\毕设2\形状\oval\*.mat');
data3 = [];
for i = 1:N
    load(['C:\Users\dell\Desktop\毕设2\形状\oval\',D(i).name]);
    a = data;
    data3 = [data3,a];   %椭圆形
end
data3 = data3';
save('data3.mat');
%%

D = dir('C:\Users\dell\Desktop\毕设2\形状\rectangle\*.mat');
data4 = [];
for i = 1:N
    load(['C:\Users\dell\Desktop\毕设2\形状\rectangle\',D(i).name]);
    a = data;
    data4 = [data4,a];   %矩形
end
data4 = data4';
save('data4.mat');
%%
% D = dir('C:\Users\dell\Desktop\毕设2\形状\triangle\*.mat');
% data5 = [];
% for i = 1:N
%     load(['C:\Users\dell\Desktop\毕设2\形状\triangle\',D(i).name]);
%     a = data;
%     data5 = [data5,a];   %三角形
% end
% data5 = data5';
% save('data5.mat');

%%
D = dir('C:\Users\dell\Desktop\毕设2\形状\circle\*.mat');
test1=[];
for i = 1:100
    load(['C:\Users\dell\Desktop\毕设2\形状\circle\',D(i).name]);
    a = data;
    test1 = [test1,a];            %圆形
end
D = dir('C:\Users\dell\Desktop\毕设2\形状\diamond\*.mat');
test2=[];
for i = 1:100
    load(['C:\Users\dell\Desktop\毕设2\形状\diamond\',D(i).name]);
    a = data;
    test2 = [test2,a];           %菱形
end
D = dir('C:\Users\dell\Desktop\毕设2\形状\oval\*.mat');
test3=[];
for i = 1:100
    load(['C:\Users\dell\Desktop\毕设2\形状\oval\',D(i).name]);
    a = data;
    test3 = [test3,a];            %椭圆
end
D = dir('C:\Users\dell\Desktop\毕设2\形状\rectangle\*.mat');
test4=[];
for i = 1:100
    load(['C:\Users\dell\Desktop\毕设2\形状\rectangle\',D(i).name]);
    a = data;
    test4 = [test4,a];           %矩形
end

%%
test=[test1,test2,test3,test4];
testing_instance_matrix=test';
testing_label_vector(1:100)=1;
testing_label_vector(101:200)=2;
testing_label_vector(201:300)=3;
testing_label_vector(301:400)=4;
testing_label_vector=testing_label_vector';

training_instance_matrix = [data1;data2;data3;data4];
group(1:95)=1;                    %圆形 
group(96:190)=2;                    %菱形
group(191:285)=3;                   %椭圆
group(286:380)=4;                   %矩形
training_label_vector=group';
%%
model=libsvmtrain(training_label_vector,training_instance_matrix,'-t 2');
save model;
[predicted_label, accuracy, decision_values] = svmpredict(testing_label_vector, testing_instance_matrix, model);