function [x,Fmin,fun,generation] = tanxin_fun(node_Arr,P_ABC_0,G,accuracy)
    % 初试代数记忆器及初始种群
    SP_num=100;
    generation = 1;
    SP = ceil(rand(100,size(node_Arr,1)).*3);   
    Fmin = [1];
    
    while generation<=G % Fmin(generation)>=accuracy  
        % 计算适应度
        for i = 1:SP_num
            [fun(i,1),fun(i,2),fun(i,3)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
        end
        % 更新目标函数值
        [T ,~] = sort(fun(:,1));
        if generation == 1   
            Fmin(generation) = T(1);
        elseif T(1) < Fmin(generation-1)
            Fmin(generation) = T(1);
        else
            Fmin(generation) = Fmin(generation-1); 
        end
        % 对适应值进行正向归一化
        fun(:,1) = 1-( fun(:,1)-min(fun(:,1)) )./( max(fun(:,1))-min(fun(:,1)) );
        % 局部搜索
        for i = 1:SP_num
            a = fun(i,2:3);
            b = find(SP(i,:)==a(1));
            b = b(randi([1,size(b,2)]));
            SP( i , b) = a(2);
        end
        clear a b
        % 代数+1
        generation = generation+1;

    end
    % 计算适应度
    for i = 1:SP_num
        [fun(i,1),fun(i,2),fun(i,3)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
    end
    [~,idx]=min(fun(:,1));
    x = SP(idx,:);

end