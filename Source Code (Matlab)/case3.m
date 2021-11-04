% Use case 3
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
agents{2}.capacity = 2;                 % capacity
agents{2}.availability = 0.95;          % availability
agents{2}.traffic_factor = 0.9;         % traffic factor
agents{2}.operator_efficiency = 1.0;    % efficiency of operator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Station 1
% Position x,y
stations{1}.xy=[80,10];
% Path from actual station to others. Path defined through points x,y in pathto
stations{1}.pathto{1}=[];
stations{1}.pathto{2}=[90,10; 90,40];
stations{1}.pathto{3}=[90,10; 90,90];
stations{1}.pathto{4}=[90,10; 90,90; 10,90];
stations{1}.pathto{5}=[];

% Station 2
% Position x,y
stations{2}.xy=[80,40];
% Path from actual station to others. Path defined through points x,y in pathto
stations{2}.pathto{1}=[];
stations{2}.pathto{2}=[];
stations{2}.pathto{3}=[];
stations{2}.pathto{4}=[];
stations{2}.pathto{5}=[40,40; 40,10];

% Station 3
% Position x,y
stations{3}.xy=[60,90];
% Path from actual station to others. Path defined through points x,y in pathto
stations{3}.pathto{1}=[];
stations{3}.pathto{2}=[];
stations{3}.pathto{3}=[];
stations{3}.pathto{4}=[10,90];
stations{3}.pathto{5}=[10,90; 10,40; 40,40; 40,10];

% Station 4
% Position x,y
stations{4}.xy=[10,55];
% Path from actual station to others. Path defined through points x,y in pathto
stations{4}.pathto{1}=[];
stations{4}.pathto{2}=[];
stations{4}.pathto{3}=[];
stations{4}.pathto{4}=[];
stations{4}.pathto{5}=[10,40; 40,40; 40,10];

% Station 5
% Position x,y
stations{5}.xy=[50,10];
% Path from actual station to others. Path defined through points x,y in pathto
stations{5}.pathto{1}=[60,10];
stations{5}.pathto{2}=[];
stations{5}.pathto{3}=[];
stations{5}.pathto{4}=[];
stations{5}.pathto{5}=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agents - Stations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flowrate{i,j} - i - agent number, j - flowrate to station j
% Negative flowrate indicates return to load station
% Agent 1
stations{1}.flowrate{1,1}=0;
stations{1}.flowrate{1,2}=9;
stations{1}.flowrate{1,3}=5;
stations{1}.flowrate{1,4}=6;
stations{1}.flowrate{1,5}=0;

stations{2}.flowrate{1,1}=0;
stations{2}.flowrate{1,2}=0;
stations{2}.flowrate{1,3}=0;
stations{2}.flowrate{1,4}=0;
stations{2}.flowrate{1,5}=9;

stations{3}.flowrate{1,1}=0;
stations{3}.flowrate{1,2}=0;
stations{3}.flowrate{1,3}=0;
stations{3}.flowrate{1,4}=2;
stations{3}.flowrate{1,5}=3;

stations{4}.flowrate{1,1}=0;
stations{4}.flowrate{1,2}=0;
stations{4}.flowrate{1,3}=0;
stations{4}.flowrate{1,4}=0;
stations{4}.flowrate{1,5}=8;

stations{5}.flowrate{1,1}=-1;
stations{5}.flowrate{1,2}=0;
stations{5}.flowrate{1,3}=0;
stations{5}.flowrate{1,4}=0;
stations{5}.flowrate{1,5}=0;

% Agent 2
stations{1}.flowrate{2,1}=0;
stations{1}.flowrate{2,2}=9;
stations{1}.flowrate{2,3}=5;
stations{1}.flowrate{2,4}=6;
stations{1}.flowrate{2,5}=0;

stations{2}.flowrate{2,1}=0;
stations{2}.flowrate{2,2}=0;
stations{2}.flowrate{2,3}=0;
stations{2}.flowrate{2,4}=0;
stations{2}.flowrate{2,5}=9;

stations{3}.flowrate{2,1}=0;
stations{3}.flowrate{2,2}=0;
stations{3}.flowrate{2,3}=0;
stations{3}.flowrate{2,4}=2;
stations{3}.flowrate{2,5}=3;

stations{4}.flowrate{2,1}=0;
stations{4}.flowrate{2,2}=0;
stations{4}.flowrate{2,3}=0;
stations{4}.flowrate{2,4}=0;
stations{4}.flowrate{2,5}=8;

stations{5}.flowrate{2,1}=-1;
stations{5}.flowrate{2,2}=0;
stations{5}.flowrate{2,3}=0;
stations{5}.flowrate{2,4}=0;
stations{5}.flowrate{2,5}=0;

% Plot
% Axis range
x_min = 0;
x_max = 100;
y_min = 0;
y_max = 100;
% Plots from-to chart
from_to_chart;
title('Case 3')
% Print to file
%print(fig, '-djpeg','case3.jpg')

% Constructing distance and flowarte matrices
get_matrices;