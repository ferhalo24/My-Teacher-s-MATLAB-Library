clear all
close all
addpath ../../Lib_3D_MEC_MATLAB
addpath ../../Lib_3D_MEC_MATLAB/stlTools
!scadtostl.bash mast
fv = stlRead('mast.stl')
[volume,center_of_mass,inertia_tensor]=inert_prop(fv)


[out_s,out_n,param_s,param_n]=round_inertia_tensor(inertia_tensor,'sol')


