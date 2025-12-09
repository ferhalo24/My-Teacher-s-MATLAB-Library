function [commonpoint_,P_commonpoint_point1,P_commonpoint_point2]=commonvel_abs(point1,point2)
global Points

P_commonpoint_point1=Vector3D([0,0,0]',[]);
P_commonpoint_point2=Vector3D([0,0,0]',[]);

point_iter1=point1;
point_iter2=point2;

while point_iter1~=point_iter2
   
    while point_iter1 > point_iter2 
        %Acumulo vector de posición
         P_commonpoint_point1=Points(point_iter1).prev_new+P_commonpoint_point1;
         
         %P_commonpoint_point1.Value=simplify(P_commonpoint_point1.Value);
         point_iter1=Points(point_iter1).prev;
    end
    
    while point_iter2 > point_iter1
         P_commonpoint_point2=Points(point_iter2).prev_new+P_commonpoint_point2;
         %P_commonpoint_point2.Value=simplify(P_commonpoint_point2.Value);
         point_iter2=Points(point_iter2).prev;
    end

end
commonpoint_=point_iter1;
