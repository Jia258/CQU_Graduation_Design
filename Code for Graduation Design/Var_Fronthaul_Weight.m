clear;
%% 改变前传链路权重
gamma_ini = 10; %初始UE数量
gamma_step = 10; %UE步长
gamma_fin = 80; %终止UE数量
CD = zeros(10, 8); %存放分离成本的矩阵
PS = zeros(8, 9); %存放分离百分比的矩阵
FC = zeros(10, 8); %存放分离前传消耗的矩阵
LS=zeros(10,8);%存放时延满意度的矩阵
N=100;
beta=0.45;alpha=0.45;
while gamma_ini <= gamma_fin
    gamma = gamma_ini/100;
    sum_X = zeros(N, 9);
    sum_F = 0;
    Main
    sum_F = sum_F + Optimal_F;
    sum_X = sum_X + Optimal_X;
    CD(10, gamma_ini / 10 ) = sum_F;
    PS(gamma_ini / 10 , :) = sum(sum_X, 1) / N;
    FC(10, gamma_ini / 10 ) = R_Cal(Optimal_X,1);
    LS(10,gamma_ini / 10 )=sum((t_UE'-sum(Optimal_X .* t_Split, 2))./t_UE');
    % 计算每个小区分离的总部署成本
    for j = 0:8
        X = j * ones(N, 1);
        CD(j + 1, gamma_ini / 10) = Obj(X);
        FC(j + 1, gamma_ini / 10) = R_Cal(X,2);
        X = Transform(X);
        LS(j + 1, gamma_ini / 10) = sum((t_UE'-sum(X .* t_Split, 2))./t_UE');
    end
    gamma_ini = gamma_ini + gamma_step;
    alpha=alpha-0.05;beta=beta-0.05;
end

%% 绘图
axisx = linspace(0.1, 0.8, 8);
CDplot(axisx, CD)
xlabel('\it\gamma\rm (Fronthaul weight)','FontName','times', 'FontSize', 12.5);
PSplot(axisx, PS)
xlabel('\it\gamma\rm (Fronthaul weight)','FontName','times', 'FontSize', 12.5);
FCplot(axisx, FC)
xlabel('\it\gamma\rm (Fronthaul weight)','FontName','times', 'FontSize', 12.5);
LSplot(axisx, LS)
xlabel('\it\gamma\rm (Fronthaul weight)','FontName','times', 'FontSize', 12.5);