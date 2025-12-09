function Om_base1_base2=Omega(base1,base2)
global Bases
global BasesNames
global FramesNames
if ischar(base1)
    if isKey(BasesNames,base1) 
     base1 = BasesNames(base1); 
    elseif isKey(FramesNames,base1)
     frame1 = FramesNames(base1); 
     base1=BasesNames(Frames(frame1).Base);
    else  
     error('1st argument is not a defined Base or Frame');
    end
elseif not(isa(base1,'double') && isscalar(base1) && base1 >= 0 && base1 <= length(Bases))
    error('1st parameter must be a string (Frame or Base name) or a integer number 0:num_Bases')
end
if ischar(base2)
     if isKey(BasesNames,base2) 
     base2 = BasesNames(base2); 
    elseif isKey(FramesNames,base2)
     frame2 = FramesNames(base2); 
     base2=BasesNames(Frames(frame2).Base);
    else  
     error('2nd argument is not a defined Base or Frame');
    end
elseif not(isa(base2,'double') && isscalar(base2) && base2 >= 0 && base2 <= length(Bases))
    error('2nd parameter must be a string (Frame or Base name) or a integer number 0:num_Bases')
end

[commonbase_,Om_base_base1,Om_base_base2]=commonomega(base1,base2);
Om_base1_base2=Om_base_base2-Om_base_base1;