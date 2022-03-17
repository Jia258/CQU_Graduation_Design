function F = Obj(X)
    CR_Access = sum(sum(X .* A_n_k, 1), 2);
    CR_Edge = sum(sum(X .* E_n_k, 1), 2);
    R = sum(sum(X .* R_n_k, 1), 2);
    F = alpha * PUE_Access * (CR_Access / CR_Access_MAX) + beta * PUE_Edge * (CR_Edge / CR_Edge_Edge) +gamma * (R / B_Fronthaul_MAX);
