function img=drawArea(img, BW)

    t1 = img(:,:,1);
    t2 = img(:,:,2);
    t3 = img(:,:,3);
    t1(BW==1) = 0;
    t2(BW==1) = 0;
    t3(BW==1) = 255;
    img(:,:,1) = t1;
    img(:,:,2) = t2;
    img(:,:,3) = t3;

end