function deleteDraw(i)
global Draws
delete(Draws(i));
Draws=[Draws(1:i-1),Draws(i+1:end)];
end