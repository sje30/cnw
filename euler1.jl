# Simple example of Euler integration
#h = 0.01;                               # time-step

using Plots

"""
Simple Euler integration
h=0.1 is a good default.
"""
function euler1(h)
    tmax = 5;                               # max t value
    init = 1;                               # initial condition
    
    t = 0:h:tmax;                           # vector of time values
    nsteps = length(t);                     # how many steps
    x = zeros(nsteps,1);                    # where we will store
    # results
    x[1] = init;
    
    
    # Start the integration
    for i=1:(nsteps-1)
        f = t[i] - x[i] + 1;                # evaluate dx/dt
        x[i+1] = x[i] + (h*f);
    end
    ## why need space?
    hcat(t, x)
end


function plot_euler1(;h=0.1)
    res = euler1(h);
    t = res[:,1]
    x = res[:,2]
    xtrue = @. exp(-t) + t;                    # true solution
    
    plot(t, hcat(x, xtrue), legend=:topleft,
         title = "Euler integration",
         xlabel="Time (s)", ylabel="x",
         label=["estimate" "true"])
end
