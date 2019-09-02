clc; close all;
X = imread('ours4.png');
X = rgb2gray(X);
Z = imread('4.png');
Z = rgb2gray(Z);
% Y=X;
% Y = imnoise(Y, 'salt & pepper');%��ӽ���������Ҳ���Ըĳ���������
% A=fspecial('average',3); %����ϵͳԤ�����3X3�˲��� ?
% Z=filter2(A,Y)/255; %��ֵ�˲�

%Z=medfilt2(Y,[3,3]);%��ֵ�˲�
%A=fspecial('gaussian'); %��˹�˲������
%Z=filter2(A,Y)/255; ? %�����ɵĸ�˹���н����˲�
% figure;
% subplot(1, 3, 1); imshow(X); title('ԭͼ��');
% subplot(1, 3, 2); imshow(Y); title('������ͼ��');
% subplot(1, 3, 3); imshow(Z); title('�˲���ͼ��');

X = double(X); 
Z = double(Z); 

D = Z-X;
MSE = sum(D(:).*D(:))/numel(Z);%���������MSE
PSNR = 10*log10(255^2/MSE);%��ֵ�����
MAE=mean(mean(abs(D)));%ƽ���������

w = fspecial('gaussian', 11, 1.5); %window �Ӵ� ?
K(1) = 0.01; 
K(2) = 0.03; 
L = 255; 
Z = double(Z); 
X = double(X); 
C1 = (K(1)*L)^2; 
C2 = (K(2)*L)^2; 
w = w/sum(sum(w)); 
ua = filter2(w, Z, 'valid');%�Դ����ڲ�û�н���ƽ�������������˹����� ?
ub = filter2(w, X, 'valid'); % ���Ƽ�Ȩƽ�� ?
ua_sq = ua.*ua; 
ub_sq = ub.*ub; 
ua_ub = ua.*ub; 
siga_sq = filter2(w, Z.*Z, 'valid') - ua_sq; 
sigb_sq = filter2(w, X.*X, 'valid') - ub_sq; 
sigab = filter2(w, Z.*X, 'valid') - ua_ub; 
ssim_map = ((2*ua_ub + C1).*(2*sigab + C2))./((ua_sq + ub_sq + C1).*(siga_sq + sigb_sq + C2)); 
MSSIM = mean2(ssim_map); 

display(MSE);%���������MSE
display(PSNR);%��ֵ�����
display(MAE);%ƽ���������
display(MSSIM);%�ṹ������SSIM