function draw_handle=newSTLDraw(framename,stl_name,color);
global updateDraws_automatic

draw_handle=newFVDraw(framename,stlRead(stl_name),color);


    
    
    
    
    
    










if updateDraws_automatic
    updateDraws;
end