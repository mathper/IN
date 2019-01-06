function checkWithReference(hObject)
%Compare les r�sultats issus de la d�tection de piscines avec une image /
%masque de r�f�rence

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
    
    %Produit entre les 2 masks (les �l�ments recherch�s sont compris dans les 2 masques)
    BW=BW.*BW2;

    %Fermeture + gestion du bruit
    BW = checkComponants(BW);

    %Rectangles englobants
    S = boundingRectangle(BW);
    
    clear BW;

    %Comparaison au masque de r�f�rence
    
    if (size(size(handles.Images.ref_mask),2)==3)
        handles.Images.ref_mask=rgb2gray(handles.Images.ref_mask);
    end
    
    S2 = boundingRectangle(handles.Images.ref_mask);
    
    imshow(imresize(handles.Images.Original, handles.f_size),'Parent',handles.bounding_rec);
    title(handles.bounding_rec, 'Comparaison entre donn�es de r�f�rence (jaune) et r�sultats obtenus (rouge)');
    [r,w,n] = compareMasks(handles.bounding_rec, S, S2, handles.f_size);
    
    set(handles.nb_detection, 'String', ['Nombre de d�tections correctes : '  num2str(r)]);
    set(handles.w_detection, 'String', ['Nombre de d�tections incorrectes : '  num2str(w)]);
    set(handles.n_detection, 'String', ['Nombre de piscines non d�tect�es : '  num2str(n)]);
    
    guidata(hObject,handles);

end

