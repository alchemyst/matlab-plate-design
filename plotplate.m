function nholes = plotplate(design)
% Dc - Column diameter
% theta - angle subtended by wier
% dh - Hole diameter
% lp - hole pitch
% ls - stiffening/support width

Dc = design.Dc;
theta = design.theta;
dh = design.dh;
lp = design.lp;
ls = design.ls;

rc = Dc/2;
lw = weirlength(design);
[px, py] = circle(0, 0, rc);
% plot downcomers
xw = sqrt(rc^2 - (lw/2)^2);
yw = lw/2;
% Plot column 
if nargout == 0
    plot(px, py);
    hold on
    plot([xw xw nan -xw -xw], [yw -yw nan yw -yw]);
end
% plot holes
dx = sqrt(lp^2 - (lp/2)^2);
offset = 1;
nholes = 0;
shiftx = (rc/dx - floor(rc/dx))*dx;
shifty = (rc/lp - floor(rc/lp))*lp;
for x = (-rc+shiftx:dx:rc)
    for y = offset*lp/2 + (-rc+shifty:lp:rc)
        if sqrt(x^2 + y^2) + dh/2 < rc-ls && abs(x) + dh/2 < xw-ls
            [hx, hy] = circle(x, y, dh/2);
            if nargout == 0
                plot(hx, hy);
            end
            nholes = nholes + 1;
        end
    end
    offset = ~offset;
end
if nargout == 0
    hold off

    grid
    xlim([-rc, +rc])
    ylim([-rc, +rc])
end