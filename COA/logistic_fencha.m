clc;clear all;close all
axis([0,4,0,1]);
x0=0.1;%迭代初始值
M=1000;%迭代次数
mu=0:0.01:4;%参数
[m,n]=size(mu);
x=zeros(1,1000);
xn=zeros(1,200);
hold on
for i=1:n
    x(1)=mu(i)*x0*(1-x0);
    for j =2:M
        x(j)=mu(i)*x(j-1)*(1-x(j-1));
    end
    xn=x(M-199:M);%将末尾的200个样点画出来
    pause(0.1);
    plot(mu(i),xn,'b.','Markersize',2);%绘制分叉图
    xlabel('\it \mu','FontName','times','FontSize',12.5);
    ylabel('\it z','FontName','times','FontSize',12.5);
    set(gcf, 'color', 'w');grid on;box on;
    set(gca,'gridlinestyle',':','FontName', 'Times');
    ax=gca;
    ax.GridAlpha=1;
end