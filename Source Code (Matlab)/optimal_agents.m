% Canculation of optimal number of agents
%
% Version 4.2
%
% Ladislav Körösi, František Duchoň
% NCR - National Centre of Robotics

function [opt_agv_num] = optimal_agents(fromto_flowrate, fromto_distances, vc, Tl, Tu, w, capacity, availability, traffic_factor, operator_efficiency)

% Overview of variables
% fromto_flowrate - agents flowrate matrix
% fromto_distances - distance matrix
% Tc - delivery cycle time [min/del]
% Tl - time to load at load station [min]
% Ld - distance the vehicle travels between load and unload station [m]
% vc - carrier velocity [m/min]
% Tu - time to unload at unload station [min]
% Le - distance the vehicle travels empty until the start of the next delivery cycle [m]
% w  - Required delieveries
% capacity - agent capacity {pcs}
% availability - availability factor
% traffic_factor - traffic factor
% operator_efficiency - operator efficiency

% Finding the matrix sizes
[flowrate_a, flowrate_b] = size(fromto_flowrate);
[distances_a, distances_b] = size(fromto_distances);

% Data consistency chceck
if (flowrate_a ~= distances_a) | (flowrate_b ~= distances_b) 
    error('ERR: The flowrate, distances and alldistances matrixes should have the same dimensions');
end
fromto_a = flowrate_a;
fromto_b = flowrate_b;

% Calculation of Ld
num = 0;
den = 0;
Le = 0;
for i = 1:fromto_a
    for j = 1:fromto_b
        % Positive flow rate => normal rate, negative flow rate => indicates the return point
        if fromto_flowrate(i,j) > 0
            num = num + fromto_flowrate(i,j) * fromto_distances(i,j);
            den = den + fromto_flowrate(i,j);
        else
            Le =  Le + fromto_distances(i,j);
        end
    end
end
Ld = (num / capacity )/ den
Le

% Calculation of Tc
Tc = Tl + Ld/vc + Tu + Le/vc;
sprintf ("Ideal cycle time per delivery per vehicle is [min] %1.3f", Tc)

WL = w * Tc
sprintf ("Ideal cycle time per delivery per vehicle is [min / hr] %1.3f", WL)

AT = 60 * availability * traffic_factor * operator_efficiency
sprintf ("Available time per hour per vehicle [min/hr per vehicle] %1.3f", AT)

AT = WL / AT;
sprintf ("Number of required vehicles %1.3f", AT)

AT = ceil (AT);
sprintf ("Rounded number of required vehicles %1.0f", AT)

opt_agv_num = AT;
end

