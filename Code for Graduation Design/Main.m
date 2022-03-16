% 主程序
%% 常量生成
Global_Constant

%% 用户生成
M = 6 * ones(1, 100); C = ones(1, 100); Ld = rand() * ones(1, 100);

%% 计算资源矩阵
Computation_Resource_Model

%% 带宽资源矩阵
Bandwidth_Resource_Model
