% Canculation of additional non existing distance for flowrate
%
% Version 4.2
%
% Ladislav Körösi, František Duchoň
% NCR - National Centre of Robotics

function [path_s] = calc_new_distances(num_stations, station, from, to, fromto_distances, path_v)

% Empty path as string
path_s = [];

% Deciding if it's the the end of path or not
if fromto_distances(station, to) ~= 0
    % We have reached the end station no. to. We add it to path vector
    path_v = [path_v to];
    
    % Constructing string path as station_from->station_x->station_y->etc.->station_to->
    path_s = "";
    for i = 1:max(size(path_v))
        path_s = path_s + num2str(path_v(i)) + "->";
    end
    
    % Calculating the distance:
    %   station_from -> station_x
    %   station_x -> station_y
    %   etc.
    %   penultimate station -> station_to
    d = 0;
    for i = 1:max(size(path_v))-1
        d = d + fromto_distances(path_v(i), path_v(i+1));
    end
    % Add it to path as string between % and $ characters
    path_s = path_s + " #" + num2str(d) + "$";
    
    return;
else
    % Determine if we are searching the path from the same station twice
    % Example: path_v = [1 2 3 2] - station 2 is twice and it's not allowed
    % (due infinity recursice search)
    if max(size(find(path_v==path_v(end))))>1
        return;
    end
    
    % Searching alternative path
    for i = 1:num_stations
        % If there is a distance, chceck the path.
        % i - becames the row (station number from we will continue the
        % search); i is added to path
        if fromto_distances(station, i) > 0
            [path_ret] = calc_new_distances(num_stations, i, from, to, fromto_distances, [path_v i]);
            % Save the path
            % If there is no path to destination, this is unchanged due [] value
            % If the destination was found, we start new line in vector
            path_s = [path_s; path_ret];
        end
    end
end

end