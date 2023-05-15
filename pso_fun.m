function [x,Fmin,fun,generation] = pso_fun(node_Arr,P_ABC_0,G,accuracy)
    % 初始参数
    NP_num = 100;
    wini = 0.9;
    wend = 0.4;
    c1 = 2;
    c2 = 2;
    
    % 初始粒子群
    generation = 1;
    SP = rand(NP_num,size(node_Arr,1)).*3;
    v = zeros(NP_num,size(node_Arr,1));
    
    while generation<=G
        % 计算每个粒子的适应度值
        for i = 1:NP_num
            [fun(i,1)] = fit_fun(ceil(SP(i,:)),node_Arr,P_ABC_0);
        end
        
        % 更新个体最优解和种群最优解
        if generation == 1
            p = SP;
            p_fun = fun;
            
            [g_fun,idx_g] = min(fun);
            g = SP(idx_g,:);
        else
           idx_p = find(fun < p_fun);
           p(idx_p,:) = SP(idx_p,:);
           p_fun(idx_p,:) = fun(idx_p,:);
           
           if min(fun)< g_fun
               [g_fun,idx_g] = min(fun);
               g = SP(idx_g,:);
           end
        end
        
        % 更新每个粒子的速度
        w = (wini - wend)*(G-generation)/G+wend;
        v = w.*v + c1.*rand().*(p-SP)+c2.*rand().*(repmat(g,NP_num,1)-SP);
        % 限制速度
        Vmax = 0.8;
        [a,b] = find(v>=Vmax);
        v(a,b) =Vmax ;
        [a,b] = find(v<=-Vmax);
        v(a,b) = -Vmax;
        % 更新每个粒子的位置
        SP = SP + v;
        
        % 限幅粒子群的取值范围
        [a,b] = find(SP>=3);
        SP(a,b) = 2.9999999999;
        [a,b] = find(SP<=0);
        SP(a,b) = 0.0000000001;
        
        Fmin(generation) = g_fun;
        
        % 代数增加
        generation = generation + 1;
        
    end
    % 输出
    for i = 1:NP_num
        [fun(i,1)] = fit_fun(ceil(SP(i,:)),node_Arr,P_ABC_0);
    end
    [~,idx_t] = min(fun);
    x = SP(idx_t,:);
end

