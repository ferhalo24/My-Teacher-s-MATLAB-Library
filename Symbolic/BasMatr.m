function One_base1_base2=BasMatr(base1,base2)

global BasesNames

if ischar(base1) 
    base1=BasesNames(base1);
end

if ischar(base2)
    base2=BasesNames(base2);
end

[commonbase_,One_base_base1,One_base_base2]=commonbase(base1,base2);
One_base1_base2=One_base_base1'*One_base_base2;