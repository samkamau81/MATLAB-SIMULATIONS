m=5;
k=1000;
f=50;
E={0,0.1,0.25,0.5,0.75,1.0};
w_n=sqrt(k/m);
w=4*w_n;

Cc=2*sqrt(m*k);
%constants
x0 = 0.05;      % Initial displacement (m)
v0 = 0;         % Initial velocity (m/s)
% Time vector
t = linspace(0, 2, 1000); 

for i = 1:length(E)
    xi = E(i);
        
    % Define the system of differential equations
    ode = @(t, y) [y(2); (50 * sin(w * t) - (i*Cc) * y(2) - k * y(1)) / m];

    % Solve the differential equations
    [t, y] = ode45(ode, t, [x0; v0]);

    % Plot the displacement-time curve
    subplot(3, 2, i);
    plot(t, y(:, 1), 'LineWidth', 2);
    title(['\xi = ', xi]);
    xlabel('Time (s)');
    ylabel('Displacement (m)');
    grid on;
end

sgtitle('Forced System Response for Different Damping Ratios');