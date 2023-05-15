function [f,maxT,minT] =fit_fun(x,node_Arr,P_ABC_0)
    % 参数说明
    %node_Arr,只需要2-25列的数据
    %矩阵：1-》用户序号；2：25-》24小时的负荷曲线；26-》所属的类别；
    %27-》优化前的所接相别;28-》所属节点；29-》优化后的所接相别
    
    %P_ABC_0
    %矩阵：3*24；每一行皆为已确定的A（B或C相）的有功负荷
    
    P_mean = ( sum(node_Arr(:,2:25))+sum(P_ABC_0) )./3;
    P_ABC = zeros(3,24);
    g_ABC = zeros(3,24);
    for i = 1:3
        P_ABC(i,:) = sum(node_Arr(x== i,2:25),1)+P_ABC_0(i,:);
        g_ABC(i,:) = abs( (P_ABC(i,:)-P_mean)./P_mean );
    end
    % 三相瞬时不平衡度
    g = max(g_ABC);
    % 平均功率较大的相
    [~,maxT] = max(sum(P_ABC,2));
    % 平均功率较小的相
    [~,minT] = min(sum(P_ABC,2));
    % 平均三相不平衡度
    f = sum(g)/24;
end