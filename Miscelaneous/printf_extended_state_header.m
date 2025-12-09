function out=printf_extended_state_header(fid)
global t
global q
global dq
global ddq
global epsilon
global lambda
global lambda_aux
global param



head_data = [t;q;dq;ddq;epsilon;lambda;lambda_aux;param];
out_str = ['%%'];
for i=1:length(head_data)-1
    out_str=[out_str,char(head_data(i)),'  '];
end
out_str=[out_str,char(head_data(i+1)),['\n']];

out=fprintf(fid,out_str);