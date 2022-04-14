clear;
%% 改变eMBB比例
eMBB_ration_ini = 0; %初始UE数量
eMBB_ration_step = 10; %UE步长
eMBB_ration_fin = 100; %终止UE数量
CD = zeros(10, 11); %存放分离成本的矩阵
PS = zeros(11, 9); %存放分离百分比的矩阵
FC = zeros(10, 11); %存放分离前传消耗的矩阵
LS=zeros(10,11);%存放时延满意度的矩阵
N=100;
while eMBB_ration_ini <= eMBB_ration_fin
    eMBB_ration = eMBB_ration_ini/100;
    sum_X = zeros(N, 9);
    sum_F = 0;
    Main
    sum_F = sum_F + Optimal_F;
    sum_X = sum_X + Optimal_X;
    CD(10, eMBB_ration_ini / 10 + 1) = sum_F;
    PS(eMBB_ration_ini / 10 + 1, :) = sum(sum_X, 1) / N;
    FC(10, eMBB_ration_ini / 10 + 1) = R_Cal(Optimal_X,1);
    LS(10,eMBB_ration_ini / 10 + 1)=sum((t_UE'-sum(Optimal_X .* t_Split, 2))./t_UE');
    % 计算每个小区分离的总部署成本
    for j = 0:8
        X = j * ones(N, 1);
        CD(j + 1, eMBB_ration_ini / 10+1) = Obj(X);
        FC(j + 1, eMBB_ration_ini / 10+1) = R_Cal(X,2);
        X = Transform(X);
        LS(j + 1, eMBB_ration_ini / 10+1) = sum((t_UE'-sum(X .* t_Split, 2))./t_UE');
    end

    eMBB_ration_ini = eMBB_ration_ini + eMBB_ration_step;
end

%% 绘图
axisx = linspace(0, 100, 11);
CDplot(axisx, CD)
xlabel('R [%](Rate of eMBB)','FontName','times', 'FontSize', 12.5);
PSplot(axisx, PS)
xlabel('R [%](Rate of eMBB)','FontName','times', 'FontSize', 12.5);
FCplot(axisx, FC)
xlabel('R [%](Rate of eMBB)','FontName','times', 'FontSize', 12.5);
LSplot(axisx, LS)
xlabel('R [%](Rate of eMBB)','FontName','times', 'FontSize', 12.5);