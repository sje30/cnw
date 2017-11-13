function hhode(t,y,dy)
    v = y[1]; m = y[2]; n = y[3]; h = y[4];

    # Some constants of the system.
    #I = 0.1; #This should possibly be an input argument
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
