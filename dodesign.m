%function dodesign

%% Define properties and flows

properties.rhol = 960.420; % kg/m3
properties.rhov = 1.2685; % kg/m3
flows.Lw = 548.7299364/3600; % kg/sec
flows.Vw = 2178.172/3600; % kg/sec
flows.Vwturndown = 0.5*2178.172/3600; % kg/sec

%% Define design
% dimensions in m
design.Nplates = 22;
design.Dc = 0.2071; % column diameter
design.theta = 1.9; % angle subtended by wier
design.dh = 5e-3; % hole diameter
design.lp = 12e-3; % hole pitch
design.lt = 0.6; % plate spacing
design.ls = 3e-3; % stiffening/support width
design.hw = 50e-3; % wier height
design.hap = design.hw - 10e-3; % aperture height

designvars = {'dh' 'theta' 'lp' 'lt'};
lb = [0.5e-3 1 2*design.dh 0.3];
ub = [1e-3   3 6*design.dh 0.8];
dvec = fieldvals(design, designvars);

% % Define design
% factors = designfactors(properties, flows, design);
% constraints = plateconstraints(properties, flows, design)
% Plot plate and downcomer arrangement
goalfun = @(dvec) columncost(fieldset(design, designvars, dvec));

% function [c, ceq] = confunc(dvec)
%     [c, ceq] = checkconstraints(properties, flows, fieldset(design, designvars, dvec));
% end

%optdvec = fmincon(goalfun, dvec, [], [], [], [], lb, ub, @confunc);
optdvec = psa(goalfun, @(dvec) checkconstraints(properties, flows, fieldset(design, designvars, dvec)), ...
    length(dvec), lb, ub, @(dvec) plotcol(properties, flows, fieldset(design, designvars, dvec)));
design = fieldset(design, designvars, optdvec)
%end
