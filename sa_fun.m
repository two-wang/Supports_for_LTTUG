function [x,Fmin,fun,generation] = sa_fun(node_Arr,P_ABC_0,G,accuracy)
    % �趨��ʼ����
    NP_num = 100;
    T = 100;              % ��ʼ�¶�
    delta = 0.98;       % �¶��½���
    T_min = T*(delta^G);  % ��ֹ�¶�

    
    % ��ʼNP_num�������
    generation = 1;
    SP = ceil(rand(NP_num,size(node_Arr,1)).*3);
    
    while    generation<=G % Fmin(generation)>=accuracy    % ���¶��о�תΪ�˴����о�
        % ��ÿһ������в���
        for i = 1:NP_num
            [fun(i,1),~,~] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
        end
        [Fmin(generation),idx_SP]  = min(fun(:,1));
        jingying = SP(idx_SP,:);
        for i = 1:NP_num
            % ��������
            new_x = SP(i,:);
            idx = randi(size(node_Arr,1));
            t = randi(3);
            while t == SP(i,idx)
                t = randi(3);
            end
            new_x(1,idx) = t;
            % �ж��Ƿ��滻
            new_fun = fit_fun(new_x,node_Arr,P_ABC_0);
            if (new_fun - fun(i,1) < 0)
               SP(i,:) =  new_x; % ֱ���滻
            else
               p = exp(-1*(new_fun-fun(i,1))/T);
               if rand()<p
                   SP(i,:) =  new_x; % �������滻
               end
            end
        end
        SP(NP_num,:) = jingying;
        % �¶Ƚ���
        T = T * delta;
        generation = generation+1;
    end
    % ���
    for i = 1:NP_num
        [fun(i,1)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
    end
    [~,idx_t] = min(fun);
    x = SP(idx_t,:);
end

