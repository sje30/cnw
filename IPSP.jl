function IPSPinteractions(Stim1, Stim2, ES, TauSyn)
    ## e.g. 1, 2, 4, 1.27
    Total_Neurons = 8;  #Solve for this number of interacting Neurons
    DT = 0.02;  #Time increment as fraction of time constant
    Final_Time = 100;   #Final time value for calculation
    Last = Int64(Final_Time/DT + 1);  #Last time step
    Time = DT*(0:Last-1);  #Time vector
    Tau = 1.0;  #Neural time constants in msec
    TauR = 5.6
    WTS = [1 2 2 1];  #Runge-Kutta Coefficient weights

    # Predefine X, K and WTS for speed
    X = Array{Float64}(Total_Neurons, Last)
    K = Array{Float64}(Total_Neurons, 4)
    Weights = Array{Float64}(Total_Neurons, 4)

    for NU = 1:Total_Neurons;  #Initialize
        X[NU, :] = zeros(1, Last);  #Vector to store response of Neuron #1
        K[NU, :] = zeros(1, 4);  #Runge-Kutta terms	
        Weights[NU, :] = WTS;  #Make into matrix for efficiency in main loop
    end
    X[1, 1] = -0.754;  #Initial conditions here if different from zero
    X[2, 1] = 0.279;  #Initial conditions here if different from zero
    X[3, 1] = -0.754;  #Initial conditions here if different from zero
    X[4, 1] = 0.279;  #Initial conditions here if different from zero
    Wt2 = [0 .5 .5 1];  #Second set of RK weights
    rkIndex = [1 1 2 3]
    #Stim1 = 1#input("Stimulating current strength, neuron 1 (red) (0-2): ")
    #Stim2 = 2#input("Stimulating current strength, neuron 2 (blue) (0-2): ")
    #ES = 4#input("Inhibitory synaptic conductance factor (0-6): ")

    #**********
    #TauSyn = 1.27;  #IPSP time constant
    #**********

    SynThresh = -0.2;  #Threshold for IPSP conductance change

    ST = 10.6
    for T = 2:Last
      for rk = 1:4  #Fourth Order Runge-Kutta
        XH = X[:, T-1] + K[:, rkIndex[rk]]*Wt2[rk]
        Tme =Time[T-1] + Wt2[rk]*DT;  #Time upgrade

        K[1, rk] = DT/Tau*(-(17.81 + 47.58*XH[1] + 33.8*XH[1]^2)*(XH[1] - 0.48) - 26*XH[2]*(XH[1] + 0.95) + Stim1 - ES*XH[7]*(XH[1] + 0.92));  
        K[2, rk] = DT/TauR*(-XH[2] + 1.29*XH[1] + 0.79 + 3.3*(XH[1] + 0.38)^2)
        K[5, rk] = DT/TauSyn*(-XH[5] + (XH[3] > SynThresh))
        K[7, rk] = DT/TauSyn*(-XH[7] + XH[5])

        K[3, rk] = DT/Tau*(-(17.81 + 47.58*XH[3] + 33.8*XH[3]^2)*(XH[3] - 0.48) - 26*XH[4]*(XH[3] + 0.95)+ Stim2 - ES*XH[8]*(XH[3] + 0.92));  
        K[4, rk] = DT/TauR*(-XH[4]+ 1.29*XH[3] + 0.79 + 3.3*(XH[3] + 0.38)^2)
        K[6, rk] = DT/TauSyn*(-XH[6] + (XH[1] > SynThresh))
        K[8, rk] = DT/TauSyn*(-XH[8] + XH[6])

     end
        X[:, T] = X[:, T-1] + sum((Weights.*K)', 1)'/6
    end

#=
    ### PlotlyJS ###
    trace1 = PlotlyJS.scatter(;x=Time, y=100*X[1, :], mode="lines", line_color="red")
    trace2 = PlotlyJS.scatter(;x=Time, y=100*X[3, :], mode="lines", line_color="blue")
    layout = PlotlyJS.Layout(title="Solutions", xlabel="Time (ms)", ylabel="Voltage (mV)")
    p1 = PlotlyJS.plot([trace1, trace2], layout)
    ### PlotlyJS ###

#     figure(1), ZA = plot(Time, 100*X[1, :], "r-', Time, 100*X[3, :], 'b-'); set(ZA, 'LineWidth", 2)
#     xlabel("Time (ms)'); ylabel ('V(t)")
    VV = -0.9:0.01:1.5
    DVdt = -0.5*((1.37 + 3.67*VV + 2.51*VV.^2).*(VV - 0.55) - Stim1/13)./(VV + 0.92)
    DRdt = 1.35*VV + 1.03
    #Next lines calculate spike rate
    Spikes = (X[1, 1:Last - 1] .< -0.2).*(X[1, 2:Last] .>= -0.2)
    SpkTime = zeros(1, sum(Spikes))
    Nspk = 1;  #Number of spike
    for T = 1:length(Spikes);  #Calculate spike rate for all interspike intervals
        if Spikes[T] == 1; SpkTime[Nspk] = T*DT; Nspk = Nspk + 1; end
    end
    Final = length(SpkTime)
    Rates = 1000./(SpkTime[2:Final] - SpkTime[1:Final - 1])
    Leng = length(Rates)
    Red_Rate = mean(Rates[Int64(round(Leng/2)):Leng])
    #Next lines calculate blue spike rate
    Spikes = (X[3, 1:Last - 1] .< -0.2).*(X[3, 2:Last] .>= -0.2)
    SpkTime = zeros(1, sum(Spikes))
    Nspk = 1;  #Number of spike
    for T = 1:length(Spikes);  #Calculate spike rate for all interspike intervals
        if Spikes[T] == 1; SpkTime[Nspk] = T*DT; Nspk = Nspk + 1; end
    end
    Final = length(SpkTime)
    BRates = 1000./(SpkTime[2:Final] - SpkTime[1:Final - 1])
    Leng = length(BRates)
    Blue_Rate = mean(BRates[Int64(round(Leng/2)):Leng])
    
    p1
    =#
    Time, X
end
