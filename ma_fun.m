function [x,Fmin,fun,generation] = ma_fun(node_Arr,P_ABC_0,G,accuracy)
    % 初试代数记忆器及初始种群
    SP_num=100;
    generation = 1;
    SP = ceil(rand(100,size(node_Arr,1)).*3);   

    
    while generation<=G % Fmin(generation)>=accuracy  
        % 计算适应度
        for i = 1:SP_num
            [fun(i,1),fun(i,2),fun(i,3)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
        end
        
        % 采用精英保留策略
        m = 5;
        [T ,idx] = sort(fun(:,1));
        Fmin(generation) = T(1);
        SP_baoliu(1:m,:) =  SP(idx(1:m),:);
        clear idx T
         
        % 对适应值进行正向归一化
        fun(:,1) = 1-( fun(:,1)-min(fun(:,1)) )./( max(fun(:,1))-min(fun(:,1)) );
       
        
        % 进行选择操作(基于轮盘赌法)
        funT = cumsum(fun(:,1)./sum(fun(:,1)));
        for i = 1:SP_num
            idxT = find( (funT-rand(1))>=0 );
            if size(idxT,1)>0
                idx(i) = idxT(1,1);
            else
                idx(i) = SP_num;
            end
        end
        SP_p = SP(idx,:);
        fun_p = fun(idx,:);
        clear funT idx idxT
        
        % 交叉操作
        P_overlapping = 0.8;
        idx = (rand(1,SP_num)<=P_overlapping);
        while mod(sum(idx),2) == 1
            idx = (rand(1,SP_num)<=0.8);
        end
        a = find(idx);
        for i = 1:sum(idx)/2
           b = randi([1,size(node_Arr,1)-1]);
           t = SP_p(a(i),b:size(node_Arr,1));
           SP_p(a(i),b:size(node_Arr,1)) = SP_p(a(sum(idx)-i+1),b:size(node_Arr,1));
           SP_p(a(sum(idx)-i+1),b:size(node_Arr,1)) = t;
        end
        clear a b t idx
        
        
        % 变异操作
        P_variation = 0.08;
        idx = (rand(1,SP_num)<=P_variation);
        for i = 1:sum(idx)
            a = find(idx);
            b = randi([1,size(node_Arr,1)-1]);
            SP_p(a(i),b:b+1) = ceil(rand(1,2).*3);
        end
        clear a b idx
  
       % 局部搜索
       for i = 1:SP_num
           a = fun_p(i,2:3);
           b = find(SP_p(i,:)==a(1));
           b = b(randi([1,size(b,2)]));
           SP_p( i , b) = a(2);
       end
       clear a b
       
       % 轮盘赌从父代和子代中同时选择
       SP_T = [SP;SP_p];
       for i = 1:size(SP_T,1)
           [fun_t(i,1),~,~] = fit_fun(SP_T(i,:),node_Arr,P_ABC_0);
       end
       fun_t(:,1) = 1-( fun_t(:,1)-min(fun_t(:,1)) )./( max(fun_t(:,1))-min(fun_t(:,1)) );
       funT = cumsum(fun_t(:,1)./sum(fun_t(:,1)));
       for i = 1:SP_num-m
            idxT = find( (funT-rand(1))>=0 );
            if size(idxT,1)>0
                idx(i) = idxT(1,1);
            else
                idx(i) = size(SP_T,1);
            end
        end
        SP = SP_T(idx,:);
        SP(SP_num-m+1:SP_num,:) = SP_baoliu;
        clear funT idx idxT SP_T fun_t

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

