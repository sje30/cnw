%Fourth Order Runge-Kutta for N-Dimensional Systems
clear all; hold off; clc; close all;
Total_Equations = 2;  %Solve for this number of interacting Neurons
DT = 2;  %Time increment as fraction of time constant
Final_Time = 400;   %Final time value for calculation
Last = Final_Time/DT + 1;  %Last time step
Time = DT*[0:Last-1];  %Time vector
Tau = 20;  %Neural time constants in msec
WTS = [1 2 2 1];  %Runge-Kutta Coefficient weights
for NU = 1:Total_Equations;  %Initialize
	X(NU, :) = zeros(1, Last);  %Vector to store response of Neuron #1
	K(NU, :) = zeros(1, 4);  %Runge-Kutta terms	
	X(1, 1) = 1;  %Initial conditions here if different from zero
	X(2, 1) = 0;  %Initial conditions here if different from zero
	Weights(NU, :) = WTS;  %Make into matrix for efficiency in main loop
end;
Wt2 = [0 .5 .5 1];  %Second set of RK weights
rkIndex = [1 1 2 3];
K1 = input('Stimulus to Neuron 1 (> 50) = ');
K2 = input('Stimulus to Neuron 2 (> 50) = ');
T1 = clock;
for T = 2:Last;
  for rk = 1:4  %Fourth Order Runge-Kutta
	XH = X(:, T-1) + K(:, rkIndex(rk))*Wt2(rk);
	Tme =Time(T-1) + Wt2(rk)*DT;  %Time upgrade
	
	PSP1 = (K1 - 3*XH(2))*(XH(2) < K1/3);	
	PSP2 = (K2 - 3*XH(1))*(XH(1) < K2/3);		
 	K(1, rk) = DT/Tau*(-XH(1) + 100*(PSP1)^2/(120^2 + (PSP1)^2));  %Your Equation Here
  	K(2, rk) = DT/Tau*(-XH(2) + 100*(PSP2)^2/(120^2 + (PSP2)^2));    %Your Equation Here

 end;
	X(:, T) = X(:, T-1) + sum((Weights.*K)')'/6;  %Most efficient with weight matrix
end;
Calculation_Time = etime(clock, T1)
whitebg('w');
maxiso = ceil(max(max(X')));
Xiso = 0:maxiso;  %X for Isoclines
Isocline1 = 100*(K2 - 3*Xiso).^2./(120^2 + (K2 - 3*Xiso).^2).*(3*Xiso < K2);
Isocline2 = 100*(K1 - 3*Xiso).^2./(120^2 + (K1 - 3*Xiso).^2).*(3*Xiso < K1);
figure(1); Za = plot(Time, X(1, :), 'r', Time, X(2, :), 'b'); set(Za, 'LineWidth', 2);
xlabel('Time (ms)'); ylabel('E1 (red) & E2 (blue)');  
figure(2); Zb = plot(X(1, :), X(2, :), '-r', Xiso, Isocline1, '-k', Isocline2, Xiso, '--k'); set(Zb, 'LineWidth', 2); axis square;
xlabel('E1'); ylabel('E2'); title('Phase Plane');
