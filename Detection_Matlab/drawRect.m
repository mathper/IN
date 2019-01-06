function drawRect(axe, S)
    
    for i=1:size(S,1)
        rectangle(axe, 'Position',S(i).BoundingBox,'EdgeColor','r','LineWidth',1);
    end
    
end