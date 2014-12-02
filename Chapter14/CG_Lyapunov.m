%Plots Contours of Lyapunov function for divisive feedback network
clear all;
whitebg('w');
R1 = 0:100;
R2 = 0:100;
[X, Y] = meshgrid(R1, R2);
Sx = 100*(0.25*X).^2./(100 + (0.25*X).^2);
Sy = 100*(0.25*Y).^2./(100 + (0.25*Y).^2);
F = 4000*atan(0.025*X) - 100*X + X.*Sx;
G = 4000*atan(0.025*Y) - 100*Y + Y.*Sy;
U = F + G -Sx.*Sy;
figure(1), contour(X, Y, U, [109, -100, -400, -600, -700, -740]); axis square;
axis([-10 100 -10 100]);
xlabel('R1'); ylabel('R2');
axis([0, 100, 0, 100]);
