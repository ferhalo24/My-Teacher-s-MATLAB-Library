function purgeDraws();
global Draws

try
    delete(Draws);
catch
    fprintf('Handles in Draws already deleted\n', i);
end


delete('*_vector.m')
delete('*_transform.m')
delete('*_traj.m')
end