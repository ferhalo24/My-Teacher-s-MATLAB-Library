function Error(sentence)
global pop_up_dialogs
if pop_up_dialogs==true
    waitfor(msgbox(sentence,'Error','error'));
end
error('sentence');