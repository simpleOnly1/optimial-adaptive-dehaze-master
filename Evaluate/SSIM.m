clc; close all;
X = imread('ours4.png');
X = rgb2gray(X);
Z = imread('4.png');
Z = rgb2gray(Z);
% Y=X;
% Y = imnoise(Y, 'salt & pepper');%添加椒盐噪声，也可以改成其他噪声
% A=fspecial('average',3); %生成系统预定义的3X3滤波器 ?
% Z=filter2(A,Y)/255; %均值滤波

%Z=medfilt2(Y,[3,3]);%中值滤波
%A=fspecial('gaussian'); %高斯滤波卷积核
%Z=filter2(A,Y)/255; ? %用生成的高斯序列进行滤波
% figure;
% subplot(1, 3, 1); imshow(X); title('原图像');
% subplot(1, 3, 2); imshow(Y); title('加噪声图像');
% subplot(1, 3, 3); imshow(Z); title('滤波后图像');

X = double(X); 
Z = double(Z); 

D = Z-X;
MSE = sum(D(:).*D(:))/numel(Z);%均方根误差MSE
PSNR = 10*log10(255^2/MSE);%峰值信噪比
MAE=mean(mean(abs(D)));%平均绝对误差

w = fspecial('gaussian', 11, 1.5); %window 加窗 ?
K(1) = 0.01; 
K(2) = 0.03; 
L = 255; 
Z = double(Z); 
X = double(X); 
C1 = (K(1)*L)^2; 
C2 = (K(2)*L)^2; 
w = w/sum(sum(w)); 
ua = filter2(w, Z, 'valid');%对窗口内并没有进行平均处理，而是与高斯卷积， ?
ub = filter2(w, X, 'valid'); % 类似加权平均 ?
ua_sq = ua.*ua; 
ub_sq = ub.*ub; 
ua_ub = ua.*ub; 
siga_sq = filter2(w, Z.*Z, 'valid') - ua_sq; 
sigb_sq = filter2(w, X.*X, 'valid') - ub_sq; 
sigab = filter2(w, Z.*X, 'valid') - ua_ub; 
ssim_map = ((2*ua_ub + C1).*(2*sigab + C2))./((ua_sq + ub_sq + C1).*(siga_sq + sigb_sq + C2)); 
MSSIM = mean2(ssim_map); 

display(MSE);%均方根误差MSE
display(PSNR);%峰值信噪比
display(MAE);%平均绝对误差
display(MSSIM);%结构相似性SSIM