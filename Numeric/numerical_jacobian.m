function J = numerical_jacobian(f, x, h_init)
    % Compute the Jacobian of a vector-valued function f at point x using central differences
    % and adaptive step size selection.
    %
    % Parameters:
    % f: function handle, vector-valued function f(x).
    % x: array, the point at which to compute the Jacobian.
    % h_init: float, initial step size (default: 1e-6).
    %
    % Returns:
    % J: array, the Jacobian matrix.

    if nargin < 3
        h_init = 1e-6; % Default initial step size
    end

    n = length(x); % Number of input variables
    m = length(f(x)); % Number of output functions
    J = zeros(m, n); % Initialize Jacobian matrix
    epsilon = eps; % Machine precision

    for j = 1:n
        % Adaptive step size
        h = sqrt(epsilon) * max(1, abs(x(j)));

        % Perturb x_j by h
        x_plus = x;
        x_minus = x;
        x_plus(j) = x_plus(j) + h;
        x_minus(j) = x_minus(j) - h;

        % Evaluate the function at the perturbed points
        f_plus = f(x_plus);
        f_minus = f(x_minus);

        % Compute partial derivatives using central differences
        for i = 1:m
            J(i, j) = (f_plus(i) - f_minus(i)) / (2 * h);
        end
    end
end