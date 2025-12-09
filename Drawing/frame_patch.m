function fvcs=frame_patch(scale,N)

if nargin==1
    N=8;
end

scale=scale/10;

[X,Y,Z] = cylinder([1/4,0],N);
fvcs(1) = surf2patch(scale*X,scale*Y,scale*Z,1);
Rot=rot_y(pi/2)';
tras=[scale*9,0,0]';
fvcs(1)=rotate_translate_patch(fvcs(1), tras, Rot);

fvcs(2) = surf2patch(scale*X,scale*Y,scale*Z,2);
Rot=rot_x(-pi/2)';
tras=[0,scale*9,0]';
fvcs(2)=rotate_translate_patch(fvcs(2), tras, Rot);

fvcs(3) = surf2patch(scale*X,scale*Y,scale*Z,3);
Rot=rot_z(0)';
tras=[0,0,scale*9]';
fvcs(3)=rotate_translate_patch(fvcs(3), tras, Rot);

% [X,Y,Z] = sphere(N);
% fvcs(4) = surf2patch(scale/4*X,scale/4*Y,scale/4*Z,4);
fvcs(4) = sphere_patch(scale/4,N);

[X,Y,Z] = cylinder([1/16,1/16],round(N/2));
fvcs(5) = surf2patch(scale*X,scale*Y,9*scale*Z,1);
Rot=rot_y(pi/2)';
tras=[0,0,0]';
fvcs(5)=rotate_translate_patch(fvcs(5), tras, Rot);

[X,Y,Z] = cylinder([1/16,1/16],round(N/2));
fvcs(6) = surf2patch(scale*X,scale*Y,9*scale*Z,1);
Rot=rot_x(-pi/2)';
tras=[0,0,0]';
fvcs(6)=rotate_translate_patch(fvcs(6), tras, Rot);

[X,Y,Z] = cylinder([1/16,1/16],round(N/2));
fvcs(7) = surf2patch(scale*X,scale*Y,9*scale*Z,1);
Rot=rot_z(0)';
tras=[0,0,0]';
fvcs(7)=rotate_translate_patch(fvcs(7), tras, Rot);

