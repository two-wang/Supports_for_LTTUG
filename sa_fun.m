function [x,Fmin,fun,generation] = sa_fun(node_Arr,P_ABC_0,G,accuracy)
    % 设定初始参数
    NP_num = 100;
    T = 100;              % 初始温度
    delta = 0.98;       % 温度下降率
    T_min = T*(delta^G);  % 终止温度

    
    % 初始NP_num个随机点
    generation = 1;
    SP = ceil(rand(NP_num,size(node_Arr,1)).*3);
    
    while    generation<=G % Fmin(generation)>=accuracy    % 将温度判据转为了代数判据
        % 对每一个点进行操作
        for i = 1:NP_num
            [fun(i,1),~,~] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
        end
        [Fmin(generation),idx_SP]  = min(fun(:,1));
        jingying = SP(idx_SP,:);
        for i = 1:NP_num
            % 邻域搜索
            new_x = SP(i,:);
            idx = randi(size(node_Arr,1));
            t = randi(3);
            while t == SP(i,idx)
                t = randi(3);
            end
            new_x(1,idx) = t;
            % 判断是否替换
            new_fun = fit_fun(new_x,node_Arr,P_ABC_0);
            if (new_fun - fun(i,1) < 0)
               SP(i,:) =  new_x; % 直接替换
            else
               p = exp(-1*(new_fun-fun(i,1))/T);
               if rand()<p
                   SP(i,:) =  new_x; % 按概率替换
               end
            end
        end
        SP(NP_num,:) = jingying;
        % 温度降低
        T = T * delta;
        generation = generation+1;
    end
    % 输出
    for i = 1:NP_num
        [fun(i,1)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
    end
    [~,idx_t] = min(fun);
    x = SP(idx_t,:);
end

