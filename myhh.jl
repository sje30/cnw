using Sundials
using DifferentialEquations
using PyPlot

include("hhode.jl")
          
u0 = [-65.0;0.0529;0.3177;0.5961];
tspan = (0.0,500.0)
#I = 10; define elsewhere
prob = ODEProblem(hhode,u0,tspan);
sol = solve(prob,CVODE_BDF());

fig, axes = subplots(2,2,figsize=(6,6))
ax=axes[1,1]
ax[:plot](sol.t,sol[1,:])
ax[:set_xlabel]("t(ms)")
ax[:set_ylabel]("V(mv)")

ax=axes[1,2]
ax[:plot](sol.t,sol[2,:])
ax[:set_title]("m")

ax=axes[2,1]
ax[:plot](sol.t,sol[3,:])
ax[:set_title]("n")

ax=axes[2,2]
ax[:plot](sol.t,sol[4,:])
ax[:set_title]("h")
fig[:subplots_adjust](hspace=0.35);
show()
