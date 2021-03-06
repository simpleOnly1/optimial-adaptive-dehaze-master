clc;
clear all;
close all;

J = imread('13.png');
J = double(J);
J = J ./255 ;
k = 3;
r = 15;
eps = 10^-3;
figure(1); imshow(J); 
%% 求暗通道图像 Jdark = min(min());

Jdark = Idark(J);
figure(2);imshow(Jdark,[]);

Jdark_kmeans = k_means_gray(Jdark.*255,k);
figure(3);imshow(Jdark_kmeans,[]);
%%
% 注意：何凯明使用了soft matting方法对得到的粗透射率Jt进行细化 
%       本代码采用梯度导向滤波实现

% 在图像恢复后进行天空区域平滑
[m,n,c] = size(Jdark);
% for x = 1:m
%     for y = 1:n
%         if Jdark_kmeans(x,y)
% %高斯滤波
%             gausFilter = fspecial('gaussian',5,1);
%             Jdark(x,y) = imfilter(Jdark(x,y),gausFilter,'replicate');
% %             J(x,y) = medfilt2(J(x,y),[5,5]);
% % %均值滤波
% %             w1 = fspecial('average',[5,5]);  
% %             J(x,y) = imfilter(J(x,y),w1,'replicate');
%         end
%     end
% end
% Jdark = gradient_guidedfilter(Jdark,Jdark, 0.04);
tic;
Jdark = fastguidedfilter(rgb2gray(J), Jdark, r, eps, r/4);
toc;
%% 大气物理模型 J = I*t + A*(1-t)  【直接衰减项】+【大气光照】
% 透射率 t与深度的关系 t=exp(-a*depth)
w = 0.95;         %雾的保留系数
Jt = 1 - w*Jdark; %求解透射率
figure(4);imshow(Jt,[]);

% %% 求解全局大气光照
% % 1.首先对输入的有雾图像I求解其暗通道图像Jdark。
% % 2.选择Jdark总像素点个数千分之一（N/1000）个最亮的像素点，记录像素点（x,y）坐标
% % 3.根据点的坐标分别在原图像J的三个通道（r,g,b）内找到这些像素点并加和得到（sum_r,sum_g,sum_b）.
% % 4.Ac=[Ar,Ag,Ab]. 其中Ar=sum_r/N;   Ag=sum_g/N;   Ab=sum_b/N.

a = estA(J, Jdark);

%% 求解清晰的图像
% 根据 J = I*t + A*(1-t)   I = (J-A)/Jt + A

I = J;
t0 = 0.1;
t1 = 0.9;
[h w c] = size(I);
J = zeros(h,w,c);
J(:,:,1) = I(:,:,1)-a(1);
J(:,:,2) = I(:,:,2)-a(2);
J(:,:,3) = I(:,:,3)-a(3);

t = Jt;
[th tw] = size(t);
for y=1:th
    for x=1:tw
        if ~Jdark_kmeans(y,x) && t(y,x)<t0
%         if t(y,x)<t0
            t(y,x)=t0;
        end
    end
end

for y=1:th
    for x=1:tw
        if t(y,x)>t1
            t(y,x)=t1;
        end
    end
end

J(:,:,1) = J(:,:,1)./t;
J(:,:,2) = J(:,:,2)./t;
J(:,:,3) = J(:,:,3)./t;

J(:,:,1) = J(:,:,1)+a(1);
J(:,:,2) = J(:,:,2)+a(2);
J(:,:,3) = J(:,:,3)+a(3);

% % 在图像恢复后进行天空区域平滑
% [m,n,c] = size(Jdark);
% for x = 1:m
%     for y = 1:n
%         if ~Jdark_kmeans(x,y)
% %高斯滤波
%             gausFilter = fspecial('gaussian',5,1);
%             J(x,y) = imfilter(J(x,y),gausFilter,'replicate');
% %             J(x,y) = medfilt2(J(x,y),[5,5]);
% % %均值滤波
% %             w1 = fspecial('average',[5,5]);  
% %             J(x,y) = imfilter(J(x,y),w1,'replicate');
%         end
%     end
% end

% J = adjustimage(J*255, 1.3, 10, Jdark_kmeans);
figure(5); imshow(J);
