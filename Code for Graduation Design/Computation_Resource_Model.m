%% 计算资源模型
function [CR_Table] = Computation_Resource_Model(M, C, Ld)
    SIGMA1 = SIGMA(1); SIGMA2 = SIGMA(2); SIGMA3 = SIGMA(3);
    G1_ref = G_ref(1); G2_ref = G_ref(2); G3_ref = G_ref(3); G4_ref = G_ref(5); G5_ref = G_ref(5); G6_ref = G_ref(6);
    PF(1).f = @()SIGMA1 * G1_ref * (A / A_ref);
    PF(2).f = @()SIGMA2 * G1_ref * (A / A_ref);
    PF(3).f = @()SIGMA3 * G1_ref * (A / A_ref);
    PF(4).f = @(M, C, Ld)G2_ref * (B / B_ref) * (M ./ M_ref) .* (C ./ C_ref) * (LMIMO / LMIMO_ref) .* (Ld ./ Ld_ref);
    PF(5).f = @(Ld)G3_ref * (A / A_ref)^2 * (B / B_ref) * (Ld ./ Ld_ref);
    PF(6).f = @(Ld)G4_ref * (A / A_ref) * (B / B_ref) * (Ld ./ Ld_ref);
    PF(7).f = @()G5_ref * (A / A_ref) * (B / B_ref);
    PF(8).f = @()G6_ref * (A / A_ref) * (B / B_ref);

    %% 处理功能计算量矩阵
    CR_Table = zeros(length(PF), length(Ld));

    for i = 1:8

        if i == 4
            CR_Table(i, :) = PF(i).f(M, C, Ld);
        elseif i == 5 || i == 6
            CR_Table(i, :) = PF(i).f(Ld);
        else
            CR_Table(i, :) = PF(i).f() * ones(1, length(Ld));
        end

    end

    CR_Table = CR_Table';

end
