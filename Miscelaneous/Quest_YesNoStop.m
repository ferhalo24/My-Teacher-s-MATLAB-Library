function answer=Quest_YesNoStop(question_string,default)
global pop_up_dialogs
if nargin==1
    default='Yes'
end
if pop_up_dialogs==true
    button = questdlg(question_string, 'Question', 'Yes', 'No', 'Stop', default );
    if strcmp(button,'No')
        answer=false;
    elseif strcmp(button,'Yes')
        answer=true;
    else
        error('USER STOPPED EXECUTION');
    end
else
    if strcmp(default,'No')
        answer=false;
    elseif strcmp(default,'Yes')
        answer=true;
    else
        error('USER STOPPED EXECUTION');
    end
end