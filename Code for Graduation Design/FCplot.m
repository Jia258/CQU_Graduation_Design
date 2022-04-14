function FCplot(x, y)
    figure(3)
    semilogy(x, y(1, :), '-.o', 'LineWidth', 2, 'Color', [255, 217, 47]/256,'MarkerSize',8); hold on;
    semilogy(x, y(2, :), '-.+', 'LineWidth', 2, 'Color', [0, 118, 174]/256,'MarkerSize',10); hold on;
    semilogy(x, y(3, :), '-.*', 'LineWidth', 2, 'Color', [255, 116, 0]/256,'MarkerSize',10); hold on;
    semilogy(x, y(4, :), '-.x', 'LineWidth', 2, 'Color', [0, 161, 59]/256,'MarkerSize',10); hold on;
    semilogy(x, y(5, :), '-.s', 'LineWidth', 2, 'Color', [158, 99, 181]/256,'MarkerSize',10); hold on;
    semilogy(x, y(6, :), '-.d', 'LineWidth', 2, 'Color', [152, 82, 74]/256,'MarkerSize',8); hold on;
    semilogy(x, y(7, :), '-.p', 'LineWidth', 2, 'Color', [246, 110, 184]/256,'MarkerSize',8); hold on;
    semilogy(x, y(8, :), '-.h', 'LineWidth', 2, 'Color', [127, 124, 119]/256,'MarkerSize',8); hold on;
    semilogy(x, y(9, :), '-.^', 'LineWidth', 2, 'Color', [194, 189, 44]/256,'MarkerSize',8); hold on;
    semilogy(x, y(10, :), '-.>', 'LineWidth', 2, 'Color', [239, 0, 0]/256,'MarkerSize',8,'MarkerFaceColor',[239, 0, 0]/256); hold on;
    xlabel('N (Numbers of users)','FontName','times','FontSize',12.5);
    ylabel('F [Mbps]','FontName','times','FontSize',12.5);
    legend({'Split 0', 'Split 1', 'Split 2', 'Split 3', 'Split 4', 'Split 5', 'Split 6', 'Split 7', 'Split 8', 'SPLIT-SAIQPSO'}, ...
    'NumColumns', 4, 'Location', 'southoutside', 'FontName','times','FontSize',10.5); legend('boxoff');
    %set(gca,'YLim',[0 1]);
    grid on; %box off;
    set(gca, 'gridlinestyle', ':','FontName', 'Times');
    ax = gca;
    ax.GridAlpha = 1;
    ax.LineWidth = 0.5;
    set(gcf, 'color', 'w');
end
