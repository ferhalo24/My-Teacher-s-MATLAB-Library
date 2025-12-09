function run_simulation(simulation_file_name,integrator_type,permission)
updateDraws_automatic=false;

fid = fopen(simulation_file_name,permission);
printf_extended_state_header(fid);
printf_extended_state(fid);

dynamic_simulation(fid,integrator_type);

fclose(fid);

updateDraws_automatic=true;
end