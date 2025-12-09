function [tensor_s]=newInertiaTensor(solid_name,matrix_n,base_name)

% global Solids Frames
% global SolidsNames FramesNames

% if not(isKey(SolidsNames,solid_name))
%     error('Solid %s is not defined',solid_name);
% else
%     point_name=Frames(FramesNames(Solids(1).Frame)).Point;
% end

if isequal(size(matrix_n),[3,3]) && (issymmetric(getValue(sym(matrix_n))) && all(eig(getValue(sym(matrix_n))) >= 0))
    for i=1:3
        for j=i:3
            if isnumeric(matrix_n)
                if matrix_n(i,j) ~= 0
                    variable_name=['i_',solid_name,'_',num2str(i),num2str(j)];
                    variable_value=matrix_n(i,j);
                    
                    [J,I]=find(matrix_n == matrix_n(i,j),1,'first');
                    if   I==i && J==j
                        matrix_s(i,j)=newParam(variable_name,variable_value);
                    else
                        matrix_s(i,j)=matrix_s(I,J);
                    end
                else
                    matrix_s(i,j)=sym(0);
                end
                if i ~= j
                    matrix_s(j,i)=matrix_s(i,j);
                end
            elseif isa(matrix_n,'sym')
                matrix_s(i,j)=matrix_n(i,j);
                if i ~= j
                    matrix_s(j,i)=matrix_s(i,j);
                end
            else
                error('matrix_n (inertia tensor) is not a 3x3 sym or numeric symmetric semipositive definite matrix');
            end
        end
    end
    tensor_s=Vector3D(matrix_s,base_name);
else
    error('matrix_n (inertia tensor) is not a 3x3 sym or numeric symmetric semipositive definite matrix');
end