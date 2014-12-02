%Plots Contours of Lyapunov function for divisive feedback network
clear all;
whitebg('w');
RR = 1:10:1000;
WW = 1:2:100;
[R, W] = meshgrid(RR, WW);
U = (1/10)*log(W) + (1/2)*log(R) - W/200 - R/1000;
figure(1), contour(RR, WW, U, [2.68, 2.7, 2.75, 2.79, 2.86]);
xlabel('Rabbits'); ylabel('Wolves');
