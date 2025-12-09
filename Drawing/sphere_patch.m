
function fvc=sphere_patch(radius,N)

if nargin==1
    N=8;
end

[X,Y,Z] = sphere(N);
fvc = surf2patch(radius*X,radius*Y,radius*Z,4);