function clearDraws(indexes)
% CLEARDRAWS  clear objects from the Graphical_Output
%
%   CLEARDRAWS() remove all the objects
% in the Graphical Window
%
%   CLEARDRAWS(Draw3D_handle_vector) remove all the objects with handles
% in the vector Draw3D_handle_vector.
%
%   CLEARDRAWS([1, 5, 3]) remove objects
% number 1, 3 and 5 in the Graphical_Output

global Draws

if nargin==0
    delete(Draws);
    Draws(1:end)=[];
else
    if isa(indexes,'handle')
        indexes=indexes(isvalid(indexes))
        Draws_indexes=[];
        for i=1:length(Draws)
            if ismember(Draws(i).lines,[indexes.lines])
                Draws_indexes=[Draws_indexes,i];
            elseif ismember(Draws(i).patchs,[indexes.lines])
                Draws_indexes=[Draws_indexes,i];
            end
        end
        delete(Draws(Draws_indexes));
        Draws(Draws_indexes)=[];
    end
end