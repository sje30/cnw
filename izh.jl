## Izhikevich model
## Adapted from code for Figure 1 of 2004 paper
## available at http://www.izhikevich.org/publications/figure1.m

using PyPlot

#a=0.02; b=0.2;  c=-65;  d=6;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:100;
T1=tspan[end]/10;
for t=tspan
    if (t>T1)
        I=14;
    else
        I=0;
    end;
    V = V + tau*(0.04*V^2+5*V+140-u+I);
    u = u + tau*a*(b*V-u);
    if V > 30
        push!(VV,30);
        V = c;
        u = u + d;
    else
        push!(VV,V);
    end;
    push!(uu,u);
end;
fig, axes = subplots(1,1,figsize=(5,3))
plot(tspan,VV);
plot([0,T1,T1,tspan[end]],-90+[0,0,10,10])
title("(A) tonic spiking")
xlim([0,tspan[end]])
ylim([-90,30])
##savefig("izhplot")
