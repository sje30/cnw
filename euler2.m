% Simple example of Euler integration
h = 0.1;                                % time-step
tmax = 5;                               % max t value
init = 0;                               % initial condition

t = 0:h:tmax;                           % vector of time values
nsteps = length(t);                     % how many steps
x = zeros(nsteps,1);                    % where we will store
                                        % results
x(1) = init;


% Start the integration
for i=1:(nsteps-1)
    f =  -10*x(i) + 8*exp(-2*t(i));
    x(i+1) = x(i) + (h*f);
end


% Now plot results and compare with true solution
plot(t, x)
hold on
xtrue = exp(-2*t) - exp(-10*t);
plot(t, xtrue, 'g')
xlabel('time (s)'); ylabel('x');
legend('Euler', 'True', 'Location', 'NorthWest')
hold off
