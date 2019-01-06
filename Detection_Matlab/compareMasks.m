function compareMasks(img, S_final, S_ref)

    figure;imshow(img);
    hold on;
    
    for i=1:size(S_final,1)
        rectangle('Position',S_final(i).BoundingBox,'EdgeColor','r','LineWidth',1);
    end
    
    for i=1:size(S_ref,1)
        rectangle('Position',S_ref(i).BoundingBox,'EdgeColor','y','LineWidth',1);
    end
    
    
    rightly_detected = 0;
    wrongly_detected = 0;
    for i=1:size(S_final,1)
        res=0;
        boxA = S_final(i).BoundingBox;
        for j=1:size(S_ref,1)
            boxB = S_ref(j).BoundingBox;
            if (~ismember(-1,boxB) && bboxOverlapRatio(boxA, boxB, 'Min')>0.5)
                rightly_detected = rightly_detected + 1;
                res=1;
                S_ref(j).BoundingBox = [-1 -1 -1 -1];
                break;
            end
        end
        if(res==0)
            wrongly_detected = wrongly_detected + 1;
        end
    end
    
    not_detected=size(S_ref,1)-rightly_detected;
    
end