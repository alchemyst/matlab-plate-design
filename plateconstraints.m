function c = plateconstraints(properties, flows, design)
factors = designfactors(properties, flows, design);
Nholes = plotplate(design);
volflow_v = flows.Vw/properties.rhov;
volflowturndown_v = flows.Vwturndown/properties.rhov;
% areas
Ad_over_Ac = (design.theta - sin(design.theta))/(2*pi);
Ac = pi*design.Dc^2/4;
Ad = Ad_over_Ac*Ac;
Ah = Nholes*pi*design.dh^2/4;
An = Ac - Ad;
Ap = Ac - 2*Ad;
Ah_over_Ap = Ah/Ap;

% Flooding
c.uf = factors.K1*sqrt((properties.rhol - properties.rhov)/properties.rhov); % C&R eq 11.81
c.fracflood = volflow_v/An/c.uf;

% Entrainment
ent = load('entrainment');
% upper limit on psi should be 0.1
c.psi = interp2(ent.Flv, ent.percflood/100, ent.psi, factors.Flv, c.fracflood, 'linear', inf);
% Weeping
c.uhmin = (factors.K2 - 0.9*(25.4 - design.dh))/sqrt(properties.rhov);
c.uh = volflow_v/Ah; % velocity through holes
c.uhturndown = volflowturndown_v/Ah; % velocity through holes at turndown
% Pressure drop
% FIXME: Assumed this plate thickness/hole diameter is a constant -- get
% from figure 11.34
%Ah_over_Ap = 0.9*(design.dh/design.lp)^2;
C0 = interp1([0 20]/100, [0.76 0.925], Ah_over_Ap);
c.hd = 51e-3*(c.uh/C0)^2*properties.rhov/properties.rhol; % C&R eq 11.88 modified for m instead of mm
c.hr = 12.5/properties.rhol; % C&R eq 11.89 modified for m instead of mm
c.ht = c.hd + (design.hw + factors.how) + c.hr; % C&R eq 11.90

g = 9.807;
c.deltapt = properties.rhol*g*c.ht;

% Downcomer backup
Aap = design.hap*weirlength(design);
Am = min(Ad, Aap);
c.hdc = 0.166*(flows.Lw/properties.rhol/Am)^2; % C&R eq 11.92 modified for m instead of mm
c.hb = (design.hw + factors.how) + c.ht + c.hdc; 

% Downcomer residence time
c.tr = Ad*c.hb*properties.rhol/flows.Lw;
