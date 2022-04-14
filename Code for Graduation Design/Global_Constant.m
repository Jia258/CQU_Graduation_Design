% 常量
%% 系统常量
B = 20; %系统带宽
A = 2; %天线模式
LMIMO = 2; %层映射数
CR_Access_MAX = 3 * 28800; %接入站点的总计算能力
CR_Edge_MAX = 28800; %边缘站点的总计算能力
B_Fronthaul_MAX = 3686.7; %前传链路容量
N = 100; %UE数量
K = 9; %分离选项数量
eMBB_ration = 0.5; %eMBB用户业务权重
%uRLLC_ration = 1 - eMBB_ration;
alpha = 0.3; beta = 0.3; gamma = 0.4; %目标函数权重

%% 参考常量定义
A_ref = 2; B_ref = 20; M_ref = 6; C_ref = 5/6; LMIMO_ref = 2; Ld_ref = 1;

%% 计算资源模型常量定义
Sigma = [0.2 0.3 0.5];
G_ref = [200 20 10 30 80 720];

%% 带宽资源模型常量定义
n_RB = 100; fs = 30.72;
% 系数计算
[Coef] = Coefficient_Calculation();
alpha_0 = Coef(1);
alpha_1 = Coef(2);
alpha_2 = Coef(3);
alpha_3 = Coef(4);
alpha_4 = Coef(5);
alpha_5 = Coef(6);
alpha_6 = Coef(7);
alpha_7 = Coef(8);
alpha_8 = Coef(9);
beta_1 = Coef(10);
beta_2 = Coef(11);

%% 功率消耗模型常量定义
PUE_Access = 2.3;
PUE_Edge = 1.5;

%% 分离时延
t_Split = [30 30 6 2 0.25 0.25 0.25 0.25 0.25];
t_Split_Matrix = [];

for t = 1:N
    t_Split_Matrix = [t_Split_Matrix; t_Split];
end

%% 用户需求时延
t_eMBB = [2 4 6 8];
t_uRLLC = [0.25 0.5 0.75 1];

%% 用户需求流量
Ld_eMBB_Min = 10; Ld_eMBB_Max = 100;
Ld_uRLLC_Min = 1; Ld_uRLLC_Max = 10;

%% MCS Index
load('MCS_Table')
