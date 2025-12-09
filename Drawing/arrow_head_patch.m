function fvc=arrow_head_patch(scale,N)

if nargin==1
    N=16
end

scale=scale/10;

[X,Y,Z] = cylinder([1/4,0],N);
fvc = surf2patch(scale*X,scale*Y,scale*Z,1);