function [vector_s]=newInertiaCenterPos(solid_name,matrix_n,base_name)

% global Solids Frames
% global SolidsNames FramesNames

% if not(isKey(SolidsNames,solid_name))
%     error('Solid %s is not defined',solid_name);
% else
%     point_name=Frames(FramesNames(Solids(1).Frame)).Point;
% end

if isequal(size(matrix_n),[3,1])
    for i=1:3
        if isnumeric(matrix_n)
            if matrix_n(i,1) ~= 0
                variable_name=['r_',solid_name,'_',num2str(i)];
                variable_value=matrix_n(i,1);
                [I]=find(matrix_n == matrix_n(i,1),1,'first');
                if  I==i
                    matrix_s(i,1)=newParam(variable_name,variable_value);
                else
                    matrix_s(i,1)=matrix_s(I,1);
                end
            else
                matrix_s(i,1)=sym(0);
            end
        elseif isstring(matrix_n)
            if matrix_n(i,1) ~= "0"
                variable_name=char(matrix_n(i,1));
                variable_value=0;
                matrix_s(i,1)=newParam(variable_name,variable_value);
            else
                matrix_s(i,1)=sym(0);
            end
        elseif islogical(matrix_n)
            if matrix_n(i,1) ~= false
                variable_name=['r_',solid_name,'_',num2str(i)];
                variable_value=0;
                matrix_s(i,1)=newParam(variable_name,variable_value);
            else
                matrix_s(i,1)=sym(0);
            end
        elseif isa(matrix_n,'sym')
            matrix_s(i,1)=matrix_n(i,1);
        else
            error('matrix_n (inertia center position) must be a sym, numeric, char, string or boolean 3x1 array');
        end
    end
    vector_s=Vector3D(matrix_s,base_name);
else
    error('matrix_n (inertia center position) must be a sym, numeric, char, string or boolean 3x1 array');
end