clc;
clear all;
close all;

J = imread('13.png');
J = double(J);
J = J ./255 ;
% J1 = J(:,:,1);
% J2 = J(:,:,2);
% J3 = J(:,:,3);
% figure(1); imshow(J1); 
% figure(2); imshow(J2); 
% figure(3); imshow(J3); 
figure(1); imshow(J); 
%% ��ͨ��ͼ�� Jdark = min(min());
Jdark = Idark(J);
figure(2);imshow(Jdark,[]);
% cha = J1-Jdark2;
% figure(6);imshow(cha,[]);
% cha = J2-Jdark2;
% figure(7);imshow(cha,[]);
% cha = J3-Jdark2;
% figure(8);imshow(cha,[]);

%%
% ע�⣺�ο���ʹ����soft matting�����Եõ��Ĵ�͸����Jt����ϸ�� 
%       ����������ݶȵ����˲�ʵ��
tic;
Jdark = guidedfilter(Jdark,Jdark,16,0.04);
toc;
% Jdark = gradient_guidedfilter(Jdark,Jdark, 0.04);

%% ��������ģ�� J = I*t + A*(1-t)  ��ֱ��˥���+���������ա�
% ͸���� t����ȵĹ�ϵ t=exp(-a*depth)
w = 0.95;         %��ı���ϵ��
Jt = 1 - w*Jdark; %���͸����
figure(3);imshow(Jt,[]);


%% ���ȫ�ִ�������
% 1.���ȶ����������ͼ��I����䰵ͨ��ͼ��Jdark��
% 2.ѡ��Jdark�����ص����ǧ��֮һ��N/1000�������������ص㣬��¼���ص㣨x,y������
% 3.���ݵ������ֱ���ԭͼ��J������ͨ����r,g,b�����ҵ���Щ���ص㲢�Ӻ͵õ���sum_r,sum_g,sum_b��.
% 4.Ac=[Ar,Ag,Ab]. ����Ar=sum_r/N;   Ag=sum_g/N;   Ab=sum_b/N.
[m,n,~] = size(J);
N = floor( m*n./1000 );
MaxPos = [0,0]; % ��ʼ��
for i=1:1:N
    MaxValue = max(max(Jdark));
    [x,y] = find(Jdark==MaxValue);
    Jdack(Jdark==MaxValue) = 0; %���ֵ���㣬Ѱ����һ�δδ�ֵ
    %��鳤��
    MaxPos = vertcat(MaxPos,[x,y]);
    Cnt = length(MaxPos(1));
    if Cnt > N
        break;
    end
end
MaxPosN = MaxPos(2:N+1,:);

Rsum = 0;  Jr = J(:,:,1);
Gsum = 0;  Jg = J(:,:,2);
Bsum = 0;  Jb = J(:,:,3);
for j=1:1:N
    Rsum = Rsum + Jr(MaxPosN(j,1),MaxPosN(j,2));
    Gsum = Gsum + Jg(MaxPosN(j,1),MaxPosN(j,2));
    Bsum = Bsum + Jb(MaxPosN(j,1),MaxPosN(j,2));
end

Ac = [Rsum/N, Gsum/N, Bsum/N];

%% ���������ͼ��
% ���� J = I*t + A*(1-t)   I = (J-A)/Jt + A
Iorg = zeros(m,n,3);
for i = 1:1:m
    for j = 1:1:n
        for k = 1:1:3
        Iorg(i,j,k) = (J(i,j,k)-Ac(k)) ./ Jt(i,j) + Ac(k);
        end
    end
end
figure(4); imshow(Iorg,[]);

% imwrite(Iorg,'XT0.jpg');