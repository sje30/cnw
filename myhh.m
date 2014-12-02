initconds = [-65 0.0529 .3177 0.5961];

[T,Y] = ode15s(@hhode, [0 500], initconds);
subplot(2,2,1); plot(T,Y(:,1)); xlabel('t (ms)'); ylabel('V (mv)')
subplot(2,2,2); plot(T,Y(:,2)); title('m');
subplot(2,2,3); plot(T,Y(:,3)); title('n');
subplot(2,2,4); plot(T,Y(:,4)); title('h');