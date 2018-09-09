function [c, ceq] = checkconstraints(properties, flows, design)
constraints = plateconstraints(properties, flows, design);
% flooding < 90 %
c(1) = constraints.fracflood - 0.85;
% entrainment: psi less than 0.1 (may not yield optimal design)
c(2) = constraints.psi - 0.2;
% weeping
c(3) = constraints.uhmin - constraints.uhturndown;
% backup
c(4) = constraints.hb - 0.5*(design.lt+design.hw); % eq 11.94
% Downcomer residence time
c(5) = 3 - constraints.tr; % More than three seconds residence in downcomer
% Pressure drop per plate in pascal (<1 kPa)
c(6) = constraints.deltapt - 2000;
ceq = [];
