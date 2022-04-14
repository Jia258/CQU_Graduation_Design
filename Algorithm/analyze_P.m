figure(1)
format long
load('P_CD_T_new.mat')
x = linspace(5, 25, 5);
xlabel('IterMax (Maximum number of iterations)','FontName','times','FontSize',12.5);
colororder({'k','k'})
yyaxis left
plot(x,P_CD_T(1,:),'-.s','LineWidth', 2, 'Color', '#0000ff','MarkerSize',8,'MarkerFaceColor','#0000ff');hold on;
ylabel('C','FontName','times','FontSize',12.5);
axis([5 25 0.947 0.9485]);
%set(gca,'YTick',[0.947 0.9475 0.948 0.9485]);
yyaxis right
y=P_CD_T(2,:)*1000;
plot(x,y,'-s','LineWidth', 2, 'Color', '#408000','MarkerSize',8,'MarkerFaceColor','#408000');hold on;
ylabel('T [ms]','FontName','times','FontSize',12.5);
axis([5 25 10 50]);
%set(gca,'YTick',[0.01 0.02 0.03 0.04 0.05]);
%cla
legend({'C','T'},'NumColumns',2,'location','southoutside','FontName','times','FontSize',10.5);legend('boxoff');
grid on;%box off;
set(gca,'gridlinestyle',':','FontName', 'times');
ax=gca;
ax.GridAlpha=1;
set(gcf, 'color', 'w');