function my_closereq(src,callbackdata)
global running_full_script_again
if running_full_script_again
    delete(gcf);
    running_full_script=false;
else
    % Close request function
    % to display a question dialog box
    selection = questdlg('Close This Figure Lib_3D_MEC_MATLAB requires it?',...
        'Close Request Function',...
        'Yes','No','Yes');
    switch selection,
        case 'Yes',
            delete(gcf)
        case 'No'
            return
    end
end
end