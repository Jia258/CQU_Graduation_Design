function [X_Optimal, Object] = SimuAnPSO(N, K)
    %% 种群参数
    popsize = 500; %种群大小
    iter_max = 500; %迭代次数
    w = 0.5; %惯性权重
    c1 = 2.05; %自我学习因子
    c2 = 2.05; %群体学习因子
    lamda = 0.9; %降温速度

    %% 初始化种群的个体
    X = zeros(N, K, popsize);
    V = zeros(N, K, popsize);

    for i = 1:popsize
        X(:, :, i) = randsrc(N, K, [0, 1; 8/9, 1/9]);
        V(:, :, i) = 2 * randi([0, 1], N, K) - 1;
        %         index=randi([1,9]);
        %         X(:, :, i)=zeros(N, K);
        %         X(:,index,i)=1;
        %         index=randi([1,9]);
        %         V(:, :, i)=zeros(N, K);
        %         V(:,index,i)=1;
        %         X(:, :, i) = randi([0, 1], N, K); %随机初始化位置
        %         V(:, :, i) = randi([0, 1], N, K); %随机初始化速度
    end

    %% 初始化个体最优解和群体最优解
    pbest = X; %个体最优解

    for i = 1:popsize %每个个体的历史最佳适应度

        %         if Cons(X(:, :, i))
        obj_pbest(i) = Obj(X(:, :, i));
        %         else
        %             obj_pbest(i) = 10^10;
        %         end

    end

    gbest = X(:, :, popsize); %群体最优解
    obj_gbest = Obj(X(:, :, popsize)); %种群的历史最佳适应度

    for i = 1:(popsize - 1)

        if obj_pbest(i) < obj_gbest

            gbest = X(:, :, i);
            obj_gbest = obj_pbest(i);

        end

    end

    %% 粒子群迭代
    T = -Obj(gbest) / log(0.2);

    for iter = 1:iter_max
        %模拟退火
        groupFit = Obj(gbest);

        for i = 1:popsize

            Tfit(i) = exp(- (obj_pbest(i) - groupFit) / T);

        end

        SumTfit = sum(Tfit);

        Tfit = Tfit / SumTfit;

        pBet = rand();
        %轮盘赌输策略
        for i = 1:popsize

            CumFit(i) = sum(Tfit(1:i));

            if pBet <= CumFit(i)

                gbest_plus = X(:, :, i);

                break;

            end

        end

        %压缩因子
        C = c1 + c2;

        ksi = 2 / abs(2 - C - sqrt(C^2 - 4 * C));
        % 寻优
        for i = 1:popsize
            %速度更新
            V(:, :, i) = ksi * (V(:, :, i) + c1 * rand * (pbest(:, :, i) - X(:, :, i)) + c2 * rand * (gbest_plus - X(:, :, i)));

            %速度边界处理
            temp = reshape(V(:, :, i), N, K);
            temp(temp > 1) = 1; temp(temp < 0) = 0;
            V(:, :, i) = temp;

            %位置更新
            X(:, :, i) = X(:, :, i) + V(:, :, i);

            %位置边界处理
            temp = reshape(X(:, :, i), N, K);
            temp(temp > 1) = 1; temp(temp < 0) = 0;
            X(:, :, i) = temp;

            %0-1变量取整
            X(:, :, i) = round(X(:, :, i));

            %进行约束条件判断并计算新种群各个个体位置的适应度
            if Cons(X(:, :, i)) %约束条件
                obj_pop(i) = Obj(X(:, :, i)); %当前个体的适应度
            else
                obj_pop(i) = 10^3;
            end

            %新适应度与个体历史最佳适应度做比较
            if obj_pop(i) < obj_pbest(i)
                pbest(:, :, i) = X(:, :, i); %更新个体历史最佳位置
                obj_pbest(i) = obj_pop(i); %更新个体历史最佳适应度
            end

            %个体历史最佳适应度与种群历史最佳适应度做比较
            if obj_pbest(i) < obj_gbest
                gbest = pbest(:, :, i); %更新群体历史最佳位置
                obj_gbest = obj_pbest(i); %更新群体历史最佳适应度
            end

        end

        T = T * lamda;

        record(iter) = Obj(gbest);
        disp(['第', num2str(iter), '次迭代 最优目标值为', num2str(obj_gbest)]);

    end

    r = [1:1:iter_max];
    plot(r, record, 'r--', 'linewidth', 2);
    xlabel('迭代次数')
    ylabel('适应度值')
    title('算法收敛曲线')
    legend('基于模拟退火的PSO算法')
    grid on
    hold on

    X_Optimal = gbest

    Object = Obj(gbest)
