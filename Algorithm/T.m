figure(1)
format long
x = linspace(10, 100, 10);
xlabel('N (Numbers of users)','FontName','times','FontSize',12.5);
colororder({'k','k'})
yyaxis left
h1=plot(x,data(1,:),'-s','LineWidth', 2, 'Color', '#306180','MarkerSize',8,'MarkerFaceColor','#306180');hold on;
errorbar(x,data(1,:),data(2,:),'LineStyle', 'none','LineWidth', 0.8);hold on;
ylabel('T [ms]','FontName','times','FontSize',12.5);
axis([10 100 37 50]);
yyaxis right
h2=plot(x,data(3,:),'-s','LineWidth', 2, 'Color', '#a18021','MarkerSize',8,'MarkerFaceColor','#a18021');hold on;
errorbar(x,data(3,:),data(4,:),'LineStyle', 'none','LineWidth', 0.8);hold on;
ylabel('T [ms]','FontName','times','FontSize',12.5);
axis([10 100 0 6200]);
legend([h1,h2],{'SPLIT-SAIQPSO','MILP-SOLVER',},'NumColumns',2,'location','southoutside','FontName','times','FontSize',10.5);legend('boxoff');
grid on;%box off;
set(gca,'gridlinestyle',':','FontName', 'times');
ax=gca;
ax.GridAlpha=1;
set(gcf, 'color', 'w');