function [Optimal_X, Optimal_F,t_all] = Split_HPSO_Fast()
    N = evalin('base', 'N');
    %% 种群参数
    popsize = 20; %种群大小
    iter_max = 20; %迭代次数
    %% 初始化
    X = zeros(N, popsize);
    V = zeros(N, popsize);
    V_new = zeros(N, popsize);
    % 初始化粒子位置和速度
    for p = 1:popsize
        X(:, p) = randi([2, 8], N, 1);
        V(:, p) = randi([-6, 6], N, 1);
    end

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

    %% 粒子群迭代

    for iter = 1:iter_max
        tic
        %更新个体最优和群体最优
        for p = 1:popsize

            if Obj(X(:, p)) < Obj(pbest(:, p))
                pbest(:, p) = X(:, p);
            end

            if Obj(pbest(:, p)) < Obj(gbest)
                gbest = pbest(:, p);
            end

        end

        % 记录上一次迭代的粒子速度
        V_old = V;

        % 速度更新
        u1 = 0.3 * rand(N, popsize);
        u2 = 0.7 * rand(N, popsize);
        c = u1 > u2;
        V_new = c .* ones(N, popsize) .* (pbest - X) + (~c .* ones(N, popsize)) .* (gbest - X);

        % 限制粒子位置区间
        X_new = X + V_new;
        X_old = X + V_old;

        new_lb = X_new - 2;
        new_ub = X_new - 8;
        old_lb = X_old - 2;
        old_ub = X_old - 8;

        cn_lb = new_lb < 0;
        cn_ub = new_ub > 0;
        V_new = cn_lb .* ones(N, popsize) .* (V_new + abs(new_lb)) + cn_ub .* ones(N, popsize) .* (V_new - abs(new_ub)) ...
            + (~(cn_lb + cn_ub)) .* ones(N, popsize) .* V_new;

        co_lb = old_lb < 0;
        co_ub = old_ub > 0;
        V_old = co_lb .* ones(N, popsize) .* (V_old + abs(old_lb)) + co_ub .* ones(N, popsize) .* (V_old - abs(old_ub)) ...
            + (~(co_lb + co_ub)) .* ones(N, popsize) .* V_old;
        t(iter) = toc;

        for p = 1:popsize

            for i = 1:N
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

        %record(iter) = Obj(Cgbest);
        %disp(['第', num2str(iter), '次迭代 最优目标值为', num2str(Obj(Cgbest))]);

    end

    t_all = sum(t)
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
