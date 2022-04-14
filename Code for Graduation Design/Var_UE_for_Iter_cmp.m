%% 改变UE数量
p_ini = 5; %初始UE数量
p_step = 5; %UE步长
p_fin = 40; %终止UE数量
iter_CD = zeros(1, 8); %存放分离成本的矩阵


while p_ini <= p_fin
    popsize = p_ini;
    Main
    iter_CD(popsize / 5) = Optimal_F;
    p_ini = popsize + p_step;
end
assignin('base','iter_CD',iter_CD);
%% 绘图
% axisx = linspace(10, 100, 10);
% CDplot(axisx, CD)
% PSplot(axisx, PS)
% FCplot(axisx, FC)
