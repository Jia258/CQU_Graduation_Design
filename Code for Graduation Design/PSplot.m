function PSplot(x, y)
figure(2)
h = bar(x, y, 'stacked');
h(1, 1).FaceColor = '#071D70';
h(1, 2).FaceColor = '#034569';
h(1, 3).FaceColor = '#1435AD';
h(1, 4).FaceColor = '#4867D6';
h(1, 5).FaceColor = '#6E84D6';
h(1, 6).FaceColor = '#086CA2';
h(1, 7).FaceColor = '#3C9DD0';
h(1, 8).FaceColor = '#64AAD0';
h(1, 9).FaceColor = '#37B6CE';
xlabel('N (Numbers of users)','FontName','times','FontSize',12.5);
ylabel('P [%]','FontName','times','FontSize',12.5);
legend({'Split 0','Split 1','Split 2','Split 3','Split 4','Split 5','Split 6','Split 7','Split 8'},...
    'NumColumns',3,'location','southoutside','FontName','times','FontSize',10.5);legend('boxoff');
set(gca,'YLim',[0 1.1],'Yticklabel',{[0:20:100]});
grid on;%box off;
set(gca,'gridlinestyle',':','FontName', 'Times');
ax=gca;
ax.GridAlpha=1;
ax.LineWidth=0.5;
set(gcf, 'color', 'w');
end
