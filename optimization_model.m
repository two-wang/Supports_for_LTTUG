%% 初始化
clc;clear
load('data_base.mat')                    % 原始数据
load('verify_electric_database_M1.mat')  % M1为全体聚类后的典型负荷数据库为基础单层优化后的结果
load('verify_electric_database_M2.mat')  % M2为分节点聚类后的典型数据库为基础多层优化后的结果


%% 治理前瞬时三相不平衡度
electric_database_original(:,29) = electric_database_original(:,27);
plot_network_g(electric_database_original,1,'k');


%% 进行单层优化
G = 500;
accuracy = 0.00001;
P_ABC_0 = zeros(3,24);
[x,~,~,~] = ma_fun(electric_database_M1,P_ABC_0,G,accuracy);
electric_database_M1(:,29) = x';
% 保存调相结果
save('verify_electric_database_M1','electric_database_M1')


%% 画出单层优化的各节点三相不平衡度
electric_database_M1(:,2:25) = electric_database_original(:,2:25);
plot_network_g(electric_database_M1,2,'b');


%% 进行多层优化
G = 500;
[x,Fmin1] = fun_hierarchical_optimization(electric_database_M2,G);
electric_database_M2(:,29) = x';
% 保存调相结果
save('verify_electric_database_M2','electric_database_M2')


%% 画出多层优化的各节点三相不平衡度
electric_database_M2(:,2:25) = electric_database_original(:,2:25);
plot_network_g(electric_database_M2,2,'r');














