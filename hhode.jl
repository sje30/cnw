function hhode!(dy, y, p, t)
    v = y[1]; m = y[2]; n = y[3]; h = y[4];

    # Some constants of the system.
    I = p[1]
    gna = 1200; gk=360; gl=3;
    El=-54.387; Ek=-77.0; Ena=100.0;
    C = 10;


    am = 0.1*(v+40)/(1-exp(-(v+40)/10));
    bm = 4*exp(-(v+65)/18);

    ah = 0.07*exp(-(v+65)/20);
    bh = 1/(1+exp(-(v+35)/10));

    an = 0.01*(v+55)/(1-exp(-(v+55)/10));
    bn = 0.125*exp(-(v+65)/80);

    dv = (I - gna*h*(v-Ena)*m^3-gk*(v-Ek)*n^4-gl*(v-El))/C;

    dm = am*(1-m) -bm*m;
    dh = ah*(1-h) -bh*h;
    dn = an*(1-n) -bn*n;

    # Return derivatives
    dy[1]=dv;
    dy[2]=dm;
    dy[3]=dn;
    dy[4]=dh;

end


function plot_hh(;i=10)
    u0 = [-65.0;0.0529;0.3177;0.5961]
    tspan = (0.0,500.0)
    p = [i]
    prob = ODEProblem(hhode!,u0,tspan,p)
    
    sol = solve(prob,Vern7());
    

    l = @layout [a b; c d]
    p1 = plot(sol.t, sol[1,:], xlabel="t (ms)", ylabel= "V (mv)", legend=false);
    p2 = plot(sol.t, sol[2,:], xlabel="t (ms)", ylabel= "m", legend=false);
    p3 = plot(sol.t, sol[3,:], xlabel="t (ms)", ylabel= "n", legend=false);
    p4 = plot(sol.t, sol[4,:], xlabel="t (ms)", ylabel= "h", legend=false);
    plot(p1, p2, p3, p4, layout = l)
end
