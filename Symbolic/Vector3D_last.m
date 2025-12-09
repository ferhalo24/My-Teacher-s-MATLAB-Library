classdef (InferiorClasses = {?sym}) Vector3D
    properties
        Value
        Base
    end
    methods
        function obj = Vector3D(val,name)
            global Bases
            global BasesNames
            if nargin > 0
                if isnumeric(val) || isa(val,'sym')
                    if (size(val,1)==3 && size(val,2)==1) || (size(val,2)==3)
                        obj.Value = sym(val);
                    elseif (size(val,1)==3 && size(val,2)==1)
                        obj.Value = sym(val)';
                    else
                        error('Value must be 3x1 or 3x3 numeric or symbolic array');
                    end
                else
                  error('Value must be 3x1 or 3x3  numeric or symbolic array');  
                end
                if not(isempty(name))
                    if ischar(name)
                        obj.Base = BasesNames(name);
                    elseif isa(name,'double') && isscalar(name) && name >= 0 && name <= length(Bases);
                        obj.Base = name;
                    else
                        error('Value must be a string or a integer number 0:num_Bases')
                    end
                end
            end
        end
        %-------------------------------------------
        function r=mtimes(o1,o2)
            r=Vector3D();
            if isa(o2,'Vector3D')
                if isa(o1,'Vector3D')
                    if isequal(size(o1.Value),[3,3]) || isequal(size(o2.Value),[3,1])
                        if isZero(o1)
                            r.Value=o1.Value * o2.Value;
                            r.Base=o2.Base;
                        elseif isZero(o2)
                            r.Value=o1.Value * o2.Value;
                            r.Base=o1.Base;
                        else
                        [comon_base,One_base_base1,One_base_base2]=commonbase(o1.Base,o2.Base);
                        r.Value=(One_base_base1*o1.Value)*One_base_base1' * One_base_base2*o2.Value;
                        r.Base=comon_base;
                        end
                    else
                        error('only product of 3x3-tensor by 3x1-vector are allowed');
                    end
                elseif size(o1,1)==1 && size(o1,2)==1
                    r.Value=o1*o2.Value;
                    r.Base=o2.Base;
                else
                    error("Size or type mismatch in Vector3D::mtimes: Vector3D3x3 * Vector3D3x3 or Vector3D3x3 * Vector3D3x1 or scalar * Vector3D or Vector3D * scalar are allowed.")
                end
            elseif size(o2,1)==1 && size(o2,2)==1
                r.Value=o2*o1.Value;
                r.Base=o1.Base;
            end
        end
        %       %-------------------------------------------
        %       function r=times(o1,o2)
        %           r=Vector3D();
        %           if size(o1)==[1,1]
        %               r.Value=o1*o2.Value;
        %               r.Base=o2.Base;
        %           end
        %       end
        %-------------------------------------------
        function r = plus(o1,o2)
            r=Vector3D();
            if isa(o2,'Vector3D')
                if isa(o1,'Vector3D')
                    if isempty(o1.Value) && isempty(o2.Value)
                        r.Value = [0,0,0]'; % o1.Value;
                        r.Base = o1.Base;
                        error('JAVIER: Debug this error Vector3D::plus arguments cannot be empty');
                    elseif isempty(o1.Value)
                        r.Value = o2.Value;
                        r.Base = o2.Base;
                    elseif isempty(o2.Value)
                        r.Value = o1.Value;
                        r.Base = o1.Base;
                    else
                        if isequal(size(o1.Value),size(o2.Value))
                            if isZero(o1)
                                r.Value = o2.Value;
                                r.Base = o2.Base;
                            elseif isZero(o2)
                                r.Value = o1.Value;
                                r.Base = o1.Base;
                            else
                                [comon_base,One_base_base1,One_base_base2]=commonbase(o1.Base,o2.Base);
                                r.Value = One_base_base1*o1.Value + One_base_base2*o2.Value;
                                r.Base = comon_base;
                            end
                        else
                            error('Size mismatch in plus method of class vector3D');
                        end
                    end
                else
                    error('JAVIER: Debug this error');
                end
            else
                error('JAVIER: Debug this error');
            end
        end
        %-------------------------------------------
        function r = uminus(o1)
            r=Vector3D();
            if isempty(o1.Value)
                r.Value = [0,0,0]';
                error('JAVIER: Debug this error');
            else
                r.Value = -o1.Value;
            end
            r.Base = o1.Base;
        end
        %-------------------------------------------
        function r = minus(o1,o2)
            r=plus(o1,-o2);
        end
        %-------------------------------------------
        function r = cross(o1,o2)
            if isempty(o1.Value) || isempty(o2.Value)
                r = Vector3D();
                error('JAVIER: Debug this error');
            else
                if isequal(size(o1.Value),[3,1]) && isequal(size(o1.Value),[3,1])
                    if isZero(o1)
                        r = sym(0)*o2;
                    elseif isZero(o2)
                        r = sym(0)*o1;
                    else
                        [comon_base,One_base_base1,One_base_base2]=commonbase(o1.Base,o2.Base);
                        r = Vector3D();
                        r.Value = cross(One_base_base1*o1.Value , One_base_base2*o2.Value);
                        r.Base = comon_base;
                    end
                else
                    error('Size mismatch in cross method of class vector3D');
                end
            end
        end
        %-------------------------------------------
        function r = inBase(o1,base)
            global BasesNames
            if isempty(o1.Value)
                r = Vector3D();
            else
                if isa(base,'double') && isscalar(base) && base >= 0 && base <= length(Bases)
                    base_number=base;  
                else
                    base_number=BasesNames(base);
                end
                [common_base_,One_base_base1,One_base_base2]=commonbase(o1.Base,base_number);
                aux=One_base_base2'*One_base_base1;
                r = Vector3D();
                if isequal(size(o1.Value),[3,1])
                    r.Value = aux*o1.Value;
                elseif isequal(size(o1.Value),[3,3])
                    
                    r.Value = aux*(o1.Value*aux');
                end
                r.Base = base_number;
            end
        end
        %-------------------------------------------
        function r = dot(o1,o2)
            if isempty(o1.Value) || isempty(o2.Value)
                r = [];
                error('JAVIER: Debug this error Vector3D::plus arguments cannot be empty');
            else
                if isZero(o1)
                    o1.Base=o2.Base;
                end
                if isZero(o2)
                    o2.Base=o1.Base;
                end
                [common_base_,One_base_base1,One_base_base2]=commonbase(o1.Base,o2.Base);
                r = (One_base_base1*o1.Value).'*(One_base_base2*o2.Value);
            end
        end
        %-------------------------------------------
        function dv=timederivative(v,base)
            global Bases
            global BasesNames
            
            global q
            global dq
            global ddq
            global t
            
            if  isZero(v)
                dv=Vector3D();
                dv.Value=sym(zeros(size(v.Value)));
                dv.Base=v.Base;
            else
                if isempty(v.Base)
                    %dv=[];
                    error('JAVIER: Debug this error.  Vector3D::timederivative requires a second base_name or base_number argument');
                else
                    
                    if ischar(base)
                        base = BasesNames(base);
                    elseif not(isa(base,'double') && isscalar(base) && base >= 0 && base <= length(Bases))
                        error("Vector3D::timederivative: Second argument must be a valid base_number (0:num_Bases)");
                    end
                    
                    dv=Vector3D();
                    dv.Value=sym(zeros(size(v.Value)));
                    dv.Base=v.Base;
                    
                    for i=1:size(q,1)
                        dv.Value = dv.Value+diff(v.Value,q(i))*dq(i);
                    end
                    
                    for i=1:size(dq,1)
                        dv.Value = dv.Value+diff(v.Value,dq(i))*ddq(i);
                    end
                    
                    dv.Value = dv.Value+diff(v.Value,t);
                    
                    if nargin==2
                        dv=dv+cross(Omega(base,v.Base),v);
                    end
                    
                end
            end
        end
        %-------------------------------------------
        function dv=diff(v,dqi)
            global Bases
            global BasesNames
            
            global q
            global dq
            global ddq
            
            dv=Vector3D(diff(v.Value,dqi),v.Base);
            
        end
        %---------------
        function t=vecttoskew(v)
            t=v;
            t.Value=vecttoskew(v.Value);
        end
        %---------------
        function t=skew(v)
            t=v;
            t.Value=vecttoskew(v.Value);
        end
        %---------------
        function simplified_v=simplify(v)   
            simplified_v=Vector3D(simplify(v.Value),v.Base);  
        end
        %---------------
        function out_s=norm(v)
            out_s=norm(v.Value);  
        end
        %-------------------------------------------
        function disp(obj)
            global NamesBases
            
            if size(obj.Value,2)==1
                fprintf('%s\n',char(obj.Value(1)));
                fprintf('%s\n',char(obj.Value(2)));
                fprintf('%s\n',char(obj.Value(3)));
            elseif size(obj.Value,2)==3
                fprintf('%s, %s, %s\n',char(obj.Value(1,1)),char(obj.Value(1,2)),char(obj.Value(1,3)));
                fprintf('%s, %s, %s\n',char(obj.Value(2,1)),char(obj.Value(2,2)),char(obj.Value(2,3)));
                fprintf('%s, %s, %s\n',char(obj.Value(3,1)),char(obj.Value(3,2)),char(obj.Value(3,3)));
            elseif isempty(obj.Value)
                fprintf('[]\n');
            end
            
            if obj.Base==0
                disp(['_''xyz''']);
            elseif isempty(obj.Base)
                disp('_[]');
            else
                disp(['''',char(NamesBases(obj.Base).Base_name),'''']);
            end
        end
        %-------------------------------------------
        function out_array=vertcat(varargin)
            out_array=[];
            for i=1:nargin
                if isa(varargin{i},'double') ||  isa(varargin{i},'sym')
                out_array=[out_array;varargin{i}];
                else
                out_array=[out_array;varargin{i}.Value];
                end
            end
        end
        %-------------------------------------------
        function out_array=horzcat(varargin)
            out_array=[];
            for i=1:nargin
                if isa(varargin{i},'double') ||  isa(varargin{i},'sym')
                out_array=[out_array,varargin{i}];
                else
                out_array=[out_array,varargin{i}.Value];
                end
            end
        end
        %-------------------------------------------
        function result=isZero(v)
            if isempty(v.Value)
                result=false;
            elseif isequal(size(v.Value), [3,1])
                if v.Value(1,1)==0 && v.Value(2,1)==0 && v.Value(3,1)==0
                    result=true;
                else
                    result=false;
                end
            elseif isequal(size(v.Value), [3,3])
                if v.Value(1,1)==0 && v.Value(2,1)==0 && v.Value(3,1)==0 ...
                        && v.Value(1,2)==0 && v.Value(2,2)==0 && v.Value(3,2)==0 ...
                    && v.Value(1,3)==0 && v.Value(2,3)==0 && v.Value(3,3)==0
                    result=true;
                else
                    result=false;
                end
            end
        end
        %-------------------------------------------
    end
end
