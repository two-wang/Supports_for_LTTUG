%% 对比遗传算法和文化基因算法在收敛精度上的对比
clc;clear
load('data_base.mat')                    % 原始数据
% 使用文化基因算法
G = 500;
[x,Fmin1] = fun_hierarchical_optimization(electric_database_original,G);
electric_database_M2(:,29) = x';

% 使用传统遗传算法
[~,Fmin2] = fun_hierarchical_optimization_traditional(electric_database_original,G);
% 画图做对比
figure
for i= 2:12
    subplot(3,4,i-1)
    plot(Fmin1(i-1,:).*100)
    xlabel('迭代次数')
    ylabel('目标函数值（%）')
    hold on
    plot(Fmin2(i-1,:).*100)
    legend('文化基因算法','传统遗传算法')
    title(['节点',num2str(i)])
end
% 画出各节点收敛结果对比
Temp_arr(1,:)=Fmin1(:,G)'.*100; 
Temp_arr(2,:)=Fmin2(:,G)'.*100; 
figure
plot(Temp_arr(1,:),'r*-')
hold on
plot(Temp_arr(2,:),'bo-')
xlabel('节点序号')
ylabel('三相不平衡度（%）')
legend('遗传算法','改进文化基因算法')
Temp_ans = sum(abs(Temp_arr(2,:)-Temp_arr(1,:))./Temp_arr(2,:))/11*100;
disp(['收敛精度提高了',num2str(Temp_ans),'%'])