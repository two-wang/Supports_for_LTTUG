%% 分别对每个节点单独进行聚类
clc;clear
load('data_base.mat')                    % 原始数据

for i = 1:11
   node_users =  electric_database_original(electric_database_original(:,28)==i,:);
   electric_database_M2(node_users(:,1),1:28) = cluster_analysis(node_users, i);
end

%% 保存
save('verify_electric_database_M2','electric_database_M2')