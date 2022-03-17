function F = Cons(X)
    %% 等式约束
    Cons1 = sum(X, 2) = ones(N, 1);
    %% 不等式约束
    Cons2 = sum(sum(X .* A_n_k, 1), 2) <= CR_Access_MAX;
    Cons3 = sum(sum(X .* E_n_k, 1), 2) <= CR_Edge_MAX;
    Cons4 = sum(sum(X .* R_n_k, 1), 2) <= B_Fronthaul_MAX;
    Cons5 = all(sum(X .* t_Split, 2) <= t_UE');
    F = Cons1 && Cons2 && Cons3 && Cons4 && Cons5;
