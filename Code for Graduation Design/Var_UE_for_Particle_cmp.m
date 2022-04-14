%% 改变UE数量
p_ini = 10; %初始UE数量
p_step = 10; %UE步长
p_fin = 50; %终止UE数量
P_CD = zeros(1, 5); %存放分离成本的矩阵


while p_ini <= p_fin
    popsize = p_ini;
    Main
    P_CD(popsize / 10) = t_all;
    p_ini = popsize + p_step;
end
assignin('base','P_T',P_CD);
%% 绘图
% axisx = linspace(10, 100, 10);
% CDplot(axisx, CD)
% PSplot(axisx, PS)
% FCplot(axisx, FC)
