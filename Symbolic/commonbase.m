function [commonbase_,One_base_base1,One_base_base2]=commonbase(base1,base2)
global Bases
global BasesNames
% global q
% global dq
One_base_base1=sym(eye(3));
One_base_base2=sym(eye(3));

% Om_base_base1=Vector3D();
% Om_base_base2=Vector3D();

base_iter1=base1;
base_iter2=base2;

while base_iter1 ~= base_iter2;
    
    while base_iter1 > base_iter2;
     One_base_base1=Bases(base_iter1).prev_new*One_base_base1;
     %One_base_base1=simplify(One_base_base1);
%      Om_base_base1=Om_base_base1+Vector3D(rotmatrixtoomega(Bases(base_iter1).prev_new),base_iter1);
     base_iter1=Bases(base_iter1).prev;
    end

    while base_iter2 > base_iter1;
     One_base_base2=Bases(base_iter2).prev_new*One_base_base2;
     %One_base_base2=simplify(One_base_base2);
%      Om_base_base2=Om_base_base2+Vector3D(rotmatrixtoomega(Bases(base_iter2).prev_new),base_iter2);
     base_iter2=Bases(base_iter2).prev;
    end
    
end

commonbase_=base_iter1;

end
