close all;
clear;

img=imread('images/P0064.png');

%Color space RGB to ...
I = RGB2C1C2C3(img);

%Extraction C1 et C3
C1 = I(:,:,1);
C3 = I(:,:,3);

%Otsu tresholding on 2 channels -> 2 masks
level = graythresh(C1);
BW = imbinarize(C1,level);

level = multithresh(C3,2);
BW2 = ~imbinarize(C3,level(1));

%Product between the 2 masks (targeted componants are represented in both
%masks)
BW=BW.*BW2;

%Close componants + remove noise
BW = checkComponants(img, BW);

%Extract bounding rectangles
S = boundingRectangle(BW);

figure();imshow(img);
drawRect(gca, S);

%Compare with reference mask
mask_ref=imread('masks/P0064_m.png');

t=size(mask_ref);
if (size(size(mask_ref),2)==3)
    mask_ref=rgb2gray(mask_ref);
end

S2 = boundingRectangle(mask_ref);
compareMasks(img, S, S2);

