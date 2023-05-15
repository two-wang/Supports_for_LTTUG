function [X,Fmin] = fun_hierarchical_optimization(electric_database_original,G)
    accuracy = 0.000001;
    % �Խڵ�11�����Ż�����
    node_Arr = electric_database_original(electric_database_original(:,28)==11,:);
    P_ABC_0 = zeros(3,24);
    [x,Fmin(11,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�10�����Ż�����(ǰ���нڵ�11)
    node_Arr = electric_database_original(electric_database_original(:,28)==10,:);
    for i = 1:3
        users_T = electric_database_original(electric_database_original(:,28)==11,:);
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(10,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�9�����Ż�����(ǰ���нڵ�11��10)
    node_Arr = electric_database_original(electric_database_original(:,28)==9,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(9,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�8�����Ż�����(ǰ���нڵ�9��10��11)
    node_Arr = electric_database_original(electric_database_original(:,28)==8,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==9,:);
                   electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(8,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�6�����Ż�����
    node_Arr = electric_database_original(electric_database_original(:,28)==6,:);
    P_ABC_0 = zeros(3,24);
    [x,Fmin(6,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�5�����Ż�����(ǰ���нڵ�6)
    node_Arr = electric_database_original(electric_database_original(:,28)==5,:);
    for i = 1:3
        users_T = electric_database_original(electric_database_original(:,28)==6,:);
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(5,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�4�����Ż�������ǰ���нڵ�5��6��8��9��10��11��
    node_Arr = electric_database_original(electric_database_original(:,28)==4,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==5,:);
                   electric_database_original(electric_database_original(:,28)==6,:);
                   electric_database_original(electric_database_original(:,28)==8,:);
                   electric_database_original(electric_database_original(:,28)==9,:);
                   electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(4,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�3�����Ż�������ǰ���нڵ�4��5��6��8��9��10��11��
    node_Arr = electric_database_original(electric_database_original(:,28)==3,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==4,:);
                   electric_database_original(electric_database_original(:,28)==5,:);
                   electric_database_original(electric_database_original(:,28)==6,:);
                   electric_database_original(electric_database_original(:,28)==8,:);
                   electric_database_original(electric_database_original(:,28)==9,:);
                   electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(3,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�7�����Ż�����
    node_Arr = electric_database_original(electric_database_original(:,28)==7,:);
    P_ABC_0 = zeros(3,24);
    [x,Fmin(7,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�2�����Ż�������ǰ���нڵ�3��4��5��6��7��8��9��10��11��
    node_Arr = electric_database_original(electric_database_original(:,28)==2,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==3,:);
                   electric_database_original(electric_database_original(:,28)==4,:);
                   electric_database_original(electric_database_original(:,28)==5,:);
                   electric_database_original(electric_database_original(:,28)==6,:);
                   electric_database_original(electric_database_original(:,28)==7,:);
                   electric_database_original(electric_database_original(:,28)==8,:);
                   electric_database_original(electric_database_original(:,28)==9,:);
                   electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(2,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % �Խڵ�1�����Ż���ǰ���нڵ�2��3��4��5��6��7��8��9��10��11��
    node_Arr = electric_database_original(electric_database_original(:,28)==1,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==2,:);
                   electric_database_original(electric_database_original(:,28)==3,:);
                   electric_database_original(electric_database_original(:,28)==4,:);
                   electric_database_original(electric_database_original(:,28)==5,:);
                   electric_database_original(electric_database_original(:,28)==6,:);
                   electric_database_original(electric_database_original(:,28)==7,:);
                   electric_database_original(electric_database_original(:,28)==8,:);
                   electric_database_original(electric_database_original(:,28)==9,:);
                   electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(1,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';
    % ������
    X = electric_database_original(:,29)';
end


















