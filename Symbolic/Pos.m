function P_point1_point2=Pos(point1,point2)
global Points PointsNames
if ischar(point1) 
    point1=PointsNames(point1);
end
if ischar(point2)
   point2=PointsNames(point2);
end 
[commonpoint_,P_commonpoint_point1,P_commonpoint_point2]=commonpoint(point1,point2);
P_point1_point2=P_commonpoint_point2-P_commonpoint_point1;

if isempty(P_point1_point2.Base)
    if point1==0
        %P_point1_point2.Value=sym([0,0,0]');
        P_point1_point2.Base=0;
    else
        %P_point1_point2.Value=sym([0,0,0]');
        P_point1_point2.Base=Points(point1).prev_new.Base;
    end
end
