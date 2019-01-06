function start_process(hObject)
%M�thode pour la d�tection de piscines dans des images a�riennes

    handles=guidata(hObject);

    %Convertion RGB vers R'G'B'
    C1C2C3 = RGB2C1C2C3(handles.Images.Original);

    % Display
    imshow(imresize(C1C2C3, handles.f_size),'Parent',handles.c1c2c3_img);
    title(handles.c1c2c3_img, 'R''G''B''');

    C1 = C1C2C3(:,:,1);
    C3 = C1C2C3(:,:,3);
    
    clear C1C2C3;

    %Otsu tresholding sur 2 canaux -> 2 masques
    level = graythresh(C1);
    BW = imbinarize(C1,level);
    
    clear C1;

    level = multithresh(C3,2);
    BW2 = ~imbinarize(C3,level(1));
    
    clear C3;

    %Produit entre les 2 masks (les �l�ments recherch�s sont compris dans les 2 masques)
    BW=BW.*BW2;

    %Fermeture + gestion du bruit
    mask = checkComponants(BW);
    %Masque final
    imshow(imresize(mask, handles.f_size),'Parent',handles.mask);
    title(handles.mask, 'Masque extrait');

    %Rectangles englobants
    S = boundingRectangle(mask);
    
    handles.boxes = S;
    
    clear mask;

    %Dessine les rectangles englobants des piscines d�tect�es
    imshow(imresize(handles.Images.Original, handles.f_size),'Parent',handles.bounding_rec);
    title(handles.bounding_rec, 'Piscines localis�es');
    drawRect(handles.bounding_rec, S, handles.f_size);

    %handles.Images.seg_img = drawArea(handles.Images.Original, handles.Images.mask);
    %imshow(handles.Images.seg_img,'Parent',handles.seg_img);
    %title(handles.seg_img, 'Segmentation');

    set(handles.nb_detection, 'String', ['Nombre de piscines d�tect�es : '  num2str(size(S,1))]);
    
    guidata(hObject,handles);

end