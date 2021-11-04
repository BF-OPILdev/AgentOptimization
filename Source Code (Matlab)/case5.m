% Use case 5
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
agents{2}.capacity = 100;                 % capacity
agents{2}.availability = 0.95;          % availability
agents{2}.traffic_factor = 0.9;         % traffic factor
agents{2}.operator_efficiency = 1.0;    % efficiency of operator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Station 1
% Position x,y
stations{1}.xy=[55,10];
% Path from actual station to others. Path defined through points x,y in pathto
stations{1}.pathto{1}=[];
stations{1}.pathto{2}=[100,10];
stations{1}.pathto{3}=[];
stations{1}.pathto{4}=[];
stations{1}.pathto{5}=[];
stations{1}.pathto{6}=[];
stations{1}.pathto{7}=[];

% Station 2
% Position x,y
stations{2}.xy=[100,30];
% Path from actual station to others. Path defined through points x,y in pathto
stations{2}.pathto{1}=[];
stations{2}.pathto{2}=[];
stations{2}.pathto{3}=[100,50];
stations{2}.pathto{4}=[];
stations{2}.pathto{5}=[];
stations{2}.pathto{6}=[];
stations{2}.pathto{7}=[];

% Station 3
% Position x,y
stations{3}.xy=[100,75];
% Path from actual station to others. Path defined through points x,y in pathto
stations{3}.pathto{1}=[];
stations{3}.pathto{2}=[];
stations{3}.pathto{3}=[];
stations{3}.pathto{4}=[100,100];
stations{3}.pathto{5}=[];
stations{3}.pathto{6}=[100,100;10,100];
stations{3}.pathto{7}=[];

% Station 4
% Position x,y
stations{4}.xy=[100,125];
% Path from actual station to others. Path defined through points x,y in pathto
stations{4}.pathto{1}=[];
stations{4}.pathto{2}=[];
stations{4}.pathto{3}=[];
stations{4}.pathto{4}=[];
stations{4}.pathto{5}=[100,150];
stations{4}.pathto{6}=[];
stations{4}.pathto{7}=[];

% Station 5
% Position x,y
stations{5}.xy=[55,150];
% Path from actual station to others. Path defined through points x,y in pathto
stations{5}.pathto{1}=[];
stations{5}.pathto{2}=[];
stations{5}.pathto{3}=[];
stations{5}.pathto{4}=[];
stations{5}.pathto{5}=[];
stations{5}.pathto{6}=[10,150;10,100];
stations{5}.pathto{7}=[];

% Station 6
% Position x,y
stations{6}.xy=[10,75];
% Path from actual station to others. Path defined through points x,y in pathto
stations{6}.pathto{1}=[];
stations{6}.pathto{2}=[];
stations{6}.pathto{3}=[];
stations{6}.pathto{4}=[];
stations{6}.pathto{5}=[];
stations{6}.pathto{6}=[];
stations{6}.pathto{7}=[10,50];

% Station 7
% Position x,y
stations{7}.xy=[10,10];
% Path from actual station to others. Path defined through points x,y in pathto
stations{7}.pathto{1}=[35,10];
stations{7}.pathto{2}=[];
stations{7}.pathto{3}=[];
stations{7}.pathto{4}=[];
stations{7}.pathto{5}=[];
stations{7}.pathto{6}=[];
stations{7}.pathto{7}=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agents - Stations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flowrate{i,j} - i - agent number, j - flowrate to station j
% Negative flowrate indicates return to load station
% Agent 1
stations{1}.flowrate{1,1}=0;
stations{1}.flowrate{1,2}=200;
stations{1}.flowrate{1,3}=0;
stations{1}.flowrate{1,4}=0;
stations{1}.flowrate{1,5}=0;
stations{1}.flowrate{1,6}=0;
stations{1}.flowrate{1,7}=0;

stations{2}.flowrate{1,1}=0;
stations{2}.flowrate{1,2}=0;
stations{2}.flowrate{1,3}=200;
stations{2}.flowrate{1,4}=0;
stations{2}.flowrate{1,5}=0;
stations{2}.flowrate{1,6}=0;
stations{2}.flowrate{1,7}=0;

stations{3}.flowrate{1,1}=0;
stations{3}.flowrate{1,2}=0;
stations{3}.flowrate{1,3}=0;
stations{3}.flowrate{1,4}=100;
stations{3}.flowrate{1,5}=0;
stations{3}.flowrate{1,6}=100;
stations{3}.flowrate{1,7}=0;

stations{4}.flowrate{1,1}=0;
stations{4}.flowrate{1,2}=0;
stations{4}.flowrate{1,3}=0;
stations{4}.flowrate{1,4}=0;
stations{4}.flowrate{1,5}=100;
stations{4}.flowrate{1,6}=0;
stations{4}.flowrate{1,7}=0;

stations{5}.flowrate{1,1}=0;
stations{5}.flowrate{1,2}=0;
stations{5}.flowrate{1,3}=0;
stations{5}.flowrate{1,4}=0;
stations{5}.flowrate{1,5}=0;
stations{5}.flowrate{1,6}=100;
stations{5}.flowrate{1,7}=0;

stations{6}.flowrate{1,1}=0;
stations{6}.flowrate{1,2}=0;
stations{6}.flowrate{1,3}=0;
stations{6}.flowrate{1,4}=0;
stations{6}.flowrate{1,5}=0;
stations{6}.flowrate{1,6}=0;
stations{6}.flowrate{1,7}=200;

stations{7}.flowrate{1,1}=-1;
stations{7}.flowrate{1,2}=0;
stations{7}.flowrate{1,3}=0;
stations{7}.flowrate{1,4}=0;
stations{7}.flowrate{1,5}=0;
stations{7}.flowrate{1,6}=0;
stations{7}.flowrate{1,7}=0;

% Agent 2
stations{1}.flowrate{2,1}=0;
stations{1}.flowrate{2,2}=200;
stations{1}.flowrate{2,3}=0;
stations{1}.flowrate{2,4}=0;
stations{1}.flowrate{2,5}=0;
stations{1}.flowrate{2,6}=0;
stations{1}.flowrate{2,7}=0;

stations{2}.flowrate{2,1}=0;
stations{2}.flowrate{2,2}=0;
stations{2}.flowrate{2,3}=200;
stations{2}.flowrate{2,4}=0;
stations{2}.flowrate{2,5}=0;
stations{2}.flowrate{2,6}=0;
stations{2}.flowrate{2,7}=0;

stations{3}.flowrate{2,1}=0;
stations{3}.flowrate{2,2}=0;
stations{3}.flowrate{2,3}=0;
stations{3}.flowrate{2,4}=100;
stations{3}.flowrate{2,5}=0;
stations{3}.flowrate{2,6}=100;
stations{3}.flowrate{2,7}=0;

stations{4}.flowrate{2,1}=0;
stations{4}.flowrate{2,2}=0;
stations{4}.flowrate{2,3}=0;
stations{4}.flowrate{2,4}=0;
stations{4}.flowrate{2,5}=100;
stations{4}.flowrate{2,6}=0;
stations{4}.flowrate{2,7}=0;

stations{5}.flowrate{2,1}=0;
stations{5}.flowrate{2,2}=0;
stations{5}.flowrate{2,3}=0;
stations{5}.flowrate{2,4}=0;
stations{5}.flowrate{2,5}=0;
stations{5}.flowrate{2,6}=100;
stations{5}.flowrate{2,7}=0;

stations{6}.flowrate{2,1}=0;
stations{6}.flowrate{2,2}=0;
stations{6}.flowrate{2,3}=0;
stations{6}.flowrate{2,4}=0;
stations{6}.flowrate{2,5}=0;
stations{6}.flowrate{2,6}=0;
stations{6}.flowrate{2,7}=200;

stations{7}.flowrate{2,1}=-1;
stations{7}.flowrate{2,2}=0;
stations{7}.flowrate{2,3}=0;
stations{7}.flowrate{2,4}=0;
stations{7}.flowrate{2,5}=0;
stations{7}.flowrate{2,6}=0;
stations{7}.flowrate{2,7}=0;

% Plot
% Axis range
x_min = 0;
x_max = 110;
y_min = 0;
y_max = 160;
% Plots from-to chart
from_to_chart;
title('Case 5')
% Print to file
%print(fig, '-djpeg','case5.jpg')

% Constructing distance and flowarte matrices
get_matrices;