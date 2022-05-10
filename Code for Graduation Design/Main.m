% 主程序
%% 常量生成
format long
Global_Constant

%% 用户生成
UE_Generate

%% 计算资源矩阵
Computation_Resource_Model

%% 带宽资源矩阵
Bandwidth_Resource_Model

%% 智能算法求解
%[Optimal_X, Optimal_F,t_all] = Split_COASAHPSO_Fast();

%% YALMIP求解
% 创建决策变量
X = binvar(N, K); %0-1变量
% 目标函数
CR_Access = sum(sum(X .* A_n_k, 1), 2);
CR_Edge = sum(sum(X .* E_n_k, 1), 2);
R = sum(sum(X .* R_n_k, 1), 2);
F = alpha * PUE_Access * (CR_Access / CR_Access_MAX) + beta * PUE_Edge * (CR_Edge / CR_Edge_MAX) +gamma * (R / B_Fronthaul_MAX);
% 约束条件
% 等式约束
Cons1 = sum(X, 2) == ones(N, 1);
% 不等式约束
Cons2 = sum(sum(X .* A_n_k, 1), 2) <= CR_Access_MAX;
Cons3 = sum(sum(X .* E_n_k, 1), 2) <= CR_Edge_MAX;
Cons4 = sum(sum(X .* R_n_k, 1), 2) <= B_Fronthaul_MAX;
Cons5 = sum(X .* t_Split_Matrix, 2) <= t_UE';
Cons = Cons1 + Cons2 + Cons3 + Cons4 + Cons5;
% 选项配置

ops = sdpsettings('solver', 'lpsolve', 'verbose', 2);
% 求解
result = solvesdp(Cons, F, ops);
%T=result.yalmiptime+result.solvertime
if result.problem == 0
    Optimal_X = value(X);
    Optimal_F = value(F);
else
    disp('求解过程中出错');
end
