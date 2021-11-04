% Use case 1
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
stations{1}.xy=[60,10];
% Path from actual station to others. Path defined through points x,y in pathto
stations{1}.pathto{1}=[];
stations{1}.pathto{2}=[70,10; 70,40];
stations{1}.pathto{3}=[];

% Station 2
% Position x,y
stations{2}.xy=[60,40];
% Path from actual station to others. Path defined through points x,y in pathto
stations{2}.pathto{1}=[];
stations{2}.pathto{2}=[];
stations{2}.pathto{3}=[20,40];

% Station 3
% Position x,y
stations{3}.xy=[20,20];
% Path from actual station to others. Path defined through points x,y in pathto
stations{3}.pathto{1}=[20,10];
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
title('Case 1')
% Print to file
%print(fig, '-djpeg','case1.jpg')

% Constructing distance and flowarte matrices
get_matrices;