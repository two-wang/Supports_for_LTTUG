function [x,Fmin,fun,generation] = ga_fun_Creat_original(node_Arr,P_ABC_0, G , accuracy)

    % ���Դ�������������ʼ��Ⱥ
    NP_num = 100;
    generation = 1;
    SP = ceil(rand(NP_num,size(node_Arr,1)).*3);

    
    while  generation<=G  % Fmin(generation)>=accuracy 
        % ������Ӧ��
        for i = 1:NP_num
            [fun(i,1),fun(i,2),fun(i,3)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
        end

        % ѡȡ���ŵ�ǰm����Ⱦɫ�岢����
        m = 2;
        [T ,idx] = sort(fun(:,1));
        Fmin(generation) = T(1);
        SP_p(1:m,:) =  SP(idx(1:m),:);
        SP(idx(1:m),:) = [];
        fun(idx(1:m),:) = [];
        clear idx T
         
        
        % ����Ӧֵ���������һ��
        fun(:,1) = 1-( fun(:,1)-min(fun(:,1)) )./( max(fun(:,1))-min(fun(:,1)) );
%        fun(:,1) = 1-fun(:,1);
        
        % ����ѡ�����(�������̶ķ�)
        funT = cumsum(fun(:,1)./sum(fun(:,1)));
        for i = 1:(NP_num-m)
            idxT = find( (funT-rand(1))>=0 );
            if size(idxT,1)>0
                idx(i) = idxT(1,1);
            else
                idx(i) = NP_num-m;
            end
        end
        SP = SP(idx,:);
        fun = fun(idx,:);
        clear funT idx idxT
        
        % �������
        P_overlapping = 0.8;
        idx = (rand(1,NP_num-m)<=P_overlapping);
        while mod(sum(idx),2) == 1
            idx = (rand(1,NP_num-m)<=0.8);
        end
        a = find(idx);
        for i = 1:sum(idx)/2
           b = randi([1,size(node_Arr,1)-1]);
           t = SP(a(i),b:size(node_Arr,1));
           SP(a(i),b:size(node_Arr,1)) = SP(a(sum(idx)-i+1),b:size(node_Arr,1));
           SP(a(sum(idx)-i+1),b:size(node_Arr,1)) = t;
        end
        clear a b t idx
        
        
        % �������
        P_variation = 0.08;
        idx = (rand(1,NP_num-m)<=P_variation);
        for i = 1:sum(idx)
            a = find(idx);
            b = randi([1,size(node_Arr,1)-1]);
            SP(a(i),b:b+1) = ceil(rand(1,2).*3);
        end
        clear a b idx
  
        % ����+1
        generation = generation+1;
        SP(NP_num-m+1:NP_num,:) = SP_p;
        
    end
    % ������Ӧ��
    for i = 1:NP_num
        [fun(i,1),fun(i,2),fun(i,3)] = fit_fun(SP(i,:),node_Arr,P_ABC_0);
    end
    [~,idx]=min(fun(:,1));
    x = SP(idx,:);
end




