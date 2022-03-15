%% 常量定义
%% 公共常量定义
global A_ref B_ref M_ref C_ref LMIMO_ref Ld_ref
A_ref = 2; B_ref = 10; M_ref = 6; C_ref = 5/6; LMIMO_ref = 2; Ld_ref = 1;

%% 计算资源模型常量定义
global SIGMA1 SIGMA2 SIGMA3
global G1_ref G2_ref G3_ref G4_ref G5_ref = 80 G6_ref
SIGMA1 = 0.2; SIGMA2 = 0.3; SIGMA3 = 0.5;
G1_ref = 200; G2_ref = 20; G3_ref = 10; G4_ref = 30; G5_ref = 80; G6_ref = 720;

%% 带宽资源模型常量定义
global n_RB fs
n_RB = 100; fs = 30.72;
global alpha_0 alpha_1 alpha_2 alpha_3 alpha_4 alpha_5 alpha_6 alpha_7 alpha_8
global beta_1 beta_2
% 系数计算
[Coef] = Coefficient_Calculation()
alpha_0 = Coef(1)
alpha_1 = Coef(2)
alpha_2 = Coef(3)
alpha_3 = Coef(4)
alpha_4 = Coef(5)
alpha_5 = Coef(6)
alpha_6 = Coef(7)
alpha_7 = Coef(8)
alpha_8 = Coef(9)
beta_1 = Coef(10)
beta_2 = Coef(11)

%% 功率消耗模型常量定义
global PUE_Access PUE_Edge
PUE_Access = 2.3
PUE_Edge = 1.5
