#   This file generates figure 1 in the paper by
#               Izhikevich E.M. (2004)
#   Which Model to Use For Cortical Spiking Neurons?

#ENV["MPLBACKEND"]="qt4agg"

using Statistics                # for the mean function

#(A) tonic spiking

function plot_ts(t,v,title)
    plot(t,v, title=title,
         titlefontsize=10,
         legend=false, axis=nothing,
         xlims=(0, t[end]), ylims=(-90,30));
end

function izh_a()
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
    plot_ts(tspan,VV, "(A) tonic spiking")
    plot!([0,T1,T1,tspan[end]],-90.0 .+ [0,0,10,10])
end

function izh_b()
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
    plot_ts(tspan,VV, "(B) phasic spiking")
    plot!([0,T1,T1,tspan[end]],-90.0 .+ [0,0,10,10])
end


#(C) tonic bursting
function izh_c()
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
    plot_ts(tspan,VV, "(C) tonic bursting")
    plot!([0,T1,T1,tspan[end]],-90.0 .+[0,0,10,10])
end

#(D) phasic bursting
function izh_d()
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
    plot_ts(tspan,VV,"(D) phasic bursting")
    plot!([0,T1,T1,tspan[end]],-90.0 .+[0,0,10,10])
end


#(E) mixed mode
function izh_e()
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
    plot_ts(tspan,VV, "(E) mixed mode")
    plot!([0,T1,T1,tspan[end]],-90.0 .+[0,0,10,10])
end

#(F) spike freq. adapt
function izh_f()
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
    plot_ts(tspan,VV, "(F) spike freq. adapt")
    plot!([0,T1,T1,tspan[end]],-90.0 .+[0,0,10,10])
end


#(G) Class 1 exc.
function izh_g()
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
    plot_ts(tspan,VV,"(G) Class 1 excitable")
    plot!([0,T1,tspan[end],tspan[end]],-90.0 .+[0,0,20,0])
end


#(H) Class 2 exc.
function izh_h()
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
    plot_ts(tspan,VV, "(H) Class 2 excitable")
    plot!([0,T1,tspan[end],tspan[end]],-90.0 .+[0,0,20,0])
end


# (I) spike latency
function izh_i()
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
    plot_ts(tspan,VV, "(I) spike latency")
    plot!([0,T1,T1,T1 + 3,T1+3,tspan[end]],-90.0 .+[0,0,10,10,0,0])
end


#(J) subthresh. osc.
function izh_j()
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
    plot_ts(tspan,VV,"(J) subthreshold osc.")
    plot!([0,T1,T1,T1+5,T1+5,tspan[end]],-90.0 .+[0,0,10,10,0,0])
    plot!(tspan[220:end],-10 .+ 20*(VV[220:end] .- mean(VV)));
end


#(K) resonator
function izh_k()
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
    plot_ts(tspan,VV, "(K) resonator")
    plot!([0,T1,T1,(T1+8),(T1+8),T2,T2,(T2+8),(T2+8),T3,T3,(T3+8),(T3+8),T4,T4,(T4+8),(T4+8),tspan[end]],-90.0 .+[0,0,10,10,0,0,10,10,0,0,10,10,0,0,10,10,0,0]);
end


# (L) integrator
function izh_l()
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
    plot_ts(tspan,VV, "(L) integrator")
    plot!([0,T1,T1,(T1+2),(T1+2),T2,T2,(T2+2),(T2+2),T3,T3,(T3+2),(T3+2),T4,T4,(T4+2),(T4+2),tspan[end]],-90.0 .+[0,0,10,10,0,0,10,10,0,0,10,10,0,0,10,10,0,0]);
end


#(M) rebound spike
function izh_m()
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
    plot_ts(tspan,VV,"(M) rebound spike")
    plot!([0,T1,T1,(T1+5),(T1+5),tspan[end]], -85.0 .+ [0,0,-5,-5,0,0]);
end


#(N) rebound burst
function izh_n()
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
    plot_ts(tspan,VV,"(N) rebound burst")
    plot!([0,T1,T1,(T1+5),(T1+5),tspan[end]],-85.0 .+ [0,0,-5,-5,0,0]);
end


#(O) thresh. variability
function izh_o()
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
    plot_ts(tspan,VV, "(O) thresh. variability")
    plot!([0,10,10,15,15,70,70,75,75,80,80,85,85,tspan[end]],
            -85.0 .+ [0,0,5,5,0,0,-5,-5,0,0,5,5,0,0]);
end


#(P) bistability
function izh_p()
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
    plot_ts(tspan,VV, "(P) bistability")

    plot!([0,T1,T1,(T1+5),(T1+5),T2,T2,(T2+5),(T2+5),tspan[end]],-90.0 .+[0,0,10,10,0,0,10,10,0,0]);
end


# (Q) DAP
function izh_q()
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
    plot_ts(tspan,VV,         "(Q) DAP         ")
    plot!([0,T1-1,T1-1,T1+1,T1+1,tspan[end]],-90.0 .+[0,0,10,10,0,0]);
end


#(R) accomodation
function izh_r()
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
    plot_ts(tspan,VV, "(R) accomodation")
    plot!(tspan,II*1.5 .- 90.0);
end


# (S) inhibition induced spiking
function izh_s()
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
    plot_ts(tspan,VV,  "(S) inh. induced sp.")
    plot!([0,50,50,250,250,tspan[end]], -80.0 .+ [0,0,-10,-10,0,0]);
end


# (T) inhibition induced bursting
function izh_t()
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
    plot_ts(tspan,VV,"(T) inh. induced brst.")
    plot!([0,50,50,250,250,tspan[end]],
            -80.0 .+ [0,0,-10,-10,0,0]);
end


p_a = izh_a();
p_b = izh_b();
p_c = izh_c();
p_d = izh_d();

p_e = izh_e()
p_f = izh_f()
p_g = izh_g()
p_h = izh_h()

p_i = izh_i()
p_j = izh_j()
p_k = izh_k()
p_l = izh_l()

p_m = izh_m()
p_n = izh_n()
p_o = izh_o()
p_p = izh_p()

p_q = izh_q()
p_r = izh_r()
p_s = izh_s()
p_t = izh_t()


l = @layout [a b c d; e f g h; i j k l; m n o p; q r s t]

plot(p_a, p_b, p_c, p_d,
     p_e, p_f, p_g, p_h,
     p_i, p_j, p_k, p_l,
     p_m, p_n, p_o, p_p,
     p_q, p_r, p_s, p_t,
     layout = l)

#set(gcf,'Units','normalized','Position',[0.3 0.1 0.6 0.8]);
