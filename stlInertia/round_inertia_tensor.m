
function [out_s,out_n,param_s,param_n]=round_inertia_tensor(inertia_tensor,tensor_name)
% syms a b c ap bp cp real
param_s=sym([]);
param_n=[];
norm_inertia_tensor=svd(inertia_tensor);
%norm_inertia_tensor=norm_inertia_tensor(1);
global round_inertia_tensor_tol1 round_inertia_tensor_tol2
if norm_inertia_tensor(1)<round_inertia_tensor_tol1
    for i=1:3
        for j=i:3
            inertia_tensor(i,j)=0;
            out_s(i,j)=sym(0);
            out_n(i,j)=0;
            if i~=j
                inertia_tensor(j,i)=0;
                out_s(j,i)=sym(0);
                out_n(j,i)=0;
            end
        end
    end
else
    for i=1:3
        for j=i:3
            if abs(inertia_tensor(i,j)/norm_inertia_tensor(3))<round_inertia_tensor_tol2
                inertia_tensor(i,j)=0;
                if i~=j
                    inertia_tensor(j,i)=0;
                end
            end
        end
    end
    if abs((inertia_tensor(1,1)-inertia_tensor(2,2))/norm_inertia_tensor(3)) < 1e-3
        inertia_tensor(2,2)=inertia_tensor(1,1);
    end
    if abs((inertia_tensor(2,2)-inertia_tensor(3,3))/norm_inertia_tensor(3)) < 1e-3
        inertia_tensor(3,3)=inertia_tensor(2,2);
    end
    if abs((inertia_tensor(3,3)-inertia_tensor(1,1))/norm_inertia_tensor(3)) < 1e-3
        inertia_tensor(1,1)=inertia_tensor(3,3);
    end
    out_n=inertia_tensor;
    
    if out_n(1,1)==out_n(2,2)
        if out_n(1,1)~=0
            out_s(1,1)=sym(strcat(tensor_name,'11'),'real');
            out_s(2,2)=out_s(1,1);
            param_s=[param_s;out_s(1,1)];
            param_n=[param_n;out_n(1,1)];
        end
    else
        if out_n(1,1)~=0
            out_s(1,1)=sym(strcat(tensor_name,'11'),'real');
            param_s=[param_s;out_s(1,1)];
            param_n=[param_n;out_n(1,1)];
        end
    end
    if out_n(2,2)==out_n(3,3)
        if out_n(2,2)~=0
            if out_n(2,2)~=out_n(1,1);
                out_s(2,2)=sym(strcat(tensor_name,'22'),'real');
                param_s=[param_s;out_s(2,2)];
                param_n=[param_n;out_n(2,2)];
            end
            out_s(3,3)=out_s(2,2);
        end
    else
        if out_n(2,2)~=0
            if out_n(2,2)~=out_n(1,1);
                out_s(2,2)=sym(strcat(tensor_name,'22'),'real');
                param_s=[param_s;out_s(2,2)];
                param_n=[param_n;out_n(2,2)];
            end
        end
    end
    if out_n(3,3)==out_n(1,1);
        out_s(3,3)=out_s(1,1);
    else
        if out_n(3,3)~=0
            if out_n(3,3)~=out_n(2,2);
                out_s(3,3)=sym(strcat(tensor_name,'33'),'real');
                param_s=[param_s;out_s(3,3)];
                param_n=[param_n;out_n(3,3)];
            end
        end
    end
    if out_n(1,2)~=0
        out_s(1,2)=sym(strcat(tensor_name,'12'),'real');
        out_s(2,1)=out_s(1,2);
        param_s=[param_s;out_s(1,2)];
        param_n=[param_n;out_n(1,2)];
    end
    if out_n(1,3)~=0
        out_s(1,3)=sym(strcat(tensor_name,'13'),'real');
        out_s(3,1)=out_s(1,3);
        param_s=[param_s;out_s(1,3)];
        param_n=[param_n;out_n(1,3)];
    end
    if out_n(2,3)~=0
        out_s(2,3)=sym(strcat(tensor_name,'23'),'real');
        out_s(3,2)=out_s(2,3);
        param_s=[param_s;out_s(2,3)];
        param_n=[param_n;out_n(2,3)];
    end
end
end



