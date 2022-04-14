figure(2)
format long
load('iter_CD_T_new.mat')
x = linspace(5, 35, 7);
xlabel('P (Numbers of population''s particles)','FontName','times','FontSize',12.5);
colororder({'k','k'})
yyaxis left
plot(x,iter_CD_T(1,:),'-.s','LineWidth', 2, 'Color', '#0000ff','MarkerSize',8,'MarkerFaceColor','#0000ff');hold on;
ylabel('C','FontName','times','FontSize',12.5);
axis([5 35 0.947 0.9472]);
%set(gca,'YTick',[0.947 1.002 1.057 1.112 1.167]);
yyaxis right
y=iter_CD_T(2,:)*1000;
plot(x,y,'-s','LineWidth', 2, 'Color', '#408000','MarkerSize',8,'MarkerFaceColor','#408000');hold on;
ylabel('T [ms]','FontName','times','FontSize',12.5);
axis([5 35 10 80]);
%set(gca,'YTick',[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08]);
%cla
legend({'C','T'},'NumColumns',2,'location','southoutside','FontName','times','FontSize',10.5);legend('boxoff');
grid on;%box off;
set(gca,'gridlinestyle',':','FontName', 'times');
ax=gca;
ax.GridAlpha=1;
set(gcf, 'color', 'w');