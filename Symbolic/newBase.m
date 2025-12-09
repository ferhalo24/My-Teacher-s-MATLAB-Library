function newBase(prev,new,axis_num_or_direction,value)
global Bases
global BasesNames NamesBases
global dq OCdq

if isKey(BasesNames,prev)
    n_Bases=length(Bases)+1;
    
    if not(isKey(BasesNames,new))
        if axis_num_or_direction==1
%             R=rot_x(value);
%             prev_new_omega=rotmatrixtoomega(R);
            R=vectorangleparamtorot([1,0,0]',sym(value));
            prev_new_omega=vectorangleparamtoomega([1,0,0]',sym(value));
        elseif axis_num_or_direction==2
%             R=rot_y(value);
%             prev_new_omega=rotmatrixtoomega(R);
            R=vectorangleparamtorot([0,1,0]',sym(value));
            prev_new_omega=vectorangleparamtoomega([0,1,0]',sym(value));
        elseif axis_num_or_direction==3
%             R=rot_z(value);
%             prev_new_omega=rotmatrixtoomega(R);
            R=vectorangleparamtorot([0,0,1]',sym(value));
            prev_new_omega=vectorangleparamtoomega([0,0,1]',sym(value));
        elseif isequal(size(axis_num_or_direction),[3,1] )
            axis_num_or_direction=sym(axis_num_or_direction);
            R=vectorangleparamtorot(axis_num_or_direction,sym(value));
            prev_new_omega=vectorangleparamtoomega(axis_num_or_direction,sym(value));
            if simplify(norm(axis_num_or_direction))~=1
                [line,file]=currentline(3);
                Warning(['newBase() at line',num2str(line),' in file',file,newline,': It seems that norm(direction)~=1. Make sure that norm(direction)==1, otherwise define constraint equations to enforce this condition ("Phi(end+1,1)=norm(direction)-1").']);
            end
        elseif isequal(size(axis_num_or_direction),[4,1] )
            axis_num_or_direction=sym(axis_num_or_direction);
            R=eulerparamtorot(axis_num_or_direction);
             prev_new_omega=eulerparamtoomega(axis_num_or_direction);
            if simplify(norm(axis_num_or_direction))~=1
                [line,file]=currentline(3);
                Warning(['newBase() at line',num2str(line),' in file',file,newline,': It seems that norm(quaternion)~=1. Make sure that norm(quaternion)==1, otherwise define constraint equations to enforce this condition ("Phi(end+1,1)=norm(direction)-1").']);
            end
        elseif isequal(size(axis_num_or_direction),[3,3] )
            %Bases(n_Bases).rot_vect_comp=sym(axis_num_or_direction);
            axis_num_or_direction=sym(axis_num_or_direction);
            R=axis_num_or_direction;
            prev_new_omega=rotmatrixtoomega(R);
            if  not(isOrthogonal(getValue(R)))
                [line,file]=currentline(3);
                Warning(['newBase() at line',num2str(line),' in file',file,newline,': It seems that the provided base change is not orthonormal. Make sure it is, otherwise define constraint equations to enforce this condition ("Phi(end+1,1)=norm(direction)-1").']);
            end
        else
            error('"axis_num" parameter must be 1, 2 or 3 or a 1 norm 3x1 tuple.')
        end
        
        Bases(n_Bases).prev_new=R;
        Bases(n_Bases).prev=BasesNames(prev);
        Bases(n_Bases).prev_new_omega=prev_new_omega;
        
        OCprev_new_omega=null(jacobian(prev_new_omega,dq)');
        
        subset_OCvel=sym(zeros(1,0));;
        for i=1:rank(OCprev_new_omega)
            subset_OCvel=[subset_OCvel;newOCvel()];
        end
        OCprev_new_omega=OCprev_new_omega*subset_OCvel;
        
        Bases(n_Bases).prev_new_OComega=OCprev_new_omega;
        
        BasesNames(new)=n_Bases;
        NamesBases(n_Bases).Base_name=new;
    else
        error('new base alerady defined')
    end
else
    error('prev base not defined')
end

    
