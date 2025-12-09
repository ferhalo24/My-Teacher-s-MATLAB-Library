release=date;
save('Lib_3D_MEC_MATLAB/release.mat','release');
filename=['Lib_3D_MEC_MATLAB_',release,'.zip'];
zip(filename,{'Lib_3D_MEC_MATLAB','Full_Problems/problem2'})
clear release filename