% Simple example of Euler integration
h = 0.01;                               % time-step
tmax = 5;                               % max t value
init = 1;                               % initial condition

t = 0:h:tmax;                           % vector of time values
nsteps = length(t);                     % how many steps
x = zeros(nsteps,1);                    % where we will store
                                        % results
x(1) = init;


% Start the integration
for i=1:(nsteps-1)
    f = t(i) - x(i) + 1;                % evaluate dx/dt
    x(i+1) = x(i) + (h*f);
end


% Now plot results and compare with true solution
plot(t, x)
hold on
xtrue = exp(-t) + t;                    % true solution
plot(t, xtrue, 'g')
xlabel('time (s)'); ylabel('x');
legend('Euler', 'True', 'Location', 'NorthWest')
hold off
