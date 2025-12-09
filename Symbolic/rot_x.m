function One_B1_B2=rot_x(phi)
% B1--phi-->B2
% tuple_B1 = One_B1_B2 * tuple_B2

One_B1_B2=[1,0,0;
     0,cos(phi),-sin(phi);
     0,sin(phi),cos(phi)];

end