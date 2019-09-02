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
%% ��ͨ��ͼ�� Jdark = min(min());

Jdark = Idark(J);
figure(2);imshow(Jdark,[]);

Jdark_kmeans = k_means_gray(Jdark.*255,k);
figure(3);imshow(Jdark_kmeans,[]);
%%
% ע�⣺�ο���ʹ����soft matting�����Եõ��Ĵ�͸����Jt����ϸ�� 
%       ����������ݶȵ����˲�ʵ��

% ��ͼ��ָ�������������ƽ��
[m,n,c] = size(Jdark);
% for x = 1:m
%     for y = 1:n
%         if Jdark_kmeans(x,y)
% %��˹�˲�
%             gausFilter = fspecial('gaussian',5,1);
%             Jdark(x,y) = imfilter(Jdark(x,y),gausFilter,'replicate');
% %             J(x,y) = medfilt2(J(x,y),[5,5]);
% % %��ֵ�˲�
% %             w1 = fspecial('average',[5,5]);  
% %             J(x,y) = imfilter(J(x,y),w1,'replicate');
%         end
%     end
% end
% Jdark = gradient_guidedfilter(Jdark,Jdark, 0.04);
tic;
Jdark = fastguidedfilter(rgb2gray(J), Jdark, r, eps, r/4);
toc;
%% ��������ģ�� J = I*t + A*(1-t)  ��ֱ��˥���+���������ա�
% ͸���� t����ȵĹ�ϵ t=exp(-a*depth)
w = 0.95;         %���ı���ϵ��
Jt = 1 - w*Jdark; %���͸����
figure(4);imshow(Jt,[]);

% %% ���ȫ�ִ�������
% % 1.���ȶ����������ͼ��I����䰵ͨ��ͼ��Jdark��
% % 2.ѡ��Jdark�����ص����ǧ��֮һ��N/1000�������������ص㣬��¼���ص㣨x,y������
% % 3.���ݵ������ֱ���ԭͼ��J������ͨ����r,g,b�����ҵ���Щ���ص㲢�Ӻ͵õ���sum_r,sum_g,sum_b��.
% % 4.Ac=[Ar,Ag,Ab]. ����Ar=sum_r/N;   Ag=sum_g/N;   Ab=sum_b/N.

a = estA(J, Jdark);

%% ���������ͼ��
% ���� J = I*t + A*(1-t)   I = (J-A)/Jt + A

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

% % ��ͼ��ָ�������������ƽ��
% [m,n,c] = size(Jdark);
% for x = 1:m
%     for y = 1:n
%         if ~Jdark_kmeans(x,y)
% %��˹�˲�
%             gausFilter = fspecial('gaussian',5,1);
%             J(x,y) = imfilter(J(x,y),gausFilter,'replicate');
% %             J(x,y) = medfilt2(J(x,y),[5,5]);
% % %��ֵ�˲�
% %             w1 = fspecial('average',[5,5]);  
% %             J(x,y) = imfilter(J(x,y),w1,'replicate');
%         end
%     end
% end

% J = adjustimage(J*255, 1.3, 10, Jdark_kmeans);
figure(5); imshow(J);