function fvc=cylinder_patch(R,height,N)

if nargin==2
    N=16;
end
   
[X,Y,Z] = cylinder(R,N);
fvc = surf2patch(X,Y,height*Z,1);