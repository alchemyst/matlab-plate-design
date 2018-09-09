function factors = designfactors(properties, flows, design)
factors.Flv = max(0.01, flows.Lw/flows.Vw*sqrt(properties.rhov/properties.rhol)); % C&R eq 11.82
fl = load('flooding');
factors.K1 = interp2(fl.Flv, fl.lt, fl.K1, factors.Flv, design.lt, 'spline', 1e-1);
factors.how = 0.750*(flows.Lw/properties.rhol/weirlength(design))^(2/3);
h_liq = factors.how + design.hw;
wp = load('weep_point');
factors.K2 = interp1(wp.h_liq, wp.K2, h_liq);


