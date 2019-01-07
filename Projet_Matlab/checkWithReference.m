function checkWithReference(hObject)
%Compare les résultats issus de la détection de piscines avec une image /
%masque de référence

    handles=guidata(hObject);

    %Convertion RGB vers R'G'B'
    I = RGB2C1C2C3(handles.Images.Original);

    %Extraction C1 et C3
    C1 = I(:,:,1);
    C3 = I(:,:,3);
    
    clear I;

    %Otsu tresholding sur 2 canaux -> 2 masques
    level = graythresh(C1);
    BW = imbinarize(C1,level);
    
    clear C1;

    level = multithresh(C3,2);
    BW2 = ~imbinarize(C3,level(1));
    
    clear C3;
    
    %Produit entre les 2 masks (les éléments recherchés sont compris dans les 2 masques)
    BW=BW.*BW2;

    %Fermeture + gestion du bruit
    BW = checkComponants(BW);

    %Rectangles englobants
    S = boundingRectangle(BW);
    
    clear BW;

    %Comparaison au masque de référence
    
    if (size(size(handles.Images.ref_mask),2)==3)
        handles.Images.ref_mask=rgb2gray(handles.Images.ref_mask);
    end
    
    S2 = boundingRectangle(handles.Images.ref_mask);
    
    imshow(imresize(handles.Images.Original, handles.f_size),'Parent',handles.bounding_rec);
    title(handles.bounding_rec, 'Comparaison entre données de référence (jaune) et résultats obtenus (rouge)');
    [r,w,n] = compareMasks(handles.bounding_rec, S, S2, handles.f_size);
    
    set(handles.nb_detection, 'String', ['Nombre de détections correctes : '  num2str(r)]);
    set(handles.w_detection, 'String', ['Nombre de détections incorrectes : '  num2str(w)]);
    set(handles.n_detection, 'String', ['Nombre de piscines non détectées : '  num2str(n)]);
    
    guidata(hObject,handles);

end

