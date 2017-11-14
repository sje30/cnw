using PyPlot

include("WTA2.jl")
time, res = WTA2(60.0, 70.0)
fig, axes = subplots(1,1,figsize=(5,3))
plot(time, res[1,:], label="E1")
plot(time, res[3,:], label="E")
legend(loc=2)

include("IPSP.jl")

time, X = IPSPinteractions(1.1, 1.0, 5.0, 1.0)
fig, axes = subplots(1,1,figsize=(5,3))
plot(time, X[1,:], label="E1")
plot(time, X[3,:], label="E3")
legend(loc=2)

time, X = IPSPinteractions(1.1, 1.0, 5.0, 2.0)
fig, axes = subplots(1,1,figsize=(5,3))
plot(time, X[1,:], label="E1")
plot(time, X[3,:], label="E3")
legend(loc=2)

