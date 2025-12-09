function dispValue(in,n_digits,base_name)
% getValue  
%   out = getValue(in) eval symbolic scalar expresion to a number
%
%   out = getValue(in,base_name) eval Vector3D to a matrix of numbers in
%   base basename
%
%   See also setValue.
global NamesBases

global t t_value
global q q_value
global dq dq_value
global ddq ddq_value
global param param_value
global epsilon epsilon_value
global lambda lambda_value
global lambda_aux lambda_aux_value

global  paramNames
global  epsilonNames
global  lambdaNames
global  lambda_auxNames
global  qNames
global  dqNames
global  ddqNames

if not(isa(in,'Vector3D'))
    if isa(in,'sym')
        out=double(subs(in,[q;dq;ddq;t;param;epsilon;lambda;lambda_aux;sym(pi)],[q_value;dq_value;ddq_value;t_value;param_value;epsilon_value;lambda_value;lambda_aux_value;double(pi)]));
    else
        in=subs(str2sym(in));
        out=double(subs(in,[q;dq;ddq;t;param;epsilon;lambda;lambda_aux;sym(pi)],[q_value;dq_value;ddq_value;t_value;param_value;epsilon_value;lambda_value;lambda_aux_value;double(pi)])); 
    end
else
    if nargin==1
        out.Value=getValue(in.Value);
        if in.Base==0
            out.Base_name='xyz';
        else
            out.Base_name=NamesBases(in.Base).Base_name;
        end
    elseif nargin==2
        in=in.inBase(base_name);
        out=getValue(in.Value);
    else
        error('To get the value of a Vector3D: getValue(Vector3D,''base_name''');
    end
end

if nargin==1
    n_digits=3;
end

if not(isa(in,'Vector3D'))

    if isrow(in)
        out = [in; vpa(string(round(out, n_digits)))];
    else
        out = [in, vpa(string(round(out, n_digits)))];
    end
    disp(out);

else
    out = [in.Value, vpa(string(round(out.Value, n_digits)))];
    disp(out);
    if in.Base==0
        disp(['Vector3D in base: ','''xyz''']);
    elseif isempty(in.Base)
        disp(['Vector3D in base: ','''[]''']);
    else
        disp(['Vector3D in base: ','''',char(NamesBases(in.Base).Base_name),'''']);
    end
end

end