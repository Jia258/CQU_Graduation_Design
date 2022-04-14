function [Optimal_X, Optimal_F] = Split_QPSO()
    N = evalin('base', 'N');
    %% 种群参数
    popsize = 40; %种群大小 40可以找到和求解器一样的解
    iter_max = 20; %迭代次数
    lamda = 0.9; %降温速度
    %% 初始化
    % 初始化粒子位置和速度
    X = round(2 + (8 - 2) * COA_Generate(N, popsize, 'logistic'));

    % 假定一个全局最优
    gbest = 3 * ones(N, 1);
    f_gbest = Obj(gbest);
    %% 1
    % 假定一组个体最优
    %     for p = 1:popsize
    %
    %         for n = 1:N
    %             Cons_flag = 1;
    %
    %             while Cons_flag
    %
    %                 if Cons_S(X(n, p), n)
    %                     Cons_flag = 0;
    %                 else
    %                     X(n, p) = X(n, p) + 1;
    %                 end
    %
    %             end
    %
    %         end
    %
    %         pbest(:, p) = X(:, p);
    %         f_pbest(p) = Obj(pbest(:, p));
    %     end
    %% 2
    pbest = 4 * ones(N, popsize);

    for p = 1:popsize
        f_pbest(p) = Obj(pbest(:, p));
    end

    T = -Obj(gbest) / log(0.2); %初始温度

    %% 粒子群迭代
    for iter = 1:iter_max
        % 收缩-扩张系数计算
        tic;
        beta = ((1.5 - 0.4) / 2) * cos(iter * pi / iter_max) + ((1.5 + 0.4) / 2);
        mbest = sum(pbest, 2) / popsize;
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

        t1(iter) = toc;

        for p = 1:popsize
            tic
            % 计算随机点
            fi1 = rand(N, 1);
            fi2 = rand(N, 1);
            fi = rand(N, 1);
            P = (fi1 .* pbest(:, p) + fi2 .* gbest_plus) ./ (fi1 + fi2);
            u = rand(N, 1);
            c = (u >= 0.5);
            X(:, p) = c .* (P + beta .* abs(mbest - X(:, p)) .* log(1 ./ u)) + (~c) .* (P - beta .* abs(mbest - X(:, p)) .* log(1 ./ u));
            % 限制范围和取整
            temp = X(:, p) - (8 + 2) / 2;
            temp = sign(temp) .* min(abs(temp), (8 - 2) / 2);
            X(:, p) = temp + (8 + 2) / 2;
            X(:, p) = floor(X(:, p));
            t2(iter)=toc;
            % 确保满足时延约束
            for n = 1:N
                Cons_flag = 1;

                while Cons_flag

                    if Cons_S(X(n, p), n)
                        Cons_flag = 0;
                    else
                        X(n, p) = X(n, p) + 1;
                    end

                end

                f_X(p) = Obj(X(:, p));
            end

            tic;
            %更新个体最优
            if f_X(p) < f_pbest(p)
                pbest(:, p) = X(:, p);
                f_pbest(p) = f_X(p);
            end

            %更新全局最优
            if f_pbest(p) < f_gbest
                gbest = pbest(:, p);
                f_gbest = f_pbest(p);
            end

            t3(iter) = toc;
        end

%         record(iter) = f_gbest;
        disp(['第', num2str(iter), '次迭代 最优目标值为', num2str(f_gbest)]);
    end

    t_all = sum(t1) + sum(t2)+sum(t3)
%     r = [1:1:iter_max];
%     plot(r, record, 'r--', 'linewidth', 2);
%     xlabel('迭代次数')
%     ylabel('适应度值')
%     title('算法收敛曲线')
%     legend('基于模拟退火的PSO算法')
%     grid on
%     hold on

    Optimal_X = Transform(gbest)

    Optimal_F = f_gbest
end
