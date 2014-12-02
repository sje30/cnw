%Plots Contours of Lyapunov function for divisive feedback network
clear all;
whitebg('w');
XX = -2:0.1:7;
YY = 0:0.1:14;
[X, Y] = meshgrid(XX, YY);
U = (1/2)*(-X + 10./(1+Y)).^2 + (1/2)*(-Y + 2*X).^2;

DX = zeros(1, 200);
DY = zeros(1, 200);

%**********initial conditions
DX(1) = 4;
DY(1) = 4;
%**********

for T = 2:400;  %Simple Euler's method simulation of a trajectory
	DX(T) = DX(T-1) + 0.01*(-DX(T-1) + 10/(1 + DY(T-1)));
	DY(T) = DY(T-1) + 0.01*(-DY(T-1) + 2*DX(T-1));
end;	
figure(1), contour(XX, YY, U, [0.5, 3, 8, 14.54]); axis square;
hold on;
plot(DX, DY, 'r-'); 
xlabel('X'); ylabel('Y');
title('X-Y Phase Plane with Lyapunov Function Contours');
hold off;
