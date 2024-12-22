function p = taylorPolynomial(f, a, n)
    % f: function handle for the function f(x)
    % a: point around which the Taylor polynomial is generated
    % n: degree of the Taylor polynomial

    % Symbolic variable
    syms x

    % Compute the derivatives
    derivatives = zeros(1, n + 1);
    derivatives(1) = subs(f(x), x, a); % f(a)

    for k = 1:n
        df = diff(f(x), k); % k-th derivative of f(x)
        derivatives(k + 1) = subs(df, x, a); % k-th derivative evaluated at a
    end

    % Construct the Taylor polynomial
    p = 0;
    for k = 0:n
        p = p + (derivatives(k + 1) / factorial(k)) * (x - a)^k;
    end
end