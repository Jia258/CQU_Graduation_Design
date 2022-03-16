% 用户数据生成
%% MCS
I_MCS = randi([1, 29], 1, N);
M = MCS_Table(1, I_MCS);
C = MCS_Table(2, I_MCS);

%% 流量和时延生成
L = zeros(1, N); %预分配内存
Ld = zeros(1, N); %预分配内存
t_UE = zeros(1, N); %预分配内存

for i = 1:N

    if i <= N * eMBB_ration %生成一定比例的eMBB和uRLLC业务用户
        L(i) = randi([Ld_eMBB_Min, Ld_eMBB_Max]);
        t_UE(i) = t_eMBB(randi([1, 4]));
    else
        L(i) = randi([Ld_uRLLC_Min, Ld_uRLLC_Max]);
        t_UE(i) = t_eMBB(randi([1, 4]));
    end

end

%打乱数据
% L = L(randperm(N));
% t_UE = t_UE(randperm(N));

%生成流量负载
for i = 1:N
    Ld(i) = L(i) / sum(L);
end
