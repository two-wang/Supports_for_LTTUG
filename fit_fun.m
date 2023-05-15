function [f,maxT,minT] =fit_fun(x,node_Arr,P_ABC_0)
    % ����˵��
    %node_Arr,ֻ��Ҫ2-25�е�����
    %����1-���û���ţ�2��25-��24Сʱ�ĸ������ߣ�26-�����������
    %27-���Ż�ǰ���������;28-�������ڵ㣻29-���Ż�����������
    
    %P_ABC_0
    %����3*24��ÿһ�н�Ϊ��ȷ����A��B��C�ࣩ���й�����
    
    P_mean = ( sum(node_Arr(:,2:25))+sum(P_ABC_0) )./3;
    P_ABC = zeros(3,24);
    g_ABC = zeros(3,24);
    for i = 1:3
        P_ABC(i,:) = sum(node_Arr(x== i,2:25),1)+P_ABC_0(i,:);
        g_ABC(i,:) = abs( (P_ABC(i,:)-P_mean)./P_mean );
    end
    % ����˲ʱ��ƽ���
    g = max(g_ABC);
    % ƽ�����ʽϴ����
    [~,maxT] = max(sum(P_ABC,2));
    % ƽ�����ʽ�С����
    [~,minT] = min(sum(P_ABC,2));
    % ƽ�����಻ƽ���
    f = sum(g)/24;
end