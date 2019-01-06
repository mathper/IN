close all;
clear;

img=imread('masks/P0064.png');

[w,h,z] = size(img);

img_mask = zeros(w,h);

for i=1:w
    for j=1:h
        if(img(i,j,1)==255 && img(i,j,2)==0 && img(i,j,3)==0)
            img_mask(i,j) = 1;
        end
    end
end

figure();imshow(img_mask);

imwrite(img_mask, 'masks/P0064_m.png');