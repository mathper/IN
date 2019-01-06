function S = boundingRectangle(BW)
%Récupère les rectangles englobants de chaque groupe de pixels

    CC = bwconncomp(BW,8);
    S = regionprops(CC,'BoundingBox');
    
end