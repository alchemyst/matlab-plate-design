function plotdowncomer(design, constraints, factors)
% Side view of plate arrangement
% after C&R figure 11.35

lt = design.lt;

% side view plate width
platewidth = design.Dc*(1 + cos(design.theta/2))/2;
gapwidth = design.Dc - platewidth;
% walls
plot([0 0 nan design.Dc design.Dc], [-lt/2 lt*3/2 nan -lt/2 lt*3/2], 'linewidth', 3);
hold on
% Plates
plot([0 platewidth nan gapwidth design.Dc], [0 0 nan lt lt], 'linewidth', 2);
% Downcomers
plot([platewidth platewidth nan gapwidth gapwidth], [0 design.hw nan design.hap lt+design.hw], 'linewidth', 2);
% liquid
if nargin > 1
    patch([0 gapwidth gapwidth platewidth platewidth 0], [constraints.hb constraints.hb design.hap design.hw+factors.how 0 0], [1 .6 .6]);
end
hold off
xlim([0 design.Dc])
