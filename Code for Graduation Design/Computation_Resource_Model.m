% 计算资源模型
%% 处理功能计算量匿名函数
Sigma1 = Sigma(1); Sigma2 = Sigma(2); Sigma3 = Sigma(3);
G1_ref = G_ref(1); G2_ref = G_ref(2); G3_ref = G_ref(3); G4_ref = G_ref(5); G5_ref = G_ref(5); G6_ref = G_ref(6); %匿名函数不能读取工作区的向量
PF(1).f = @()Sigma1 * G1_ref * (A / A_ref);
PF(2).f = @()Sigma2 * G1_ref * (A / A_ref);
PF(3).f = @()Sigma3 * G1_ref * (A / A_ref);
PF(4).f = @(M, C, Ld)G2_ref * (B / B_ref) * (M ./ M_ref) .* (C ./ C_ref) * (LMIMO / LMIMO_ref) .* (Ld ./ Ld_ref);
PF(5).f = @(Ld)G3_ref * (A / A_ref)^2 * (B / B_ref) * (Ld ./ Ld_ref);
PF(6).f = @(Ld)G4_ref * (A / A_ref) * (B / B_ref) * (Ld ./ Ld_ref);
PF(7).f = @()G5_ref * (A / A_ref) * (B / B_ref);
PF(8).f = @()G6_ref * (A / A_ref) * (B / B_ref);

%% 处理功能计算量矩阵
CR_Table = zeros(length(PF), length(Ld)); %预分配内存

for i = 1:length(PF)

    if i == 4
        CR_Table(i, :) = PF(i).f(M, C, Ld);
    elseif i == 5 || i == 6
        CR_Table(i, :) = PF(i).f(Ld);
    else
        CR_Table(i, :) = PF(i).f() * ones(1, length(Ld));
    end

end

CR_Table = CR_Table'; %转置
% 累加求和
E_Temp = cumsum(CR_Table, 2);
A_Temp = cumsum(CR_Table, 2, 'reverse');
Cat_Zero = zeros(length(Ld), 1);
% 每个用户所有可能的分离选项的计算量矩阵
E_n_k = cat(2, Cat_Zero, E_Temp);
A_n_k = cat(2, A_Temp, Cat_Zero);
