figure(1)
format long
load('Convergence.mat')
x = 6:20;
%plot(x,Convergence(3,x),'-.s','LineWidth', 2, 'Color', '#4c4c4c','MarkerSize',8,'MarkerFaceColor','#4c4c4c');hold on;
plot(x,Convergence(2,x),'-.s','LineWidth', 2, 'Color', '#306180','MarkerSize',8,'MarkerFaceColor','#306180');hold on;
plot(x,Convergence(1,x),'-s','LineWidth', 2, 'Color', '#a18021','MarkerSize',8,'MarkerFaceColor','#a18021');hold on;
xlabel('Iter','FontSize',12.5,'FontName','times');
ylabel('Fitness','FontSize',12.5,'FontName','times');
legend({'SPLIT-SAIPSO','SPLIT-SAIQPSO'},'NumColumns',1,'location','northeast','FontName','times','FontSize',10.5);%legend('boxoff');
grid on;%box off;
set(gca,'gridlinestyle',':','FontName', 'Times');
ax=gca;
ax.GridAlpha=1;
set(gcf, 'color', 'w');
