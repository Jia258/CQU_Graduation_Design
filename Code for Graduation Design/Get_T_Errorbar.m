N_ini = 10; %初始UE数量
N_step = 10; %UE步长
N_fin = 100; %终止UE数量
errorbar_data = zeros(6, 10);
while N_ini <= N_fin
    N = N_ini;
    T_tmp=zeros(1,10);
    for v=1:10
        Main
        T_tmp(v)=T;
    end
    errorbar_data(1,N/10)=max(T_tmp);
    errorbar_data(2,N/10)=min(T_tmp);
    errorbar_data(3,N/10)=max(T_tmp)-min(T_tmp);
    N_ini = N_ini + N_step;
end
