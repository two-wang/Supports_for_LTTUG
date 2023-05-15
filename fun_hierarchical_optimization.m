function [X,Fmin] = fun_hierarchical_optimization(electric_database_original,G)
    accuracy = 0.000001;
    % 对节点11进行优化操作
    node_Arr = electric_database_original(electric_database_original(:,28)==11,:);
    P_ABC_0 = zeros(3,24);
    [x,Fmin(11,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点10进行优化操作(前面有节点11)
    node_Arr = electric_database_original(electric_database_original(:,28)==10,:);
    for i = 1:3
        users_T = electric_database_original(electric_database_original(:,28)==11,:);
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(10,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点9进行优化操作(前面有节点11、10)
    node_Arr = electric_database_original(electric_database_original(:,28)==9,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(9,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点8进行优化操作(前面有节点9、10、11)
    node_Arr = electric_database_original(electric_database_original(:,28)==8,:);
    for i = 1:3
        users_T = [electric_database_original(electric_database_original(:,28)==9,:);
                   electric_database_original(electric_database_original(:,28)==10,:);
                   electric_database_original(electric_database_original(:,28)==11,:)];
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(8,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点6进行优化操作
    node_Arr = electric_database_original(electric_database_original(:,28)==6,:);
    P_ABC_0 = zeros(3,24);
    [x,Fmin(6,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点5进行优化操作(前面有节点6)
    node_Arr = electric_database_original(electric_database_original(:,28)==5,:);
    for i = 1:3
        users_T = electric_database_original(electric_database_original(:,28)==6,:);
        P_ABC_0(i,:)=sum( users_T(users_T(:,29)==i,2:25) );
    end
    [x,Fmin(5,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点4进行优化操作（前面有节点5、6、8、9、10、11）
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

    % 对节点3进行优化操作（前面有节点4、5、6、8、9、10、11）
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

    % 对节点7进行优化操作
    node_Arr = electric_database_original(electric_database_original(:,28)==7,:);
    P_ABC_0 = zeros(3,24);
    [x,Fmin(7,:)] = ma_fun(node_Arr,P_ABC_0,G,accuracy);
    electric_database_original(node_Arr(:,1),29) = x';

    % 对节点2进行优化操作（前面有节点3、4、5、6、7、8、9、10、11）
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

    % 对节点1进行优化（前面有节点2、3、4、5、6、7、8、9、10、11）
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
    % 输出相别
    X = electric_database_original(:,29)';
end


















