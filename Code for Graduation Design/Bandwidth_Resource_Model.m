% 带宽资源模型
%% 带宽计算量匿名函数
BR(1).f = @(Ld)alpha_0 * Ld;
BR(2).f = @(Ld)alpha_1 * Ld;
BR(3).f = @(Ld)alpha_2 * Ld;
BR(4).f = @(Ld)alpha_3 * Ld;
BR(5).f = @(M, Ld)alpha_4 * (M / M_ref) * (LMIMO / LMIMO_ref) .* Ld + beta_1;
BR(6).f = @(Ld)alpha_5 * Ld * A + beta_2 * A;
BR(7).f = @()alpha_6 * A * n_RB;
BR(8).f = @()alpha_7 * A * fs;
BR(9).f = @()alpha_8 * A * fs;

%% 每个用户所有可能的分离选项的前传带宽矩阵
R_n_k = zeros(length(BR), length(Ld)); %预分配内存

for i = 1:length(BR)

    if i == 5
        R_n_k(i, :) = BR(i).f(M, Ld);
    elseif i == 7 || i == 8 || i == 9
        R_n_k(i, :) = BR(i).f();
    else
        R_n_k(i, :) = BR(i).f(Ld);
    end

end

R_n_k = R_n_k'; %转置
