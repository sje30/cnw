#   This file generates figure 1 in the paper by
#               Izhikevich E.M. (2004)
#   Which Model to Use For Cortical Spiking Neurons?

#ENV["MPLBACKEND"]="qt4agg"

fig, axes = subplots(5,4,figsize=(10,10))

#(A) tonic spiking
a=0.02; b=0.2;  c=-65;  d=6;
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
ax=axes[1,1]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,tspan[end]],-90+[0,0,10,10])
ax[:set_title]("(A) tonic spiking")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


# (B) phasic spiking
a=0.02; b=0.25; c=-65;  d=6;
V=-64; u=b*V;
VV=[];  uu=[];
tau = 0.25;tspan = 0:tau:200;
T1=20;
for t=tspan
    if (t>T1)
        I=0.5;
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
ax=axes[1,2]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,tspan[end]],-90+[0,0,10,10])
ax[:set_title]("(B) phasic spiking")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(C) tonic bursting
a=0.02; b=0.2;  c=-50;  d=2;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:220;
T1=22;
for t=tspan
    if (t>T1)
        I=15;
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
ax=axes[1,3]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,tspan[end]],-90+[0,0,10,10])
ax[:set_title]("(C) tonic bursting")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(D) phasic bursting
a=0.02; b=0.25; c=-55;  d=0.05;
V=-64;  u=b*V;
VV=[];  uu=[];
tau = 0.2;  tspan = 0:tau:200;
T1=20;
for t=tspan
    if (t>T1)
        I=0.6;
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
ax=axes[1,4]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,tspan[end]],-90+[0,0,10,10])
ax[:set_title]("(D) phasic bursting")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(E) mixed mode
a=0.02; b=0.2;  c=-55;  d=4;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:160;
T1=tspan[end]/10;
for t=tspan
    if (t>T1)
        I=10;
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
ax=axes[2,1]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,tspan[end]],-90+[0,0,10,10])
ax[:set_title]("(E) mixed mode")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(F) spike freq. adapt
a=0.01; b=0.2;  c=-65;  d=8;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:85;
T1=tspan[end]/10;
for t=tspan
    if (t>T1)
        I=30;
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
ax=axes[2,2]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,tspan[end]],-90+[0,0,10,10])
ax[:set_title]("(F) spike freq. adapt")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(G) Class 1 exc.
a=0.02; b=-0.1; c=-55; d=6;
V=-60; u=b*V;
VV=[]; uu=[];
tau = 0.25; tspan = 0:tau:300;
T1=30;
for t=tspan
    if (t>T1)
        I=(0.075*(t-T1));
    else
        I=0;
    end;
    V = V + tau*(0.04*V^2+4.1*V+108-u+I);
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
ax=axes[2,3]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,tspan[end],tspan[end]],-90+[0,0,20,0])
ax[:set_title]("(G) Class 1 excitable")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(H) Class 2 exc.
a=0.2;  b=0.26; c=-65;  d=0;
V=-64;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:300;
T1=30;
for t=tspan
    if (t>T1)
        I=-0.5+(0.015*(t-T1));
    else
        I=-0.5;
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
ax=axes[2,4]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,tspan[end],tspan[end]],-90+[0,0,20,0])
ax[:set_title]("(H) Class 2 excitable")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


# (I) spike latency
a=0.02; b=0.2;  c=-65;  d=6;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.2; tspan = 0:tau:100;
T1=tspan[end]/10;
for t=tspan
    if (t>T1) & (t < T1+3)
        I=7.04;
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
ax=axes[3,1]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,T1 + 3,T1+3,tspan[end]],-90+[0,0,10,10,0,0])
ax[:set_title]("(I) spike latency")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(J) subthresh. osc.
a=0.05; b=0.26; c=-60;  d=0;
V=-62;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:200;
T1=tspan[end]/10;
for t=tspan
    if (t>T1) & (t < T1+5)
        I=2;
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
ax=axes[3,2]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,T1+5,T1+5,tspan[end]],-90+[0,0,10,10,0,0])
ax[:plot](tspan[220:end],-10+20*(VV[220:end]-mean(VV)));
ax[:set_title]("(J) subthreshold osc.")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(K) resonator
a=0.1;  b=0.26; c=-60;  d=-1;
V=-62;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:400;
T1=tspan[end]/10;
T2=T1+20;
T3 = 0.7*tspan[end];
T4 = T3+40;
for t=tspan
    if ((t>T1) & (t < T1+4)) || ((t>T2) & (t < T2+4)) || ((t>T3) & (t < T3+4)) || ((t>T4) & (t < T4+4))
        I=0.65;
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
ax=axes[3,3]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,(T1+8),(T1+8),T2,T2,(T2+8),(T2+8),T3,T3,(T3+8),(T3+8),T4,T4,(T4+8),(T4+8),tspan[end]],-90+[0,0,10,10,0,0,10,10,0,0,10,10,0,0,10,10,0,0]);
ax[:set_title]("(K) resonator")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


# (L) integrator
a=0.02; b=-0.1; c=-55; d=6;
V=-60; u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:100;
T1=tspan[end]/11;
T2=T1+5;
T3 = 0.7*tspan[end];
T4 = T3+10;
for t=tspan
    if ((t>T1) & (t < T1+2)) | ((t>T2) & (t < T2+2)) | ((t>T3) & (t < T3+2)) | ((t>T4) & (t < T4+2))
        I=9;
    else
        I=0;
    end;
    V = V + tau*(0.04*V^2+4.1*V+108-u+I);
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
ax=axes[3,4]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,(T1+2),(T1+2),T2,T2,(T2+2),(T2+2),T3,T3,(T3+2),(T3+2),T4,T4,(T4+2),(T4+2),tspan[end]],-90+[0,0,10,10,0,0,10,10,0,0,10,10,0,0,10,10,0,0]);
ax[:set_title]("(L) integrator")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(M) rebound spike
a=0.03; b=0.25; c=-60;  d=4;
V=-64;  u=b*V;
VV=[];  uu=[];
tau = 0.2;  tspan = 0:tau:200;
T1=20;
for t=tspan
    if (t>T1) & (t < T1+5)
        I=-15;
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
ax=axes[4,1]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,(T1+5),(T1+5),tspan[end]],-85+[0,0,-5,-5,0,0]);
ax[:set_title]("(M) rebound spike")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(N) rebound burst
a=0.03; b=0.25; c=-52;  d=0;
V=-64;  u=b*V;
VV=[];  uu=[];
tau = 0.2;  tspan = 0:tau:200;
T1=20;
for t=tspan
    if (t>T1) & (t < T1+5)
        I=-15;
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
ax=axes[4,2]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,(T1+5),(T1+5),tspan[end]],-85+[0,0,-5,-5,0,0]);
ax[:set_title]("(N) rebound burst")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(O) thresh. variability
a=0.03; b=0.25; c=-60;  d=4;
V=-64;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:100;
for t=tspan
   if ((t>10) & (t < 15)) | ((t>80) & (t < 85))
        I=1;
    elseif (t>70) & (t < 75)
        I=-6;
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
ax=axes[4,3]
ax[:plot](tspan,VV)
ax[:plot]([0,10,10,15,15,70,70,75,75,80,80,85,85,tspan[end]],-85+[0,0,5,5,0,0,-5,-5,0,0,5,5,0,0]);
ax[:set_title]("(O) thresh. variability")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(P) bistability
a=0.1;  b=0.26; c=-60;  d=0;
V=-61;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:300;
T1=tspan[end]/8;
T2 = 216;
for t=tspan
    if ((t>T1) & (t < T1+5)) || ((t>T2) & (t < T2+5))
        I=1.24;
    else
        I=0.24;
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
ax=axes[4,4]
ax[:plot](tspan,VV)
ax[:plot]([0,T1,T1,(T1+5),(T1+5),T2,T2,(T2+5),(T2+5),tspan[end]],-90+[0,0,10,10,0,0,10,10,0,0]);
ax[:set_title]("(P) bistability")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();



# (Q) DAP
a=1;  b=0.2; c=-60;  d=-21;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.1; tspan = 0:tau:50;
T1 = 10;
for t=tspan
     if abs(t-T1)<1
        I=20;
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
ax=axes[5,1]
ax[:plot](tspan,VV)
ax[:plot]([0,T1-1,T1-1,T1+1,T1+1,tspan[end]],-90+[0,0,10,10,0,0]);
ax[:set_title]("(Q) DAP         ")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


#(R) accomodation
a=0.02;  b=1; c=-55;  d=4;
V=-65;  u=-16;
VV=[];  uu=[];  II=[];
tau = 0.5; tspan = 0:tau:400;
for t=tspan
    if (t < 200)
        I=t/25;
    elseif t < 300
        I=0;
    elseif t < 312.5
        I=(t-300)/12.5*4;
    else
        I=0;
    end;
    V = V + tau*(0.04*V^2+5*V+140-u+I);
    u = u + tau*a*(b*(V+65));
    if V > 30
        push!(VV,30);
        V = c;
        u = u + d;
    else
        push!(VV,V);
    end;
    push!(uu,u);
    push!(II,I);
end;
ax=axes[5,2]
ax[:plot](tspan,VV)
ax[:plot](tspan,II*1.5-90);
ax[:set_title]("(R) accomodation")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


# (S) inhibition induced spiking
a=-0.02;  b=-1; c=-60;  d=8;
V=-63.8;  u=b*V;
VV=[];  uu=[];
tau = 0.5; tspan = 0:tau:350;
for t=tspan
       if (t < 50) || (t>250)
        I=80;
    else
        I=75;
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
ax=axes[5,3]
ax[:plot](tspan,VV)
ax[:plot]([0,50,50,250,250,tspan[end]],-80+[0,0,-10,-10,0,0]);
ax[:set_title]("(S) inh. induced sp.")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();


# (T) inhibition induced bursting
a=-0.026;  b=-1; c=-45;  d=-2;
V=-63.8;  u=b*V;
VV=[];  uu=[];
tau = 0.5; tspan = 0:tau:350;
for t=tspan
       if (t < 50) || (t>250)
        I=80;
    else
        I=75;
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
ax=axes[5,4]
ax[:plot](tspan,VV)
ax[:plot]([0,50,50,250,250,tspan[end]],-80+[0,0,-10,-10,0,0]);
ax[:set_title]("(T) inh. induced brst.")
ax[:set_xlim]([0,tspan[end]])
ax[:set_ylim]([-90,30])
ax[:set_axis_off]();

fig[:subplots_adjust](hspace=0.35);

#set(gcf,'Units','normalized','Position',[0.3 0.1 0.6 0.8]);
