
% //Reference: http://en.wikipedia.org/wiki/Centroid#Centroid_of_triangle_and_tetrahedron
% //Reference: F. Tonon. Explicit Exact Formulas for the 3-D Tetrahedron Inertia Tensor
% //in Terms of its Vertex Coordinates. Journal of Mathematics and Statistics 1 (1): 8-11, 2004
% //http://www.scipub.org/fulltext/jms2/jms2118-11.pdf

function [mass,center_of_mass,inertia_tensor]=inert_prop(fv,rho)
volume_times_6=0;
cm_times_6=[0,0,0];
inertia_tensor=[0,0,0;
         0,0,0;
         0,0,0];

for i=1:size(fv.faces,1)
v1=fv.vertices(fv.faces(i,1),:);
v2=fv.vertices(fv.faces(i,2),:);
v3=fv.vertices(fv.faces(i,3),:);
vol_dot_6=1/6*det([v1;v2;v3]);
volume_times_6=volume_times_6+vol_dot_6;
cm_times_6=cm_times_6+(v1+v2+v3)/4.0*vol_dot_6;
x1=0;y1=0;z1=0;
x2=v1(1,1);y2=v1(1,2);z2=v1(1,3);
x3=v2(1,1);y3=v2(1,2);z3=v2(1,3);
x4=v3(1,1);y4=v3(1,2);z4=v3(1,3);

    a = vol_dot_6* (...
y1*y1 + y1*y2 + y2*y2 + y1*y3 + y2*y3 + y3*y3 + y1*y4 + y2*y4 + y3*y4 + y4*y4 +...
z1*z1 + z1*z2 + z2*z2 + z1*z3 + z2*z3 + z3*z3 + z1*z4 + z2*z4 + z3*z4 + z4*z4...
 ) / 60.0;

 b = vol_dot_6* (...
x1*x1 + x1*x2 + x2*x2 + x1*x3 + x2*x3 + x3*x3 + x1*x4 + x2*x4 + x3*x4 + x4*x4 +...
z1*z1 + z1*z2 + z2*z2 + z1*z3 + z2*z3 + z3*z3 + z1*z4 + z2*z4 + z3*z4 + z4*z4...
 ) / 60.0;

 c = vol_dot_6* (...
x1*x1 + x1*x2 + x2*x2 + x1*x3 + x2*x3 + x3*x3 + x1*x4 + x2*x4 + x3*x4 + x4*x4 +...
y1*y1 + y1*y2 + y2*y2 + y1*y3 + y2*y3 + y3*y3 + y1*y4 + y2*y4 + y3*y4 + y4*y4...
 ) / 60.0;

ap= vol_dot_6* (2.0 * y1*z1 + y2*z1 + y3*z1 + y4*z1 + y1*z2 +...
2.0 * y2*z2 + y3*z2 + y4*z2 + y1*z3 + y2*z3 + 2.0 * y3*z3 +...
y4*z3 + y1*z4 + y2*z4 + y3*z4 + 2.0 * y4*z4...
) / 120.0;

bp = vol_dot_6* (2.0 * x1*z1 + x2*z1 + x3*z1 + x4*z1 + x1*z2 +...
2.0 * x2*z2 + x3*z2 + x4*z2 + x1*z3 + x2*z3 + 2.0 * x3*z3 +...
x4*z3 + x1*z4 + x2*z4 + x3*z4 + 2.0 * x4*z4...
) / 120.0;

cp = vol_dot_6* (2.0 * x1*y1 + x2*y1 + x3*y1 + x4*y1 + x1*y2 +...
2.0 * x2*y2 + x3*y2 + x4*y2 + x1*y3 + x2*y3 + 2.0 * x3*y3 +...
x4*y3 + x1*y4 + x2*y4 + x3*y4 + 2.0 * x4*y4...
) / 120.0;
inertia_tensor=inertia_tensor+...
    [a,-cp,-bp;
     -cp,b,-ap;
     -bp,-ap,c];
 
end
volume=volume_times_6/6;
if volume<=0
    error('StlInertia:Volume_is_zero','Frames Vertex structure volume is %d <=0!.\n It makes no sense for a Frames Vertex structure defining a proper solid',volume);
end
mass=rho*volume;
cm=cm_times_6/6/volume;
cm=cm';
center_of_mass=cm;
inertia_tensor=rho*inertia_tensor;
end
