% Use case 2
%
% Version 4.2
%
% Ladislav Körösi, František Duchoň
% NCR - National Centre of Robotics

clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agent 1
agents{1}.agent_speed = 50;             % agent speed
agents{1}.Tl = 0.75;                    % load time
agents{1}.Tu = 0.5;                     % unload time
agents{1}.capacity = 1;                 % capacity
agents{1}.availability = 0.95;          % availability
agents{1}.traffic_factor = 0.9;         % traffic factor
agents{1}.operator_efficiency = 1.0;    % efficiency of operator

% Agent 2
agents{2}.agent_speed = 50;             % agent speed
agents{2}.Tl = 0.75;                    % load time
agents{2}.Tu = 0.5;                     % unload time
agents{2}.capacity = 1;                 % capacity
agents{2}.availability = 0.95;          % availability
agents{2}.traffic_factor = 0.9;         % traffic factor
agents{2}.operator_efficiency = 1.0;    % efficiency of operator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Station 1
% Position x,y
stations{1}.xy=[60,10];
% Path from actual station to others. Path defined through points x,y in pathto
stations{1}.pathto{1}=[];
stations{1}.pathto{2}=[70,10; 70,20; 80,20; 80,30; 70,30; 70,40];
stations{1}.pathto{3}=[];

% Station 2
% Position x,y
stations{2}.xy=[60,40];
% Path from actual station to others. Path defined through points x,y in pathto
stations{2}.pathto{1}=[];
stations{2}.pathto{2}=[];
stations{2}.pathto{3}=[50,40; 50,60; 30,60; 30,50; 40,50; 40,40; 20,40];

% Station 3
% Position x,y
stations{3}.xy=[20,20];
% Path from actual station to others. Path defined through points x,y in pathto
stations{3}.pathto{1}=[20,10; 30,10; 30,0; 40,0; 40,10];
stations{3}.pathto{2}=[];
stations{3}.pathto{3}=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agents - Stations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flowrate{i,j} - i - agent number, j - flowrate to station j
% Negative flowrate indicates return to load station
% Agent 1
stations{1}.flowrate{1,1}=0;
stations{1}.flowrate{1,2}=10;
stations{1}.flowrate{1,3}=0;

stations{2}.flowrate{1,1}=0;
stations{2}.flowrate{1,2}=0;
stations{2}.flowrate{1,3}=15;

stations{3}.flowrate{1,1}=-1;
stations{3}.flowrate{1,2}=0;
stations{3}.flowrate{1,3}=0;

% Agent 2
stations{1}.flowrate{2,1}=0;
stations{1}.flowrate{2,2}=10;
stations{1}.flowrate{2,3}=0;

stations{2}.flowrate{2,1}=0;
stations{2}.flowrate{2,2}=0;
stations{2}.flowrate{2,3}=15;

stations{3}.flowrate{2,1}=-1;
stations{3}.flowrate{2,2}=0;
stations{3}.flowrate{2,3}=0;

% Plot
% Axis range
x_min = 0;
x_max = 100;
y_min = 0;
y_max = 100;
% Plots from-to chart
from_to_chart;
title('Case 2')
% Print to file
%print(fig, '-djpeg','case2.jpg')

% Constructing distance and flowarte matrices
% Calculating the flowrate and distance matrices
%
% Version 4.2
%
% Ladislav Körösi, František Duchoň
% NCR - National Centre of Robotics

% Determining the number of stations
num_stations = max(size(stations));
% Determining the number of agents
num_agents = max(size(agents));
% Required deliveries for all agents
w = zeros(1, num_agents);

% Empty from-to matrices with num_stations by num_stations size
% a - agent number
for a = 1:num_agents
    fromto_flowrate{a} = zeros(num_stations,num_stations);
end
% Distance matrix is only one (for all agents)
fromto_distances = zeros(num_stations,num_stations);

% Constructing the flowrate and distances matrices
for a = 1:num_agents
    for row = 1:num_stations
        for column = 1:num_stations
            fromto_flowrate{a}(row,column) = stations{row}.flowrate{a,column};
            % Calculating required deliveries from flowrate matrix
            if fromto_flowrate{a}(row,column)>0
                w(a) = w(a) + fromto_flowrate{a}(row,column);
            end
            % Calculating the distance (only for 1st agent)
            if a == 1
                [num_points, dummy] = size(stations{row}.pathto{column});
                d = 0;
                if num_points > 0
                    for c = 1:num_points
                        if c == 1
                            % From station to next point
                            d = d + sqrt((stations{row}.xy(1,1) - stations{row}.pathto{column}(c,1))^2 + (stations{row}.xy(1,2) - stations{row}.pathto{column}(c,2))^2);
                        else
                            % Between points
                            d = d + sqrt((stations{row}.pathto{column}(c-1,1) - stations{row}.pathto{column}(c,1))^2 + (stations{row}.pathto{column}(c-1,2) - stations{row}.pathto{column}(c,2))^2);
                        end
                    end
                    % Last point and next station
                    d = d +  sqrt((stations{column}.xy(1,1) - stations{row}.pathto{column}(c,1))^2 + (stations{column}.xy(1,2) - stations{row}.pathto{column}(c,2))^2);
                end
                % Assigning calculated distance into matrix
                fromto_distances(row,column) = d;
            end
        end
    end
end

% Validating distance matrix using flowrate values
% If flowrate is defined without distance, the distance si automatically calculated
% a, using the existing interconections (if exist)
% b, using euclidean norm
for a = 1:num_agents
    for from = 1:num_stations
        for to = 1:num_stations
            if fromto_flowrate{a}(from,to)>0 && fromto_distances(from,to)==0           
                % Flowrate without distance
                sprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                sprintf("Flowrate defined without distance from station %d to station %d for agent %d", from, to, a)
                
                station = from;
                [path_s] = calc_new_distances(num_stations, station, from, to, fromto_distances, [from]);
                
                if max(size(path_s)) > 0
                    sprintf("At least one path found:")
                    path_s
                    
                    d = [];
                    for i= 1:max(size(path_s))
                        d = [d str2num(extractBetween(path_s(i), strfind(path_s(i),"#")+1, strfind(path_s(i),"$")-1))];
                    end
                    
                    fromto_distances(from,to) = min(d);
                    sprintf("Using minimum distance: %1.3f", min(d))
                else
                    fromto_distances(from,to) = sqrt((stations{from}.xy(1,1) - stations{to}.xy(1,1))^2 + (stations{from}.xy(1,2) - stations{to}.xy(1,2))^2);
                    sprintf("Existing path not found. Using euclidian distance:  %1.3f", fromto_distances(from,to))
                end
            end
        end
    end
end

% Display the flowrate and distances matrices
display ("*********************************************************");
display ("*********************************************************");
sprintf ("Distance matix for all agents")
fromto_distances
for a = 1:1
    display ("*********************************************************");
    display ("*********************************************************");
    sprintf ("Flowrate matix for agent %d",a)
    fromto_flowrate{a}
    display ("*********************************************************");
    
    % Call the optimisation
    %[opt_agv_num] = optimal_agents(fromto_flowrate{a}, fromto_distances, agents{a}.agent_speed, agents{a}.Tl, agents{a}.Tu, w(a), agents{a}.capacity, agents{a}.availability, agents{a}.traffic_factor, agents{a}.operator_efficiency)
end