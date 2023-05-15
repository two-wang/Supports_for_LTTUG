%% 鲁棒性检验

% 初始化
clc;clear
load('data_base.mat')                     % 原始数据
load('verify_electric_database_M2.mat')   % 第29列存放着本文所提方案得到的调相结果
miu = 0;
number = 1;
num=1;
x = 0:0.02:4.5;
step = 20;
for i = [0.05 0.1 0.2 0.3]
    % 初始正态分布参数
    rou = i;
    phase = electric_database_M2(:,29);
    
    % 随机10000次查看结果分布
    for j = 1:10000
        epu = normrnd(miu,rou,[543,24]);   
        electric_database_new = electric_database_original(:,2:25) + epu;
        electric_database_new(electric_database_new < 0) = 0;  % 是否存在负的负荷
        g_res(num,j) = three_phase_unbalance_plot(electric_database_new,phase,0);
    end
    y(:,number) = distribution_map_x(g_res(num,:),x,0);
    number = number+step;
    num = num+1;
    clear res
end


% 三维直方图及其拟合曲线绘图
figure
b=bar3(x(1:end-1),y);
for i =1:61
    b(i).FaceAlpha=0.9;
end

hold on
for i =1:4
    ttttt = g_res(i,:);
    pd = fitdist(ttttt(:),'Normal');
    pd.mu
    pd.sigma
    normal_y = normpdf(x,pd.mu,pd.sigma); 
    normal_y = normal_y .*(     1.01*max(y(:,1+i*step-step))/max(normal_y)    );
    p = plot3(ones(1,size(x,2))*(1+i*step-step-0.5),x,normal_y+0.01,'-');
    p.LineWidth=3.5;
    if i == 1
        p.Color = "#D95319";
    elseif i == 2
        p.Color = "#77AC30";
    end
end
grid off
xlabel = '标准差';
ylabel = '三相不平衡度';
zlabel = '概率';

set(gca,'xlim',[-1,62])
set(gca,'ylim',[0,4.5])









