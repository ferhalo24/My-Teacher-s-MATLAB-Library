function Warning(sentence)
global pop_up_dialogs
if pop_up_dialogs==true
    waitfor(msgbox(sentence,'Warning','warn'));
else
    warning(sentence)
end