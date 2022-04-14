function F = Cons(X)
    %% 读取工作区变量
    N = evalin('base', 'N');
    K = evalin('base', 'K');
    A_n_k = evalin('base', 'A_n_k');
    E_n_k = evalin('base', 'E_n_k');
    R_n_k = evalin('base', 'R_n_k');
    t_Split = evalin('base', 't_Split');
    t_UE = evalin('base', 't_UE');
    CR_Access_MAX = evalin('base', 'CR_Access_MAX');
    CR_Edge_MAX = evalin('base', 'CR_Edge_MAX');
    B_Fronthaul_MAX = evalin('base', 'B_Fronthaul_MAX');

    %% 列向量转矩阵
    X = reshape(X, [N, 1]);
    X = Transform(X);
    %% 等式约束
    Cons1 = all(sum(X, 2) == ones(N, 1));
    %% 不等式约束
    Cons2 = sum(sum(X .* A_n_k, 1), 2) <= CR_Access_MAX;
    Cons3 = sum(sum(X .* E_n_k, 1), 2) <= CR_Edge_MAX;
    Cons4 = sum(sum(X .* R_n_k, 1), 2) <= B_Fronthaul_MAX;
    Cons5 = all(sum(X .* t_Split, 2) <= t_UE');
    F = Cons1 & Cons2 & Cons3 & Cons4 & Cons5;
