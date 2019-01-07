function BW = checkComponants(BW)
%Fermeture morphologique sur BW + gestion du bruit

    se = strel('disk',5);
    BW=imclose(BW,se);
    
    Fc = 0.1;
    CC = bwconncomp(BW);

    for i=0:CC.NumObjects
        CC = bwconncomp(BW);
        numPixels = cellfun(@numel,CC.PixelIdxList);
        moy = mean(numPixels);
        [mini,idx] = min(numPixels);
        if(mini<moy*Fc)
            BW(CC.PixelIdxList{idx}) = 0;
        end
    end

end