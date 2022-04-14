function [Optimal_X, Optimal_F] = Split_COASAHPSO()
    N = evalin('base', 'N');
    %% 种群参数
    popsize = 40; %种群大小 40可以找到和求解器一样的解
    iter_max = 25; %迭代次数
    lamda = 0.9; %降温速度
    %% 初始化
    % 初始化粒子位置和速度
    X = round(2 + (8 - 2) * COA_Generate(N, popsize, 'logistic'));
    V = round(-6 + (6 - (-6)) * COA_Generate(N, popsize, 'logistic'));
    V_new = zeros(N, popsize);

    % 假定一个全局最优
    gbest = zeros(N, 1);
    obj_gbest = Obj(gbest);

    for k = 1:8
        G = k * ones(N, 1);

        if Obj(G) < obj_gbest
            gbest = G;
            obj_gbest = Obj(gbest);
        end

    end

    % 假定一组个体最优
    pbest = X;
    tic
    %% 粒子群迭代
    for iter = 1:iter_max

        %更新个体最优和群体最优
        for p = 1:popsize

            if Obj(X(:, p)) < Obj(pbest(:, p))
                pbest(:, p) = X(:, p);
            end

            if Obj(pbest(:, p)) < Obj(gbest)
                gbest = pbest(:, p);
            end

        end

        if iter == 1
            T = -Obj(gbest) / log(0.2); %初始温度
        end

        % 模拟退火
        groupFit = Obj(gbest);

        for p = 1:popsize

            Tfit(p) = exp(- (Obj(X(:, p)) - groupFit) / T);

        end

        SumTfit = sum(Tfit);

        Tfit = Tfit / SumTfit;

        pBet = rand();
        % 轮盘赌输策略
        for p = 1:popsize

            CumFit(p) = sum(Tfit(1:p));

            if pBet <= CumFit(p)
                gbest_plus = X(:, p); break;
            end

        end

        % 记录上一次迭代的粒子速度
        V_old = V;

        for p = 1:popsize
            % 速度更新
            for i = 1:N
                u1 = 0.3 * rand();
                u2 = 0.7 * rand();

                if u1 > u2
                    V_new(i, p) = pbest(i, p) - X(i, p);
                else
                    V_new(i, p) = gbest_plus(i) - X(i, p);
                end

            end

            for i = 1:N

                % 限制粒子位置区间
                x_new = X(i, p) + V_new(i, p);
                x_old = X(i, p) + V_old(i, p);
                new_lb = x_new - 2;
                new_ub = x_new - 8;
                old_lb = x_old - 2;
                old_ub = x_old - 8;

                if new_lb < 0
                    V_new(i, p) = V_new(i, p) + abs(new_lb);
                end

                if new_ub > 0
                    V_new(i, p) = V_new(i, p) - abs(new_ub);
                end

                if old_lb < 0
                    V_old(i, p) = V_old(i, p) + abs(old_lb);
                end

                if old_ub > 0
                    V_old(i, p) = V_old(i, p) - abs(old_ub);
                end

                % 确保满足时延约束
                new_flag = 1;
                old_flag = 1;

                while new_flag && old_flag

                    if Cons_S(X(i, p) + V_new(i, p), i)
                        new_flag = 0;
                    else
                        V_new(i, p) = V_new(i, p) + 1;
                    end

                    if Cons_S(X(i, p) + V_old(i, p), i)
                        old_flag = 0;
                    else
                        V_old(i, p) = V_old(i, p) + 1;
                    end

                end

                %寻找最优速度更新值
                C1 = Obj_S(X(i, p) + V_new(i, p), i);
                C2 = Obj_S(X(i, p) + V_old(i, p), i);

                if C2 < C1
                    V(i, p) = V_old(i, p);
                else
                    V(i, p) = V_new(i, p);
                end

            end

            X(:, p) = X(:, p) + V(:, p); % 位置更新

        end

        %符合约束的群体最优
        Cgbest = X(:, 1);

        for p = 2:popsize

            if Obj(X(:, p)) < Obj(Cgbest) && Cons(X(:, p))
                Cgbest = pbest(:, p);
            end

        end

        T = T * lamda;
        %record(iter) = Obj(Cgbest);
        disp(['第', num2str(iter), '次迭代 最优目标值为', num2str(Obj(Cgbest))]);

    end
    toc
    %     r = [1:1:iter_max];
    %     plot(r, record, 'r--', 'linewidth', 2);
    %     xlabel('迭代次数')
    %     ylabel('适应度值')
    %     title('算法收敛曲线')
    %     legend('基于模拟退火的PSO算法')
    %     grid on
    %     hold on

    Optimal_X = Transform(Cgbest);

    Optimal_F = Obj(Cgbest);
