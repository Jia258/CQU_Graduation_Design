function z = COA_Generate(N, popsize, type) %产生混沌序列
    z = zeros(N, popsize);

    if strcmp(type, 'logistic')
        y = rand(N, 1);
        mu = 4;

        for p = 1:popsize
            z(:, p) = y;
            y = mu .* y .* (1 - y);
        end

    elseif strcmp(type, 'tent')
        y = rand(N, 1);
        u = 0.5;

        for p = 1:popsize
            z(:, p) = y;
            c1=(0<=y&y<u);
            c2=(u<=y&y<=1);
            y=c1.*y/u+c2.*(1-y)/(1-u);
        end
    elseif strcmp(type,'gaussian')
            y = rand(N, 1);
        for p = 1:popsize
            z(:, p) = y;
            c=(y==0);
            y=c.*0+(~c).*(1./y-floor(1./y));
        end
    elseif strcmp(type, 'circle')
        y = rand(N, 1);
        a = 0.5;
        b = 0.2;

        for p = 1:popsize
            z(:, p) = y;
            y = y + a - mod((b / (2 * pi)) * sin(2 * pi * y), 1);
        end

    end
