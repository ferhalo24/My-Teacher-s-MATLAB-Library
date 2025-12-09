function acceleration_vector=Accel(frame_name1,point_name,frame_name2)
global Frames FramesNames BasesNames PointsNames
if nargin<2 || nargin >3
    error('incorrect number of parameters');
end

if nargin==2
    if ischar(frame_name1)
         if isKey(FramesNames,frame_name1)
            wrt_frame_origin_point_number=PointsNames(frame_name1);
            wrt_frame_base_number=BasesNames(frame_name1);
        else
            error(['First parameter is a Frame name or Frame number: ''',frame_name1,''' is not a Frame name'])
        end
    else
        if frame_name1==0
            wrt_frame_origin_point_number=0;
            wrt_frame_base_number=0;
        else
            wrt_frame_origin_point_number=PointsNames(Frames(frame_name1).Point);
            wrt_frame_base_number=BasesNames(Frames(frame_name1).Base);
        end
    end
    if ischar(point_name)
        if isKey(PointsNames,point_name)
            point_name=PointsNames(point_name);
        else
            error(['Second parameter is a Point name or Point number: ''',point_name,''' is not a Point name'])
        end
    end
    velocity_vector=timederivative(Pos(wrt_frame_origin_point_number,point_name),wrt_frame_base_number);
    acceleration_vector=timederivative(velocity_vector,wrt_frame_base_number);
end

if nargin==3
    if ischar(frame_name1)
        if isKey(FramesNames,frame_name1)
            wrt_frame_origin_point_number=PointsNames(frame_name1);
            wrt_frame_base_number=BasesNames(frame_name1);
        else
            error(['First parameter is a Frame name or Frame number: ''',frame_name1,''' is not a Frame name'])
        end
     else
        if frame_name1==0
            wrt_frame_origin_point_number=0;
            wrt_frame_base_number=0;
        else
            wrt_frame_origin_point_number=PointsNames(Frames(frame_name1).Point);
            wrt_frame_base_number=BasesNames(Frames(FramesNames(frame_name1)).Base);
        end
    end
    if ischar(point_name)
        if isKey(PointsNames,point_name)
            point_name=PointsNames(point_name);
        else
            error(['Second parameter is a Point name or Point number: ''',point_name,''' is not a Point name'])
        end
    end
    if ischar(frame_name2)
        if isKey(FramesNames,frame_name2)
            point_frame_origin_name=PointsNames(frame_name2);
            point_frame_base_name=BasesNames(Frames(FramesNames(frame_name2)).Base);
        else
            error(['Third parameter is a Frame name or Frame number: ''',frame_name1,''' is not a Frame name'])
        end
    end
    velocity_vector = timederivative(Pos( wrt_frame_origin_point_number,point_frame_origin_name),wrt_frame_base_number);
    acceleration_vector=timederivative(velocity_vector,wrt_frame_base_number);
    acceleration_vector=acceleration_vector+...
        cross( Omega( wrt_frame_base_number,point_frame_base_name), cross( Omega( wrt_frame_base_number,point_frame_base_name), Pos(point_frame_origin_name,point_name) ))+...
        cross( Alpha( wrt_frame_base_number,point_frame_base_name), Pos(point_frame_origin_name,point_name));
end

