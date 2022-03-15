%% 常量定义
global B A LMIMO CR_Access_MAX CR_Edge_MAX B_Fronthaul_MAX
B = 20; %系统带宽
A = 1; %天线模式
LMIMO = 1; %层映射数
CR_Access_MAX = 1060; %接入站点的总计算能力
CR_Edge_MAX = 1060; %边缘站点的总计算能力
B_Fronthaul_MAX = 1288.8; %前传链路容量
M = 1; C = 1; Ld = 1;
%% 参考常量定义
global A_ref B_ref M_ref C_ref LMIMO_ref Ld_ref
A_ref = 2; B_ref = 10; M_ref = 6; C_ref = 5/6; LMIMO_ref = 2; Ld_ref = 1;

%% 计算资源模型常量定义
global SIGMA
global G_ref
SIGMA = [0.2 0.3 0.5];
G_ref = [200 20 10 30 80 720];
%% 带宽资源模型常量定义
global n_RB fs
n_RB = 100; fs = 30.72;
global alpha_0 alpha_1 alpha_2 alpha_3 alpha_4 alpha_5 alpha_6 alpha_7 alpha_8
global beta_1 beta_2
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
global PUE_Access PUE_Edge
PUE_Access = 2.3;
PUE_Edge = 1.5;

%% 分离时延
t_Split = [30 30 6 2 0.25 0.25 0.25 0.25 0.25];

%% 用户需求时延
t_eMBB = [1 2 3 4];
t_uRLLC = [0.1 0.2 0.3 0.4];

%% 用户需求流量
Ld_eMBB_Min = 10; Ld_eMBB_Max = 100;
Ld_uRLLC_Min = 1; Ld_uRLLC_Max = 10;

%% MCS Index
load('MCS_Table')
