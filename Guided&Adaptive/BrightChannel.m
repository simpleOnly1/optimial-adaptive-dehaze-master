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
%% 暗通道
for i=1:1:m
    for j=1:1:n
        %min函数只能计算单独的一行或者一列
        Rmax = max(max ( Irr(i:i+Wnd-1, j:j+Wnd-1) ));   %Irr为3*3的矩阵，取一次最小值为行取最小，最后构成一个3*1的向量，第二次求最小即为列取最小
        Gmax = max(max ( Igg(i:i+Wnd-1, j:j+Wnd-1) ));
        Bmax = max(max ( Ibb(i:i+Wnd-1, j:j+Wnd-1) ));
%       Jdark(i,j) = min([Rmin;Gmin;Bmin]);
        Jdark(i,j) = max(min(Rmax,Gmax),Bmax);
    end
end

x = mean(mean(Jdark))