%Fourth Order Runge-Kutta for N-Dimensional Systems
clear all; hold off;
whitebg('w');
Total_Neurons = 8;  %Solve for this number of interacting Neurons
DT = 0.02;  %Time increment as fraction of time constant
Final_Time = 50;   %Final time value for calculation
Last = Final_Time/DT + 1;  %Last time step
Time = DT*[0:Last-1];  %Time vector
Tau = 0.8;  %Neural time constants in msec
TauR = 1.9;
WTS = [1 2 2 1];  %Runge-Kutta Coefficient weights
for NU = 1:Total_Neurons;  %Initialize
	X(NU, :) = zeros(1, Last);  %Vector to store response of Neuron #1
	K(NU, :) = zeros(1, 4);  %Runge-Kutta terms	
	Weights(NU, :) = WTS;  %Make into matrix for efficiency in main loop
end;
X(1, 1) = -0.70;  %Initial conditions here if different from zero
X(2, 1) = 0.088;  %Initial conditions here if different from zero
X(3, 1) = -0.70;  %Initial conditions here if different from zero
X(4, 1) = 0.088;  %Initial conditions here if different from zero
Wt2 = [0 .5 .5 1];  %Second set of RK weights
rkIndex = [1 1 2 3];
Stim1 = input('Stimulating current strength, neuron 1 (red) (0-2): ');
Stim2 = 0;
ES = input('Inhibitory synaptic conductance factor (0-320): ');
SynThresh = -0.2;  %Threshold for IPSP conductance change
%**********
TauSyn = 1.0;  %IPSP time constant
%**********
T1 = clock;
ST = 10.6;
for T = 2:Last;
  for rk = 1:4  %Fourth Order Runge-Kutta
	XH = X(:, T-1) + K(:, rkIndex(rk))*Wt2(rk);
 	Tme =Time(T-1) + Wt2(rk)*DT;  %Time upgrade
		
	K(1, rk) = DT/Tau*(-(17.81 + 47.71*XH(1) + 32.63*XH(1)^2)*(XH(1) - 0.55) - 26*XH(2)*(XH(1) + 0.92) + Stim1*(Tme > 2)*(Tme <= 3) - ES*XH(7)*(XH(1) + 0.92));  
  	K(2, rk) = DT/TauR*(-XH(2) + 1.35*XH(1) + 1.03);
  	K(5, rk) = DT/TauSyn*(-XH(5) + (XH(3) > SynThresh));
	K(7, rk) = DT/TauSyn*(-XH(7) + XH(5));

	K(3, rk) = DT/Tau*(-(17.81 + 47.71*XH(3) + 32.63*XH(3)^2)*(XH(3) - 0.55) - 26*XH(4)*(XH(3) + 0.92)+ Stim2*(Tme > 2)*(Tme <= 3) - ES*XH(8)*(XH(3) + 0.92));  
  	K(4, rk) = DT/TauR*(-XH(4) + 1.35*XH(3) + 1.03);
  	K(6, rk) = DT/TauSyn*(-XH(6) + (XH(1) > SynThresh));
	K(8, rk) = DT/TauSyn*(-XH(8) + XH(6));

 end;
	X(:, T) = X(:, T-1) + sum((Weights.*K)')'/6;
end;
Calculation_Time = etime(clock, T1)
figure(1), ZA = plot(Time, 100*X(1, :), 'r', Time, 100*X(3, :) - 150, 'b-'); set(ZA, 'LineWidth', 2);
ylabel('V (mV'); xlabel('Time (ms)');
VV = -0.9:0.01:1.5;
DVdt = -0.5*((1.37 + 3.67*VV + 2.51*VV.^2).*(VV - 0.55) - Stim1/13)./(VV + 0.92);
DRdt = 1.35*VV + 1.03;
figure(2), ZB = plot(VV, DVdt, 'k-', VV, DRdt, 'b-', X(1, :), X(2, :), 'r-'); axis([-1, 0.6, 0, 1]);
set(ZB, 'LineWidth', 2); axis square;
%Next lines calculate spike rate
Spikes = (X(1, 1:Last - 1) < -0.2).*(X(1, 2:Last) >= -0.2);
SpkTime = zeros(1, sum(Spikes));
Nspk = 1;  %Number of spike
for T = 1:length(Spikes);  %Calculate spike rate for all interspike intervals
	if Spikes(T) == 1; SpkTime(Nspk) = T*DT; Nspk = Nspk + 1; end;
end;
Final = length(SpkTime);
Rates = 1000./(SpkTime(2:Final) - SpkTime(1:Final - 1));
Leng = length(Rates);
Red_Rate = mean(Rates(Leng/2:Leng))
%Next lines calculate blue spike rate
Spikes = (X(3, 1:Last - 1) < -0.2).*(X(3, 2:Last) >= -0.2);
SpkTime = zeros(1, sum(Spikes));
Nspk = 1;  %Number of spike
for T = 1:length(Spikes);  %Calculate spike rate for all interspike intervals
	if Spikes(T) == 1; SpkTime(Nspk) = T*DT; Nspk = Nspk + 1; end;
end;
Final = length(SpkTime);
BRates = 1000./(SpkTime(2:Final) - SpkTime(1:Final - 1));
Leng = length(BRates);
Blue_Rate = mean(BRates(Leng/2:Leng))
