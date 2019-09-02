% clear;clc;close all;
% data=imread('11.jpg');
function J = k_means_gray(data,r)
[m,n,c]=size(data);
%输入聚类个数
% disp('请输入聚类个数：')
% r=input('');
% figure;
% imshow(data)%通过k_means聚类进行分类（根据通道值的域值进行划分）

%将原始图片转换为灰度图片
% data = rgb2gray(data);

[mu,pattern]=k_mean_Seg(data,r);

for x=1:m
    for y=1:n
        %第一类（域值空间小）
        if pattern(x,y,1)==1
            data(x,y) = 30;
        %第二类（域值空间中等）
        elseif pattern(x,y,1)==2
            data(x,y) = 60;
        %第三类    
        elseif pattern(x,y,1)==3
            data(x,y) = 90;
        %第四类 
        elseif pattern(x,y,1)==4
            data(x,y) = 120;
        %第五类     
        elseif pattern(x,y,1)==5
            data(x,y) = 150;
        %第六类 
        elseif pattern(x,y,1)==6 
            data(x,y) = 180;
        %第七类     
        else  
            data(x,y) = 210;
        end
    end
end

t = data(:);
w = pattern(:);
J=ones(m,n);
for i=1:m*n
    if(w(i,1) == r)
        c = t(i);
        break;
    end
end

for x=1:m
    for y=1:n
        if data(x,y)==c(1)
            J(x,y) = 0;
        end
    end
end

% figure;
% imshow(data); 
% figure;
% imshow(J);