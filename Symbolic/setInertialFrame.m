function setInertialFrame(inertia_frame_name)
    global InertialFrame_name;
    global FramesNames
    isKey(FramesNames,inertia_frame_name)
    % Check if the frame_name exists in the system
    if isKey(FramesNames,inertia_frame_name) % Assuming getAvailableFrames returns a list of available frame names
        InertialFrame_name = inertia_frame_name;
    else
        error('The specified frame "%s" does is not "abs" or has not been defined.', inertia_frame_name);
    end
end