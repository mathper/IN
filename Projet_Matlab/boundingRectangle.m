function S = boundingRectangle(BW)
%R�cup�re les rectangles englobants de chaque groupe de pixels

    CC = bwconncomp(BW,8);
    S = regionprops(CC,'BoundingBox');
    
end