% SNR_CQI
%% 常量定义
P_gNB_tx = 20; %基站发射功率
P_UE_tx = 0.1; %UE发射功率
G_tx = 8; %天线发射增益
omega = 5; %阴影系数
n_sigma = -174; %噪声功率
N=100;
gNB_x = 0; gNB_y = 0; %基站位置
%% 用户布局生成
for i=1:N
    flag=1;
    while flag
        x(i)=-0.5 + (0.5 - (-0.5)) * rand;
        y(i)=-0.5 + (0.5 - (-0.5)) * rand;
        if sqrt(x(i).^2 + y(i).^2)<0.5
            UE_x(i)= x(i);
            UE_y(i)= y(i);
            flag=0;
        end
    end
end
scatter(gNB_x, gNB_y, 200, 'r','p','filled');
hold on
scatter(UE_x, UE_y, 20, 'b','o','filled');
xlabel('\it x\rm(km)','FontSize',12.5);
ylabel('\it y\rm(km)','FontSize',12.5);
legend({'gNB','UE'},'location','northeast','FontName','times','FontSize',10.5);%legend('boxoff');
axis equal
set(gca,'XLim',[-0.5 0.5]);
set(gca,'YLim',[-0.5 0.5]);
grid on;box on;
set(gca,'gridlinestyle',':','FontName', 'Times');
ax=gca;
ax.GridAlpha=1;
set(gcf, 'color', 'w');
%% 路径损耗和信道增益计算
D = sqrt(UE_x.^2 + UE_y.^2);
LD = 128.1 + 37.6 * log10(D);
G_i = 10.^(-LD / 20) .* sqrt(G_tx * omega);
%% SNR计算
noise = 10^(-174/10) * 2000 * 10^6/1000;

for i = 1:N
    d = sqrt((UE_x - UE_x(i)).^2 + (UE_y - UE_y(i)).^2);
    Ld = 128.1 + 37.6 * log10(d);
    G_UE_i = 10.^(-Ld / 20) .* sqrt(omega);
    P_UE_i=P_UE_tx*G_UE_i;
    G_UE_i(i) = 0;
    SNR = 10 * log10(P_gNB_tx * G_i / (noise + sum(G_UE_i)));
end

%% SNR与CQI和MCS的映射
load('SNR_MCS_Table')

for i = 1:N
    
    if SNR(i) <= SNR_MCS_Table(1, 1)
        M(i) = SNR_MCS_Table(2, 1);
        C(i) = SNR_MCS_Table(3, 1);
    elseif SNR_MCS_Table(1, 1) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 2)
        M(i) = SNR_MCS_Table(2, 2);
        C(i) = SNR_MCS_Table(3, 2);
    elseif SNR_MCS_Table(1, 2) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 3)
        M(i) = SNR_MCS_Table(2, 3);
        C(i) = SNR_MCS_Table(3, 3);
    elseif SNR_MCS_Table(1, 3) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 4)
        M(i) = SNR_MCS_Table(2, 4);
        C(i) = SNR_MCS_Table(3, 4);
    elseif SNR_MCS_Table(1, 4) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 5)
        M(i) = SNR_MCS_Table(2, 5);
        C(i) = SNR_MCS_Table(3, 5);
    elseif SNR_MCS_Table(1, 5) <= SNR(i) && SNR(i) <= SNR_MCS_Table(1, 6)
        M(i) = SNR_MCS_Table(2, 6);
        C(i) = SNR_MCS_Table(3, 6);
    elseif SNR_MCS_Table(1, 6) <= SNR(i) && SNR(i) <= SNR_MCS_Table(1, 7)
        M(i) = SNR_MCS_Table(2, 7);
        C(i) = SNR_MCS_Table(3, 7);
    elseif SNR_MCS_Table(1, 7) <= SNR(i) && SNR(i) <= SNR_MCS_Table(1, 8)
        M(i) = SNR_MCS_Table(2, 8);
        C(i) = SNR_MCS_Table(3, 8);
    elseif SNR_MCS_Table(1, 8) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 9)
        M(i) = SNR_MCS_Table(2, 9);
        C(i) = SNR_MCS_Table(3, 9);
    elseif SNR_MCS_Table(1, 9) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 10)
        M(i) = SNR_MCS_Table(2, 10);
        C(i) = SNR_MCS_Table(3, 10);
    elseif SNR_MCS_Table(1, 10) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 11)
        M(i) = SNR_MCS_Table(2, 11);
        C(i) = SNR_MCS_Table(3, 11);
    elseif SNR_MCS_Table(1, 12) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 13)
        M(i) = SNR_MCS_Table(2, 12);
        C(i) = SNR_MCS_Table(3, 12);
    elseif SNR_MCS_Table(1, 13) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 14)
        M(i) = SNR_MCS_Table(2, 13);
        C(i) = SNR_MCS_Table(3, 13);
    elseif SNR_MCS_Table(1, 14) <= SNR(i) && SNR(i) < SNR_MCS_Table(1, 15)
        M(i) = SNR_MCS_Table(2, 14);
        C(i) = SNR_MCS_Table(3, 14);
    else
        M(i) = SNR_MCS_Table(2, 15);
        C(i) = SNR_MCS_Table(3, 15);
    end
    
end
