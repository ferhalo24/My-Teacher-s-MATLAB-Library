function showEigenvalues(eigenvalues,n_digits)
if nargin==1
    n_digits='%0.5f';
end
CreateStruct.Interpreter= 'latex';
CreateStruct.WindowStyle= 'modal';
for i=1:length(eigenvalues)
    real_part=real(eigenvalues(i));
    imag_part=imag(eigenvalues(i));
    if real_part>=0
        output_str{i}=['$\boldmath{\sigma_',num2str(i),'} =$ +',num2str(real_part,n_digits)];
    else
        output_str{i}=['$\boldmath{\sigma_',num2str(i),'} =$ --',num2str(abs(real_part),n_digits)];
    end
    if imag_part>=0
        output_str{i}=[output_str{i},'+',num2str(imag_part,n_digits),'i'];
    else
        output_str{i}=[output_str{i},'--',num2str(abs(imag_part),n_digits),'i'];
    end
end
msgbox(output_str,'Eigenvalues',CreateStruct);