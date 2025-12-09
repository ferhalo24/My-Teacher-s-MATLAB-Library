function [commonbase_,Alpha_base_base1,Alpha_base_base2]=commonalpha(base1,base2)

global Bases
global BasesNames
global q
global dq

One_base_base1=eye(3);
One_base_base2=eye(3);

Om_base_base1  =Vector3D();
Om_base_base2  =Vector3D();

Om_base_base1_prev=Vector3D();
Om_base_base2_prev=Vector3D();

Alpha_base_base1  =Vector3D();
Alpha_base_base2  =Vector3D();

base_iter1=base1;
base_iter2=base2;

while base_iter1 ~= base_iter2
    
    while base_iter1 > base_iter2
     One_base_base1=Bases(base_iter1).prev_new*One_base_base1;
     %One_base_base1=simplify(One_base_base1);
     Om_base_base1=Om_base_base1+Vector3D(rotmatrixtoomega(Bases(base_iter1).prev_new),base_iter1);
     Alpha_base_base1=Alpha_base_base1+Vector3D(rotmatrixtoalpha(Bases(base_iter1).prev_new),base_iter1);
     Alpha_base_base1=Alpha_base_base1+cross(Om_base_base1,Om_base_base1_prev);
     Om_base_base1_prev=Om_base_base1;
     base_iter1=Bases(base_iter1).prev;
    end

    while base_iter2 > base_iter1
     One_base_base2=Bases(base_iter2).prev_new*One_base_base2;
     %One_base_base2=simplify(One_base_base2);
     Om_base_base2=Om_base_base2+Vector3D(rotmatrixtoomega(Bases(base_iter2).prev_new),base_iter2);
     Alpha_base_base2=Alpha_base_base2+Vector3D(rotmatrixtoalpha(Bases(base_iter2).prev_new),base_iter2);
     Alpha_base_base2=Alpha_base_base2+cross(Om_base_base2,Om_base_base2_prev);
     Om_base_base2_prev=Om_base_base2;
     base_iter2=Bases(base_iter2).prev;
    end
    
end

commonbase_=base_iter1;

end
