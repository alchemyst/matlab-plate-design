function [gx, gbest] = psa(func, cfunc, DIM, lb, ub, updatefunc, linit, uinit)

IPOP = 20;
IMAX = 20000;

if nargin <= 6
    linit = lb;
    uinit = ub;
end

if length(uinit) == 1 % scalar constraints
    ubcols = DIM;
else
    ubcols = 1;
end

if length(linit) == 1
    lbcols = DIM;
else
    lbcols = 1;
end

maxx = repmat(uinit, IPOP, ubcols);
minx = repmat(linit, IPOP, lbcols);

function f = longfunc(X)
    f = zeros(IPOP, 1);
    for ii = 1:IPOP
        xx = X(ii, :);
        if any(xx < lb) || any(xx > ub) || ~all(cfunc(xx) < 0)
            f(ii) = inf;
        else
            f(ii) = func(xx);
        end
    end
end

c1 = 2.0;
c2 = 2.0;
w = 0.7;

x = rand(IPOP, DIM).*(maxx - minx) + minx;
v = zeros(IPOP, DIM);
f = longfunc(x);
[gbest, gpos] = min(f);
gx = x(gpos, :);
px = x;
pbest = f;

ichange = [];
fchange = [];

for i = 1:IMAX
    v = w*v + c1*rand(IPOP, DIM).*(px - x) + c2*rand(IPOP, DIM).*(gx(ones(IPOP, 1), :) - x);
    x = x + v;
    f = longfunc(x);
    match = pbest < f;
    pbest(match) = f(match);
    px(match, :) = x(match, :);
    
    [fmax, maxpos] = min(f);
    if fmax < gbest
        ichange = [ichange i];
        fchange = [fchange fmax];
        figure(2)
        plot(ichange, fchange);
        gbest = fmax;
        gx = x(maxpos, :);
        figure(1);
        updatefunc(gx);
    end
    if ~mod(i, 100)
        fprintf('i = %i, gbest = %f ', i, gbest);
        disp(gx);
    end
end

end
