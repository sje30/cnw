function WTA2(k1, k2)
    Total_Equations = 2;  #Solve for this number of interacting Neurons
    DT = 2;  #Time increment as fraction of time constant
    Final_Time = 400;   #Final time value for calculation
    Last = (Int)(Final_Time/DT + 1);  #Last time step
    Time = DT*collect(0:Last-1);  #Time vector
    Tau = 20;  #Neural time constants in msec
    WTS = [1 2 2 1];  #Runge-Kutta Coefficient weights
    X = zeros(Total_Equations, Int(Last))
    K = zeros(Total_Equations, length(WTS))
    Weights = repmat(WTS, 2,1)
    X[1,1] = 1.0; X[2,1] = 0.0;
    Wt2 = [0 .5 .5 1];  #Second set of RK weights
    rkIndex = [1 1 2 3];
    K1= k1; K2=k2
    S(x) = x>0 ? 100x^2 / (120^2 +x^2):0
    K = zeros(2,length(rkIndex))
    for T = 2:Last
        for rk = 1:4  #Fourth Order Runge-Kutta
            XH = X[:, T-1] + K[:, rkIndex[rk]] *Wt2[rk];
            Tme = Time[T-1] + Wt2[rk]*DT;  #Time upgrade
            PSP1 = (K1 - 3*XH[2])*(XH[2] < K1/3);
            PSP2 = (K2 - 3*XH[1])*(XH[1] < K2/3);
            K[1, rk] = DT/Tau*(-XH[1] + S(PSP1))
            K[2, rk] = DT/Tau*(-XH[2] + S(PSP2))
        end
        newx = X[:, T-1] + sum((Weights.*K)',1)'/6
        X[:, T] = newx
    end
    Time, X
end

## using Plots
## plot(Time,X')

# x1 = collect(0:300); plot(x1, S.(x1))
##Calculation_Time = etime(clock, T1)
# whitebg('w');
# maxiso = ceil(max(max(X')));
# Xiso = 0:maxiso;  #X for Isoclines
# Isocline1 = 100*(K2 - 3*Xiso).^2./(120^2 + (K2 - 3*Xiso).^2).*(3*Xiso < K2);
# Isocline2 = 100*(K1 - 3*Xiso).^2./(120^2 + (K1 - 3*Xiso).^2).*(3*Xiso < K1);
# figure(1); Za = plot(Time, X(1, :), 'r', Time, X(2, :), 'b'); set(Za, 'LineWidth', 2);
# xlabel('Time (ms)'); ylabel('E1 (red) & E2 (blue)');  
# figure(2); Zb = plot(X(1, :), X(2, :), '-r', Xiso, Isocline1, '-k', Isocline2, Xiso, '--k'); set(Zb, 'LineWidth', 2); axis square;
# xlabel('E1'); ylabel('E2'); title('Phase Plane');
