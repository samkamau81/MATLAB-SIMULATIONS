% Given values
m = 5; % kg
k = 1000; % N/m
x0 = 0.05; % Initial displacement in meters
v0 = 0; % Initial velocity in m/s

% Define the damping ratios
xi_values = [0, 0.1, 0.25, 0.5, 0.75, 1.0];

% Time span for simulation (6 cycles)
tspan = linspace(0, 6*2*pi*sqrt(m/k), 1000);

% Initialize matrices to store results
x_results = zeros(length(xi_values), length(tspan));
v_results = zeros(length(xi_values), length(tspan));

% Loop over damping ratios
for i = 1:length(xi_values)
    xi = xi_values(i);
    c = 2*xi*sqrt(m*k); % Calculate damping coefficient
    
    % Define the system of first-order differential equations
    f = @(t, Y) [Y(2); -c/m*Y(2) - k/m*Y(1)];
    
    % Solve the system
    [t, Y] = ode45(f, tspan, [x0; v0]);
    
    % Store results
    x_results(i, :) = Y(:, 1)';
    v_results(i, :) = Y(:, 2)';
end

% Plot the results
figure;
hold on;
colors = ['b', 'g', 'r', 'c', 'm', 'k'];
for i = 1:length(xi_values)
    plot(t, x_results(i, :), colors(i), 'DisplayName', ['ξ = ' num2str(xi_values(i))]);
end
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Response of the System for Different Damping Ratios');
legend('Location', 'best');
grid on;
hold off;

