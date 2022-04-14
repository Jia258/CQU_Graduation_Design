function X_matrix = Transform_S(X, index)
    N = evalin('base', 'N');
    K = evalin('base', 'K');
    X = abs(X);
    X = X + 1;
    X_matrix = zeros(N, K);
    X_matrix(index, X) = 1;
end
