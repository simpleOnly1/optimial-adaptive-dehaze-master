function image = adjustimage(img, c, b, Jdark_kmeans)
%通过对天空区域和费天空区域进行色彩调整，提升图像质量
%其中c是调整色度，b是调整亮度

%区分天空和非天空区域
[m, n, t] = size(img);
% img1 = img(:);
% 
% for i = 1:m*n*t
%     if ~Jdark_kmeans
%         img1(i) = img1(i).*c + b;
%     else 
%         img1(i) = img1(i).*c + b;     
%     end   
% end
% img1 = reshape(img1', m, n, t);    
% % for x = 1:m
% %     for y = 1:n
% %         if ~Jdark_kmeans
% %             img(x,y,:) = img(x,y,:).*c + b;
% %         else 
% %             img(x,y,:) = img(x,y,:).*c + b;     
% %         end
% %     end
% % end
for i = 1:m
    for j = 1:n
        for k = 1:t
            image(i,j,t) = img(i,j,t) * c + b;
        end
    end
end
end