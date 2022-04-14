%% 改变UE数量
N_ini = 10; %初始UE数量
N_step = 10; %UE步长
N_fin = 100; %终止UE数量
Time = zeros(1, 10); %存放分离成本的矩阵


while N_ini <= N_fin
    N = N_ini;
    Main
    Time(N / 10) = t_all;
    N_ini = N_ini + N_step;
end
assignin('base','t4',Time);
%% 绘图
% axisx = linspace(10, 100, 10);
% CDplot(axisx, CD)
% PSplot(axisx, PS)
% FCplot(axisx, FC)
