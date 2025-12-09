function One_B1_B2=rot_y(phi)
% B1--phi-->B2
% tuple_B1 = One_B1_B2 * tuple_B2

One_B1_B2=[cos(phi),0,sin(phi);
     0,1,0;
    -sin(phi),0,cos(phi)];

end