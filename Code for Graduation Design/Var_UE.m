%% 改变UE数量
N_ini = 10; %初始UE数量
N_step = 10; %UE步长
N_fin = 100; %终止UE数量
CD = zeros(10, 10); %存放分离成本的矩阵
PS = zeros(10, 9); %存放分离百分比的矩阵
FC = zeros(10, 10); %存放分离前传消耗的矩阵
LS=zeros(10,10);%存放时延满意度的矩阵

while N_ini <= N_fin
    N = N_ini;
    sum_X = zeros(N, 9);
    sum_F = 0;
    Main
    %%
    sum_F = sum_F + Optimal_F;
    sum_X = sum_X + Optimal_X;
    CD(10, N / 10) = sum_F;
    PS(N / 10, :) = sum(sum_X, 1) / N;
    FC(10, N / 10) = R_Cal(Optimal_X,1);
    LS(10,N/10)=sum((t_UE'-sum(Optimal_X .* t_Split, 2))./t_UE');
    % 计算每个小区分离的总部署成本
    for j = 0:8
        X = j * ones(N, 1);
        CD(j + 1, N / 10) = Obj(X);
        FC(j + 1, N / 10) = R_Cal(X,2);
        X = Transform(X);
        LS(j + 1, N / 10) = sum((t_UE'-sum(X .* t_Split, 2))./t_UE');
    end
    
    N_ini = N_ini + N_step;
end

%% 绘图
axisx = linspace(10, 100, 10);
CDplot(axisx, CD)
PSplot(axisx, PS)
FCplot(axisx, FC)
LSplot(axisx, LS)
