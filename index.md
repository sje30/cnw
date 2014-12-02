---
title: Introduction to Computational Neuroscience
author:
author:
- name: Stephen J Eglen
  affiliation: University of Cambridge
  email: S.J.Eglen@damtp.cam.ac.uk
date: 2014-12-02
...




# Prelim

- Tick/add your name on the sign-up sheet.
- In case of fire/emergency: nearest fire-exit is on basement level, walking
back the way we came.
- Break at 13:55-14:05; bathrooms outside; cafe in central core
upstairs open til 16:00.
- Consider pairing up with someone else if you want to focus on the
science rather than difficulties of learning matlab; there is no time
today to given a introduction to matlab.

# Introduction

This is the first time I've tried this, so be patient!  If nothing
else, in two hours I hope you get to see what you can do with simple
computer models.

Download these notes from
[http://www.damtp.cam.ac.uk/user/sje30/cnw-2014.zip](http://www.damtp.cam.ac.uk/user/sje30/cnw-2014.zip)
and right-click to extract/unzip all the files.


Matlab is one of the most popular computational environments around.
(But there are alternatives that I prefer
... [R](http://r-project.org), [julia](http://julialang.org),
[python](http://python.org).)  We will use it today for expedience.

# Background maths


## Euler integration

Given some differential equation for how x changes over time and so
initial condition (i.e. x = some value at time t = 0), we can
integrate them numerically using Euler integration.

$\frac{dx}{dt} = f(x,t)$

$X_{n+1} = X_{n}+ h f(x,t)$

Depending on the step-size h.

## Trappenberg example (Appendix B)

Solve differential equation

$\frac{dx}{dt} = t -x + 1$

with initial conditions $x(0) = 1$.

Known solution:

$x(t) = \exp(-t) + t$

We will open [euler1.m](euler1.m) in matlab and then run the script by
typing "euler1" at the prompt (or you can hit the button titled "Run
selection").


## Exercise: numerical integration


- Use the zoom buttons on the graph to see how close the approximation
is, especially for t<2.

- Extend the maximal time from 5 to 20.  Does it still work with h=0.2?

- See what happens when you vary the step size in the solution (try
values of h between 0.01 and 5.) with larger solutions.

- Try solving another differential equation with x(0)=0:
<!-- ack: catam 1b -->
$\frac{dx}{dt} = -10x + 8 \exp(-2t)$.  Try values of h between 0.0001 and 0.5



# Hodgkin-Huxley model


## Reminder of the biology

Its all in the channels!

[http://tinyurl.com/matthews-channel](http://tinyurl.com/matthews-channel)

## Reminder of the mathematics

See [assignment 3](http://www.damtp.cam.ac.uk/user/sje30/teaching/r/spa3-2014.pdf)


Matlab has built-in functions for numerical integration of ODEs,
e.g. ode23, ode45, ode23s.  We will use them here so that we focus on
the problem and not the numerics.

## Matlab

1. [hhode.m](hhode.m) stores the "science"
2. [myhh.m](myhh.m) stores the "numerics"

Run with default I=0.1 and then compare with I=10.

## Exercises

1. Can you find the critical value of I where you first get a spike
generated?

2. Can you work out the units on I (check equation 1 and Table 1 of spa3)?

3. Estimate the firing rate (in Hz) for the model as you vary I from 0
   to 500.  Can you plot a graph of it?  e.g. see
   [hh_plotrate.m](hh_plotrate.m) for a template.

4. (Advanced) Apply a pulse of negative current with I=-50
   for 5 ms followed by I=0 and describe what happens.

5. Try other manipulations, e.g. what if you set dh/dt to
   zero?  What would this simulate?

# Izhikevich models


Let's simplify the models as far as we can; we are going to use the
simplification due to Izhikevich.

Read
[the basic description](http://www.izhikevich.org/human_brain_simulation/Blue_Brain.htm#models%20of%20spiking%20neurons)
and guess which is the real data.

## The basic model.
![http://www.izhikevich.org/publications/izhik.gif](http://www.izhikevich.org/publications/izhik.gif)


## Exercise: Izhikevich

1. [izh.m](izh.m) has the basic code for one of the models.  Try to
   adapt using parameters a,b,c,d to generate each of the plots from
   above.  e.g. how can you make a chattering cell (CH)?

2. Explore [figure1.m](figure1.m).  This regenerates figure 1 of the
   [2004 paper](http://www.izhikevich.org/publications/whichmod.pdf).
   See if you can follow in the code how the model is adapted in each
   case.
   

# Coupling two neurons


## Winner-take-all (WTA) network.

Eqn 6.18 from Wilson (1999).  Couple two neurons that inhibit each other.

$\tau \frac{dE_1}{dt} = -E_1 + S(K_1 - 3E_2)$

$\tau \frac{dE_2}{dt} = -E_2 + S(K_2 - 3E_1)$

$S(x) = 100(x^2) / [120^2 + x^2$]



We will first run the script [WTA2.m](WTA2.m) with input to neuron 1 =
60 and input to neuron 2 = 70.  We will examine the phase plane.

### Exercises

1. When the input to both cells is equal, what is the critical value
   when one neurons dominates?  Start with input to both cells equal
   to 20.

2. Examine what happens when input to both neurons is 100.  Run it
   several times and see which one wins.  Can you explain (and then
   test) your result?


## Coupling inhibitory neurons, part II.

Wilson (Chapter 12) shows how pairs of neurons coupled with reciprocal
inhibition can generate out-of-phase firing (not WTA).

Try [IPSPinteractions.m](IPSPinteractions.m) with $I_1 = 1.1, I_2=
1.0, k=5$.  We should see out-of-phase spiking.


### Exercises

1. Edit the script IPSPinteractions.m so that TauSyn is set to 2 ms
(rather than 1 ms) and repeat with above parameters.  What do you
observe?

2. As above, but with $I_1 = 1.05$; now what happens?

3. (Advanced) investigate the [Clione.m](Clione.m) script.  These are
   two coupled neurons that are mutually inhibitory, but with each
   neuron modelled by 4 ODEs (eq 12.18, p191).  Importantly here there
   is only external input to one neuron between 2ms and 3ms.  After
   starting the script, set current strength to 0.5 and inhibitory
   conductance to 9.


# Learning patterns

Wilson (Chapter 14) shows how to model recurrent circuity found in
areas such as CA3 of hippocampus.  256 neurons are reciprocally
coupled with adjustable weights.  Several patterns have been stored
transiently, and then weights $w_{ij}, w_{ji}$ between unit i and j is
set to 1 if both units i and j are above threshold (50 Hz).  (This is
a form of **Hebbian plasticity**.)  For recall, we then add noise.

For this exercise, you will need to be in [Chapter14](Chapter14)
folder.  Simply `cd Chapter14` in the matlab prompt.

## Exercises

1. Run `CA3memory.m` and test all four patterns.

2. Try adding your own pattern, either similar to the others, or
distinct, using `CA3learning.m`.  When you start, you get to add 32
pixels to a grid (current pixel number is listed at the top of the
figure -- it is a basic, but useful, image editor!)


# Closing comments

1. If you wish to learn more, we have some comp neuro lectures next
term.

2. Questions?


# References

Much of this material came from some of the following sources.  Note
that Wilson's book is freely available as pdf.



Dayan P, Abbott LF (2001) Theoretical Neuroscience: Computational and
Mathematical Modeling of Neural Systems. MIT Press.

Izhikevich EM (2004) Which model to use for cortical spiking neurons?
IEEE Trans Neural Netw 15:1063–1070.

Trappenberg T (2010) Fundamentals of Computational Neuroscience.  2nd
edition. OUP.  https://web.cs.dal.ca/~tt/fcns/

Wilson HR (1999) Spikes decisions and actions. OUP.
http://cvr.yorku.ca/webpages/wilson.htm#book (including PDF of the book).


<!--
Notes to self:

--mathml not working on windows; mathjax might be better.


Odd that it needs space
$ v(t) = v_0 + \frac{1}{2}at^2$ 
 -->
