Le=zeros(401,2);
i=0;
for mu=0:0.001:4
    i=i+1;
    x=0.1;
    y=0;
    for k=1:100000
        x=mu*x*(1-x);  %Logistic映射
        y=y+log(abs(1-2*x));
    end
    Le(i,1)=mu;
    Le(i,2)=log(mu)+y/100000;
end
plot(Le(:,1),Le(:,2),'b','LineWidth',1);
hold on;
n=get(gca,'Xlim');
plot(n,[0,0],'k','LineWidth',0.5);
xlabel('\mu','FontSize',12.5,'FontName','times');
ylabel('Lyapunov exponent curves of the logistic map','FontSize',12.5,'FontName','times');
axis([0 4 -8 1]); 
set(gcf, 'color', 'w');grid on;box on;
set(gca,'gridlinestyle',':','FontName', 'Times');
ax=gca;
ax.GridAlpha=1;