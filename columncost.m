function c = columncost(design)
% as first approximation, use the volume for the cost
c = design.Dc^2*design.lt*design.Nplates;
