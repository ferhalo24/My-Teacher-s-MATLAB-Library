function [coord,dcoord,ddcoord]=newCoord(variable_name,coord_n,dcoord_n,ddcoord_n)
global q  dq  ddq
global n_q n_dq n_ddq
global q_value dq_value ddq_value
global qNames dqNames ddqNames paramNames epsilonNames lambdaNames

ise = evalin( 'base', ['exist(''',variable_name,''',''var'') == 1'] );

if not(ise)
    
    if isKey(qNames,variable_name) || ...
            isKey(dqNames,variable_name) || ...
            isKey(ddqNames,variable_name) || ...
            isKey(paramNames,variable_name) || ...
            isKey(epsilonNames,variable_name) || ...
            isKey(lambdaNames,variable_name)
        error('Variable name %s already defined, use a different name. To change value use setValue(name,value)',variable_name);
    end
    %% 
    
    
    coord=sym(variable_name,'real');
    dcoord_name=['d',variable_name];
    dcoord_accentuated=convertStringsToChars(regexprep(variable_name,'([A-Za-z]*)_*([\d]*)','$1_dot_$2'));
    if dcoord_accentuated(end)=='_';
        dcoord_accentuated=dcoord_accentuated(1:end-1);
    end
    %dcoord_accentuated=[variable_name,'_dot'];
    dcoord=sym(dcoord_accentuated,'real');
    ddcoord_name=['dd',variable_name];
    ddcoord_accentuated=convertStringsToChars(regexprep(variable_name,'([A-Za-z]*)_*([\d]*)','$1_ddot_$2'));
    if ddcoord_accentuated(end)=='_';
        ddcoord_accentuated=ddcoord_accentuated(1:end-1);
    end
    %ddcoord_accentuated=[variable_name,'_ddot'];
    ddcoord=sym(ddcoord_accentuated,'real');
    
    
    q=[q;coord];
    dq=[dq;dcoord];
    ddq=[ddq;ddcoord];
    n_q=length(q);
    n_dq=length(dq);
    n_ddq=length(ddq);
    qNames(variable_name)=n_q;
    dqNames(dcoord_name)=n_q;
    ddqNames(ddcoord_name)=n_q;
    dqNames(dcoord_accentuated)=n_q;
    ddqNames(ddcoord_accentuated)=n_q;
    
    if nargin==3
        ddcoord_n=0;
    elseif nargin==2
        ddcoord_n=0;
        dcoord_n=0;
    elseif nargin==1
        ddcoord_n=0;
        dcoord_n=0;
        coord_n=0;
    end
    
    if nargout<=2
        assignin('base',ddcoord_name, ddcoord);
        if nargout<=1
            assignin('base',dcoord_name, dcoord);
            if nargout==0
                assignin('base',variable_name,coord);
            end
        end
    end
    
   
    if  (not(isequal(size(coord_n),[1,1]))) || not(isnumeric(coord_n))
        error('Gen. Coord. value must be numeric.');
    end
    
    if  (not(isequal(size(dcoord_n),[1,1]))) || not(isnumeric(dcoord_n))
        error('Gen. Vel. value  must be numeric.');
    end
    
    if (not(isequal(size(ddcoord_n),[1,1]))) || not(isnumeric(ddcoord_n))
        error('Gen. Accel. value must be numeric.');
    end
 
    
    q_value=[q_value;coord_n];
    dq_value=[dq_value;dcoord_n];
    ddq_value=[ddq_value;ddcoord_n];
    
else
    error('Variable %s already defined in the base workspace',variable_name);
end