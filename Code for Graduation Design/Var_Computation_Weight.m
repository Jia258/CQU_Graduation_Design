clear;
%% 改变计算资源权重
alpha_ini = 10; %初始UE数量
alpha_step = 10; %UE步长
alpha_fin = 80; %终止UE数量
CD = zeros(10, 8); %存放分离成本的矩阵
PS = zeros(8, 9); %存放分离百分比的矩阵
FC = zeros(10, 8); %存放分离前传消耗的矩阵
LS=zeros(10,8);%存放时延满意度的矩阵
N=100;
beta=0.8;gamma=0.1;
while alpha_ini <= alpha_fin
    alpha = alpha_ini/100;
    sum_X = zeros(N, 9);
    sum_F = 0;
    Main
    sum_F = sum_F + Optimal_F;
    sum_X = sum_X + Optimal_X;
    CD(10, alpha_ini / 10 ) = sum_F;
    PS(alpha_ini / 10 , :) = sum(sum_X, 1) / N;
    FC(10, alpha_ini / 10 ) = R_Cal(Optimal_X,1);
    LS(10,alpha_ini / 10 )=sum((t_UE'-sum(Optimal_X .* t_Split, 2))./t_UE');
    % 计算每个小区分离的总部署成本
    for j = 0:8
        X = j * ones(N, 1);
        CD(j + 1, alpha_ini / 10) = Obj(X);
        FC(j + 1, alpha_ini / 10) = R_Cal(X,2);
        X = Transform(X);
        LS(j + 1, alpha_ini / 10) = sum((t_UE'-sum(X .* t_Split, 2))./t_UE');
    end
    alpha_ini = alpha_ini + alpha_step;
    beta=beta-0.1;
end

%% 绘图
axisx = linspace(0.1, 0.8, 8);
CDplot(axisx, CD)
xlabel('\it\alpha\rm (RRU computation weight)','FontName','times', 'FontSize', 12.5);
PSplot(axisx, PS)
xlabel('\it\alpha\rm (RRU computation weight)','FontName','times', 'FontSize', 12.5);
FCplot(axisx, FC)
xlabel('\it\alpha\rm (RRU computation weight)','FontName','times', 'FontSize', 12.5);
LSplot(axisx, LS)
xlabel('\it\alpha\rm (RRU computation weight)','FontName','times', 'FontSize', 12.5);