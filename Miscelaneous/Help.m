function Help(sentence)
global pop_up_dialogs
if pop_up_dialogs==true
    waitfor(msgbox(sentence,'Notice','help'));
end
