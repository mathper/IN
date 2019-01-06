function S = boundingRectangle(BW)

    CC = bwconncomp(BW,8);
    S = regionprops(CC,'BoundingBox');
    
end