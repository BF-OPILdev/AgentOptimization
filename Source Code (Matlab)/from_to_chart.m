% From-to chart map
%
% Version 4.2
%
% Ladislav Körösi, František Duchoň
% NCR - National Centre of Robotics

close all;
fig = figure;
hold on;
grid on;

% Determining the number of stations
num_stations = max(size(stations));

% Plot - Stations
for i = 1:num_stations
    plot(stations{i}.xy(1,1),stations{i}.xy(1,2),'o');
    text(stations{i}.xy(1,1)+2,stations{i}.xy(1,2)+4,num2str(i));
end

% Plot - Crosspoints
for row = 1:num_stations
    for column = 1:num_stations
        % Number of cross points
        [num_points, dummy] = size(stations{row}.pathto{column});
        for c = 1:num_points
            plot(stations{row}.pathto{column}(c,1),stations{row}.pathto{column}(c,2),'*k');
        end
    end
end

% Plot - Path
for row = 1:num_stations
    for column = 1:num_stations
        % Number of cross points
        [num_points, dummy] = size(stations{row}.pathto{column});
        for c = 1:num_points
            if c == 1
                plot([stations{row}.xy(1,1) stations{row}.pathto{column}(c,1)], [stations{row}.xy(1,2) stations{row}.pathto{column}(c,2)],'k');
            else
                plot([stations{row}.pathto{column}(c-1,1) stations{row}.pathto{column}(c,1)], [stations{row}.pathto{column}(c-1,2) stations{row}.pathto{column}(c,2)],'k');
            end
        end
        if c>0
            plot([stations{column}.xy(1,1) stations{row}.pathto{column}(c,1)], [stations{column}.xy(1,2) stations{row}.pathto{column}(c,2)],'k');
        end
    end
end

axis([x_min x_max y_min y_max]);
xlabel('x');
ylabel('y');