close all;
clear all;
clc;
I=imread('4.png');
J=imread('ours4.png');
[m,n,c]=size(I);
img=double(I);
imgn=double(J);
b=8;            %����һ�������ö��ٶ�����λ
MAX=2^b-1;      %ͼ���ж��ٻҶȼ�
MSE=sum(sum((I(:,:,1)-J(:,:,1)).^2+(I(:,:,2)-J(:,:,2)).^2+(I(:,:,3)-J(:,:,3)).^2))/(m*n*c); %�������
PSNR=20*log10(MAX/sqrt(MSE));      %��ֵ����� 