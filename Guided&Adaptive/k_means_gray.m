% clear;clc;close all;
% data=imread('11.jpg');
function J = k_means_gray(data,r)
[m,n,c]=size(data);
%����������
% disp('��������������')
% r=input('');
% figure;
% imshow(data)%ͨ��k_means������з��ࣨ����ͨ��ֵ����ֵ���л��֣�

%��ԭʼͼƬת��Ϊ�Ҷ�ͼƬ
% data = rgb2gray(data);

[mu,pattern]=k_mean_Seg(data,r);

for x=1:m
    for y=1:n
        %��һ�ࣨ��ֵ�ռ�С��
        if pattern(x,y,1)==1
            data(x,y) = 30;
        %�ڶ��ࣨ��ֵ�ռ��еȣ�
        elseif pattern(x,y,1)==2
            data(x,y) = 60;
        %������    
        elseif pattern(x,y,1)==3
            data(x,y) = 90;
        %������ 
        elseif pattern(x,y,1)==4
            data(x,y) = 120;
        %������     
        elseif pattern(x,y,1)==5
            data(x,y) = 150;
        %������ 
        elseif pattern(x,y,1)==6 
            data(x,y) = 180;
        %������     
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