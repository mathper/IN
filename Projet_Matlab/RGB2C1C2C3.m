function I = RGB2C1C2C3(img)
%Convertion RGB vers R'G'B'

    max_v = max(max(max(img(:,:,:))));
    min_v = min(min(min(img(:,:,:))));
    
    I(:,:,1)=atan((double(max_v)-double(img(:,:,1)))/double(max_v-min_v));
    I(:,:,2)=atan((double(max_v)-double(img(:,:,2)))/double(max_v-min_v));
    I(:,:,3)=atan((double(max_v)-double(img(:,:,3)))/double(max_v-min_v));
    
end