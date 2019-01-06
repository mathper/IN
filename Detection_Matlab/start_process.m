function start_process(hObject)

    handles=guidata(hObject);

    %Color space RGB to ...
    I = RGB2C1C2C3(handles.Images.Original);

    % Display
    handles.Images.C1C2C3=I;
    imshow(handles.Images.C1C2C3,'Parent',handles.c1c2c3_img);
    title(handles.c1c2c3_img, 'R''G''B''');

    %Normalisation
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
    handles.Images.mask = checkComponants(handles.Images.Original, BW);
    %Final mask
    imshow(handles.Images.mask,'Parent',handles.mask);
    title(handles.mask, 'Masque extrait');

    %Extract bounding rectangles
    S = boundingRectangle(handles.Images.mask);

    %Draw bounding rectangles of detected swimming pools
    imshow(handles.Images.Original,'Parent',handles.bounding_rec);
    title(handles.bounding_rec, 'Piscines localisées');
    drawRect(handles.bounding_rec, S);

    %Draw areas of detected swimming pools
    %handles.Images.seg_img = drawArea(handles.Images.Original, handles.Images.mask);
    
    %imshow(handles.Images.seg_img,'Parent',handles.seg_img);
    %title('Segmentation');

    set(handles.nb_detection, 'String', ['Nombre de piscines détectées : '  num2str(size(S,1))]);
    
    guidata(hObject,handles);

end