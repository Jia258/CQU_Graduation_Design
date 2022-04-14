function R = R_Cal(X,option)
    R_n_k = evalin('base', 'R_n_k');
    if option == 2
        X=Transform(X);
    end
    R = sum(sum(X .* R_n_k, 1), 2);
