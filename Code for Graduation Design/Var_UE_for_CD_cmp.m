%% 改变UE数量
N_ini = 10; %初始UE数量
N_step = 10; %UE步长
N_fin = 100; %终止UE数量
CD = zeros(1, 10); %存放分离成本的矩阵


while N_ini <= N_fin
    N = N_ini;
    Main
    CD(N / 10) = Optimal_F;
    N_ini = N_ini + N_step;
end
assignin('base','alog_CD3',CD);
%% 绘图
% axisx = linspace(10, 100, 10);
% CDplot(axisx, CD)
% PSplot(axisx, PS)
% FCplot(axisx, FC)
