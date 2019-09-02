% clear;clc;close all;
function [J data] = k_means(I , r)
% data=imread('4.jpg');
data=I;
[m,n,c]=size(data);
%����������
% disp('��������������')
% r=input('');
% imshow(data)
% ͨ��k_means������з��ࣨ����ͨ��ֵ����ֵ���л��֣�
[mu,pattern]=k_mean_Seg(data,r);

for x=1:m
    for y=1:n
        %��һ�ࣨ��ֵ�ռ�С��
        if pattern(x,y,1)==1
            data(x,y,1)=0;
            data(x,y,2)=0;
            data(x,y,3)=255;
        %�ڶ��ࣨ��ֵ�ռ��еȣ�
        elseif pattern(x,y,1)==2
            data(x,y,1)=0;
            data(x,y,2)=255;
            data(x,y,3)=0;
        %������    
        elseif pattern(x,y,1)==3
            data(x,y,1)=255;
            data(x,y,2)=0;
            data(x,y,3)=0;
        %������ 
        elseif pattern(x,y,1)==4
            data(x,y,1)=255;
            data(x,y,2)=255;
            data(x,y,3)=0;
        %������     
        elseif pattern(x,y,1)==5 
            data(x,y,1)=0;
            data(x,y,2)=255;
            data(x,y,3)=255; 
        %������ 
        elseif pattern(x,y,1)==6 
            data(x,y,1)=255;
            data(x,y,2)=0;
            data(x,y,3)=255; 
        %������     
        else  
            data(x,y,1)=255;
            data(x,y,2)=255;
            data(x,y,3)=255; 
        end
    end
end

t = data(:);
w = pattern(:);
J=ones(m,n,3);
for i=1:m*n
    if(w(i,1) == r)            
        c = [t(i), t(i+m*n), t(i+2*m*n)];
        break;
    end
end

for x=1:m
    for y=1:n
        if ((data(x,y,1)==c(1))&&(data(x,y,2)==c(2))&&data(x,y,3)==c(3))
            J(x,y,:)=data(x,y,:);
        end
    end
end

% figure;
% imshow(data); 
% figure;
% imshow(J);
end
 

  