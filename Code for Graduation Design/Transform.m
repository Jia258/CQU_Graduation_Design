function X_matrix = Transform(X, index)
    N = evalin('base', 'N');
    K = evalin('base', 'K');
    X = abs(X);
    X = X + 1;
    X_matrix = zeros(N, K);

    for i = 1:N
        X_matrix(i, X(i)) = 1;
    end

end
