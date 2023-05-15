function [g_Arr] = plot_network_g(electric_database_originalT,plot_idx,color)
    % electric_database_originalT电力用户矩阵；plot_idx（num）画图序号（同一个图写同一个数字就行）；color（str）颜色，用以区分不同的用户矩阵
    g_Arr = zeros(12,25);
    t=1:24;
    % 绘制根节点的三相不平衡
    P_A = sum(electric_database_originalT(electric_database_originalT(:,29)==1,2:25),1);
    P_B = sum(electric_database_originalT(electric_database_originalT(:,29)==2,2:25),1);
    P_C = sum(electric_database_originalT(electric_database_originalT(:,29)==3,2:25),1);
    P_mean = (P_A+P_B+P_C)./3;
    g = max([abs((P_A-P_mean)./P_mean);abs((P_B-P_mean)./P_mean);abs((P_C-P_mean)./P_mean)]).*100;
    g_Arr(1,1:24) = g;
    g_Arr(1,25) = mean(g);
    figure(plot_idx)
    subplot(4,3,1)
    plot(t,g,[color,'-'],'LineWidth',1.3);
    hold on
    line([1 24],[mean(g) mean(g)],'LineStyle','--','Color',color,'LineWidth',1.5)
    text(11,mean(g),[num2str(mean(g)),'%'])
    title('根节点的三相不平衡度为')
    xlabel('时间')
    ylabel('三相不平衡度')
    
    node_1 = [1 2 3 4 5 6 7 8 9 10 11];
    node_2 = [2 3 4 5 6 7 8 9 10 11];
    node_3 = [3 4 5 6 8 9 10 11];
    node_4 = [4 5 6 8 9 10 11];
    node_5 = [5 6];
    node_6 = [6];
    node_7 = [7];
    node_8 = [8 9 10 11];
    node_9 = [9 10 11];
    node_10 = [10 11];
    node_11 = [11];
    
    % 绘制各个节点的三相不平衡度
    for i=1:11
        eval(['node_T = node_',num2str(i),';'])
        node_Arr = [];
        for j = 1:size(node_T,2)
            node_Add = electric_database_originalT(electric_database_originalT(:,28)==node_T(1,j),:);
            node_Arr = [node_Arr ; node_Add];
        end
        
        P_A = sum(node_Arr(node_Arr(:,29)==1,2:25),1);
        P_B = sum(node_Arr(node_Arr(:,29)==2,2:25),1);
        P_C = sum(node_Arr(node_Arr(:,29)==3,2:25),1);
        P_mean = (P_A+P_B+P_C)./3;
        g = max([abs((P_A-P_mean)./P_mean);abs((P_B-P_mean)./P_mean);abs((P_C-P_mean)./P_mean)]).*100;
        g_Arr(i+1,1:24) = g;
        g_Arr(i+1,25) = mean(g);
        figure(plot_idx)
        subplot(4,3,i+1)
        plot(t,g,[color,'-'],'LineWidth',1.3)
        hold on
        line([1 24],[mean(g) mean(g)],'LineStyle','--','Color',color,'LineWidth',1.5)
        text(11,mean(g),[num2str(mean(g)),'%'])
        title(['第',num2str(i),'个节点的三相不平衡度为'])
        xlabel('时间')
        ylabel('三相不平衡度')
    end
end











