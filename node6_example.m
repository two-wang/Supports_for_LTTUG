%% 节点6的优化示例
clc;clear
load('data_base.mat')                    % 原始数据

G=800;
P_ABC_0 = zeros(3,24);
electric_database_original_node6 = electric_database_original(electric_database_original(:,28)==6,:);
H=fit_fun(electric_database_original_node6(:,27),electric_database_original_node6,P_ABC_0);
figure
% 文化基因算法
[~,Fmin_ma] = ma_fun(electric_database_original_node6,P_ABC_0,G,0.000001);
p=plot(Fmin_ma.*100);
p.LineWidth = 2;
xlabel('迭代次数')
ylabel('平均三相不平衡度（%）')
hold on

% 传统的遗传算法
[~,Fmin_ga] = ga_fun_Creat_original(electric_database_original_node6,P_ABC_0,G,0.000001);
p=plot(Fmin_ga.*100);
p.LineWidth = 2;

% 粒子群算法
[~,Fmin_pso] = pso_fun(electric_database_original_node6,P_ABC_0,G,0.000001);
p=plot(Fmin_pso.*100);
p.LineWidth = 2;

% 模拟退火算法
[~,Fmin_sa] = sa_fun(electric_database_original_node6,P_ABC_0,G,0.000001);
p=plot(Fmin_sa.*100);
p.LineWidth = 2;

% 贪心换相搜索算法
[~,Fmin_tanxin] = tanxin_fun(electric_database_original_node6,P_ABC_0,G,0.000001);
p=plot(Fmin_tanxin.*100);
p.LineWidth = 2;

legend('文化基因算法','遗传算法','粒子群算法','模拟退火算法','贪心换相搜索')

