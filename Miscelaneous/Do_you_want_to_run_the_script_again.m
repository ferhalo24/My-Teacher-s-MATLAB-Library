global running_full_script_again
running_full_script_again=false;
button = questdlg( 'Do you want to run the FULL SCRIPT again?', 'WARNING', 'Yes', 'No', 'No' );

if strcmp(button,'No')
    running_full_script_again=false;
    error('USER STOPPED EXECUTION');
else
    running_full_script_again=true;
end