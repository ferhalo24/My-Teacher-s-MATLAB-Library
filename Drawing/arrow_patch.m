function fvcs=arrow_patch(scale,N)

if nargin==1
    N=8
end
   
scale=scale/10;

[X,Y,Z] = cylinder([1/4,0],N);

fvcs(1) = surf2patch(scale*X,scale*Y,scale*Z,3);
Rot=rot_z(0)';
tras=[0,0,9*scale]';
fvcs(1)=rotate_translate_patch(fvcs(1), tras, Rot);

[X,Y,Z] = cylinder([1/16,1/16],round(N/2));
fvcs(2) = surf2patch(scale*X,scale*Y,9*scale*Z,1);
Rot=rot_z(0)';
tras=[0,0,0]';
fvcs(2)=rotate_translate_patch(fvcs(2), tras, Rot);


