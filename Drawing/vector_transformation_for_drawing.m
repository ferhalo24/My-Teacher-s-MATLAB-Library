function rotation_for_vector_=vector_transformation_for_drawing(vector_z,scale)

norm_vector_z=norm(vector_z);

if norm_vector_z==0 
    rotation_for_vector_=1e-15*eye(3);
elseif abs((vector_z/norm_vector_z)'*[0,0,1]')<= sqrt(3)/3+0.01
        e3=vector_z/norm_vector_z;
        e1=cross(e3,[0,0,1]');
        e1=e1/norm(e1);
        e2=cross(e3,e1);
        rotation_for_vector_=norm_vector_z*[e1,e2,e3]*scale;
elseif abs((vector_z/norm_vector_z)'*[1,0,0]')<= sqrt(3)/3+0.01
        arrow_rot=rot_y(pi/2);
        e1=vector_z/norm_vector_z;
        e2=cross(e1,[1,0,0]');
        e2=e2/norm(e2);
        e3=cross(e1,e2);
        rotation_for_vector_=norm_vector_z*[e1,e2,e3]*arrow_rot*scale;
elseif abs((vector_z/norm_vector_z)'*[0,1,0]')<= sqrt(3)/3+0.01
        arrow_rot=rot_x(-pi/2);
        e2=vector_z/norm_vector_z;
        e3=cross(e2,[0,1,0]');
        e3=e3/norm(e3);
        e1=cross(e2,e3);
        rotation_for_vector_=norm_vector_z*[e1,e2,e3]*arrow_rot*scale;
else
    error('Situation not solved');
end
