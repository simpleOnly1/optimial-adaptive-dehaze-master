I = imread('4.png');

Wnd = 3;
Ir = I(:,:,1);
Ig = I(:,:,2);
Ib = I(:,:,3);

[m,n,~] = size(I)
Irr = zeros(m+Wnd-1, n+Wnd-1); 
Irr((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ir;
Igg = zeros(m+Wnd-1, n+Wnd-1); 
Igg((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ig;
Ibb = zeros(m+Wnd-1, n+Wnd-1); 
Ibb((Wnd-1)/2 : m+(Wnd-1)/2-1, (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ib;
%% ��ͨ��
for i=1:1:m
    for j=1:1:n
        %min����ֻ�ܼ��㵥����һ�л���һ��
        Rmax = max(max ( Irr(i:i+Wnd-1, j:j+Wnd-1) ));   %IrrΪ3*3�ľ���ȡһ����СֵΪ��ȡ��С����󹹳�һ��3*1���������ڶ�������С��Ϊ��ȡ��С
        Gmax = max(max ( Igg(i:i+Wnd-1, j:j+Wnd-1) ));
        Bmax = max(max ( Ibb(i:i+Wnd-1, j:j+Wnd-1) ));
%       Jdark(i,j) = min([Rmin;Gmin;Bmin]);
        Jdark(i,j) = max(min(Rmax,Gmax),Bmax);
    end
end

x = mean(mean(Jdark))