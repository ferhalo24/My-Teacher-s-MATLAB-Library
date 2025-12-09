function [FIG_Sol,MIG_Sol_wrt_point,wrt_point_name]=newInertia_and_Gravity_Force_Moment(solid_name, wrt_point_name)

[FI_Sol,MI_Sol_wrt_point, wrt_point_name] = newInertia_Force_Moment( solid_name, wrt_point_name );
[FG_Sol,MG_Sol_wrt_point, wrt_point_name] = newGravity_Force_Moment( solid_name, wrt_point_name );

FIG_Sol=FI_Sol+FG_Sol;
MIG_Sol_wrt_point=MI_Sol_wrt_point+MG_Sol_wrt_point;

end