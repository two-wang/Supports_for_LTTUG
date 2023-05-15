function [node_usersT,best_num] = cluster_analysis(node_users,id)
    data_standard = node_users(:,2:25);
    number_c = 12;
    n = size(node_users,1);

    for k = 2:number_c
        [centers,U,~] = fuzzyfcm(data_standard, k, 2, 0);
        % 计算第一种聚类有效性函数
        F = (sum(sum(U.^2)))/n;             
        P = sum(sum(U.^2,2)./sum(U,2))/k;    
        FP(1,k-1) = F-P;
        % 计算第二种聚类有效性函数
        V0 = (sum(data_standard)./n);
        J0 = sum(sum((data_standard-repmat(V0,n,1)).^2,2));
        ST1 = 0;
        for i=1:k
            S = sum( (U(i,:).^2).*sum(( data_standard'-repmat(centers(i,:)',1,n) ).^2) );
            ST1 = ST1 + S;
        end
        P_p(1,k-1) = ( min(sum(U,2))/max(sum(U,2)) ) * (P + 1 - ST1/J0);

        % 计算第三种聚类有效性函数
        ST3 = 0;
        for i = 1:k
           for j = 1:n
               ST3 = ST3 + U(i,j)^2* sum( (data_standard(j,:)-centers(i,:)).^2 ) ;
           end
        end
        ST3 = ST3/(n-k);
        ST3Z = sum(sum(U.^2,2).* sum( (centers-repmat(V0,k,1)).^2,2 ))/(k-1) ;
        L(1,k-1) = ST3Z/ST3;
    end
    clear centers F i j J0 k P S ST1 ST3 ST3Z U V0 
    % 综合判据
    FP = FP ./repmat(max(FP),size(FP,1),1); 
    P_p = P_p ./repmat(max(P_p),size(P_p,1),1); 
    L = L ./repmat(max(L),size(L,1),1); 
    comprehensive = (P_p+L)-FP;
    k_x = 2:number_c;
    figure(100+id)
    plot(k_x,comprehensive)
    [~,best_num] = max(comprehensive);
    best_num = best_num + 1;
    % 用最佳聚类数进行聚类
    [centers,U,~] = fuzzyfcm(data_standard , best_num, 2 ,0);
    U_max = max(U);
    [U_m,~] = find(repmat(U_max,best_num,1)==U);
    clear U_max
    % 构造输出矩阵
    node_usersT = zeros(n,28);
    node_usersT(:,1) = node_users(:,1);
    % 作出每一类的图
    t = 1:24;
    for i = 1:best_num
       [U_j,~] = find(U_m == repmat(i,n,1));
       node_usersT(U_j,2:25) = repmat(centers(i,:),size(U_j,1),1);
       node_usersT(U_j,26) = i;
       data_j = data_standard(U_j,:);
       figure(id)
       subplot(ceil(sqrt(best_num)),ceil(sqrt(best_num)),i)
       for j = 1:size(data_j,1)
           plot(t,data_j(j,:))
           hold on
       end
       axis([0,25,0,1])
       xlabel(['第',num2str(i),'类'])
       hold off
    end
    node_usersT(:,27:28) = node_users(:,27:28);

    %% 整体画典型负荷曲线图
    figure(99)
    subplot(4,3,id)
    plot(centers')
end













