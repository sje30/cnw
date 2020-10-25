using Pkg
Pkg.activate(".")
Pkg.instantiate()
using OrdinaryDiffEq
using Plots

include("hhode.jl")
          
u0 = [-65.0;0.0529;0.3177;0.5961];
tspan = (0.0,500.0)
##p = [200]                       # input current, defined from calling script.
prob = ODEProblem(hhode!,u0,tspan,p);

sol = solve(prob,Vern7());


l = @layout [a b; c d]
p1 = plot(sol.t, sol[1,:], xlabel="t (ms)", ylabel= "V (mv)", legend=false);
p2 = plot(sol.t, sol[2,:], xlabel="t (ms)", ylabel= "m", legend=false);
p3 = plot(sol.t, sol[3,:], xlabel="t (ms)", ylabel= "n", legend=false);
p4 = plot(sol.t, sol[4,:], xlabel="t (ms)", ylabel= "h", legend=false);
plot(p1, p2, p3, p4, layout = l)
