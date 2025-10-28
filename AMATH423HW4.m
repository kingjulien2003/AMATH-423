clc; clear; close all;

% Parameter range
alpha = 1; % You can change this value
beta_vals = linspace(0, 3, 100); % Range of beta values
beta_critical = 1 + alpha; % Hopf bifurcation point

% Equilibrium solutions
u_eq = ones(size(beta_vals)); % u* = 1 for all beta
v_eq = beta_vals ./ alpha; % v* = beta / alpha

% Compute eigenvalues to determine stability
lambda_real = -(beta_vals + 1) / 2; % Real part of eigenvalues
lambda_imag = sqrt(alpha - (lambda_real).^2); % Imaginary part

% Plot bifurcation diagram
figure;
hold on;
plot(beta_vals, u_eq, 'k', 'LineWidth', 2); % Stable equilibrium branch

% Identify bifurcation point
idx_bifurcation = find(beta_vals >= beta_critical, 1);
plot(beta_vals(idx_bifurcation:end), u_eq(idx_bifurcation:end), 'r--', 'LineWidth', 2); % Limit cycle emerges

% Mark critical bifurcation point
xline(beta_critical, 'b--', 'LineWidth', 2);

xlabel('\beta'); ylabel('u*');
title('Hopf Bifurcation Diagram');
legend('Stable Equilibrium', 'Limit Cycle Emergence', 'Bifurcation Point');
grid on;
hold off;


%% 
clc; clear; close all;

% Parameters
alpha = 1; % Change if needed
beta_vals = linspace(0, 3, 50); % Range of beta values
t = linspace(0, 20, 200); % Time range
[Beta, T] = meshgrid(beta_vals, t); % Create meshgrid

% Equilibrium solutions
U_eq = ones(size(Beta)); % u* = 1 for all beta
V_eq = Beta / alpha; % v* = beta / alpha

% Define limit cycle amplitude after bifurcation
A = sqrt(Beta - (1 + alpha)); % Amplitude
A(Beta < (1 + alpha)) = 0; % No oscillation before bifurcation

% Oscillatory solutions
w = sqrt(alpha); % Frequency
U_osc = U_eq + A .* cos(w * T);
V_osc = V_eq + A .* sin(w * T); % Phase-shifted by π/2

% 3D plot
figure;
surf(Beta, V_osc, U_osc, 'EdgeColor', 'none'); % Surface plot

% Formatting
xlabel('\beta', 'FontSize', 12); 
ylabel('v(t)', 'FontSize', 12); 
zlabel('u(t)', 'FontSize', 12);
title('3D Hopf Bifurcation: u vs v vs \beta', 'FontSize', 14);
colormap(jet);
colorbar;
view(45, 30); % Adjust viewing angle
grid on;

% Add bifurcation boundary
hold on;
beta_critical = 1 + alpha;
plot3(ones(size(V_eq)) * beta_critical, V_eq, U_eq, 'k--', 'LineWidth', 2); % Bifurcation boundary

% Label the critical bifurcation point
text(beta_critical, max(V_eq(:)), max(U_eq(:)), sprintf('\\beta_{critical} = %.2f', beta_critical), ...
    'FontSize', 12, 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

hold off;
