function plotcol(properties, flows, design)
constraints = plateconstraints(properties, flows, design);
factors = designfactors(properties, flows, design);
subplot(1, 2, 1)
plotplate(design);
axis square
subplot(1, 2, 2);
plotdowncomer(design, constraints, factors);
drawnow;
