function drawRect(axe, S, f_size)
%Dessine les rectangles englobants sur une image
%f_size facteur utilis� pour redimensionner l'image
    
    for i=1:size(S,1)
        rectangle(axe, 'Position',S(i).BoundingBox*f_size,'EdgeColor','r','LineWidth',1);
    end
    
end