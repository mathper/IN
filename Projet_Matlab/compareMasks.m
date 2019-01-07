function [rightly_detected, wrongly_detected, not_detected] = compareMasks(axe, S_final, S_ref, f_size)
%Compare les groupes de rectangles englobant S_final et S_ref, dessine sur axe

    for i=1:size(S_final,1)
        rectangle(axe, 'Position',S_final(i).BoundingBox*f_size,'EdgeColor','r','LineWidth',1);
    end
    
    for i=1:size(S_ref,1)
        rectangle(axe, 'Position',S_ref(i).BoundingBox*f_size,'EdgeColor','y','LineWidth',1);
    end
    
    
    %Elements correctement détectés
    rightly_detected = 0;
    %Elements mal détectés
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
    
    %Elements non détectés
    not_detected=size(S_ref,1)-rightly_detected;
    
end