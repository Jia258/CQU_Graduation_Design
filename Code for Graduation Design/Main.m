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

%% 优化求解
% 常量定义
alpha = 0.3; beta = 0.3; gamma = 0.4;
