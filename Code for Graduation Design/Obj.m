function F = Obj(X)
    %% 读取工作区变量
    N = evalin('base', 'N');
    K = evalin('base', 'K');
    A_n_k = evalin('base', 'A_n_k');
    E_n_k = evalin('base', 'E_n_k');
    R_n_k = evalin('base', 'R_n_k');
    alpha = evalin('base', 'alpha');
    PUE_Access = evalin('base', 'PUE_Access');
    CR_Access_MAX = evalin('base', 'CR_Access_MAX');
    beta = evalin('base', 'beta');
    PUE_Edge = evalin('base', 'PUE_Edge');
    CR_Edge_MAX = evalin('base', 'CR_Edge_MAX');
    gamma = evalin('base', 'gamma');
    B_Fronthaul_MAX = evalin('base', 'B_Fronthaul_MAX');

    %% 列向量转矩阵
    X = reshape(X, [N, 1]);
    X = Transform(X);
    %% 目标函数计算
    CR_Access = sum(sum(X .* A_n_k, 1), 2);
    CR_Edge = sum(sum(X .* E_n_k, 1), 2);
    R = sum(sum(X .* R_n_k, 1), 2);
    F = alpha * PUE_Access * (CR_Access / CR_Access_MAX) + beta * PUE_Edge * (CR_Edge / CR_Edge_MAX) +gamma * (R / B_Fronthaul_MAX);
