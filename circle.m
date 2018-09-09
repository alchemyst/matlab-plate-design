function [x, y] = circle(cx, cy, r)
N = 300;
theta = linspace(0, 2*pi, N);
y = r*sin(theta) + cy;
x = r*cos(theta) + cx;
