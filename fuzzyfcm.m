function [centers,U,fun] = fuzzyfcm(arr , c , m, random)

    %INPUT:  n*m矩阵，n为样本数、m为单个样本的特征数；c为分类数；m为模糊指数，m>=1.
    %OUTPUT: centers为聚类中心；U为隶属度；fun为目标函数的数值迭代数组。
    fun = zeros(2000,1);
    
    %% 初始化聚类中心及其对应的隶属度矩阵
    [size_x,size_y] = size(arr);
    V = zeros(c,size_y);
    U = zeros(c,size_x);
    if random == 1
        random = randi(floor(size_x/c));
        for i = 1:c
            V(i,:) = arr( round((i-1)*size_x/c)+ random ,:);
        end
    else
        V = centers_based_on_density(arr,c); % 根据密度优化选则聚类初始中心
    end
    

    for i = 1:c
       for j = 1:size_x
          if sqrt( sum((arr(j,:)-V(i,:)).^2) ) == 0
              U(i,j) = 1;
          else
              U(i,j) = 1/( sum( 1./(sqrt( sum( (repmat(arr(j,:),c,1)-V).^2,2) ).^(2/(m-1))) )* (sqrt( sum((arr(j,:)-V(i,:)).^2) ).^(2/(m-1))) );
          end
       end
    end
    %% 计算F
    F = 0;
    for i = 1:c
       for j = 1:size_x
          F = F + U(i,j)^m*sum(( (arr(j,:)-V(i,:)).^2 )); 
       end
    end
    fun(1,1) = F;
    %% 设定收敛精度e，初始迭代次数l,更新聚类中心
    e = 0.00000001;
    l = 0;
    for i = 1:c
       V(i,:) = sum(repmat((U(i,:).^m)',1,size_y).*arr) / sum(U(i,:).^m); 
    end
    
    %% 计算Fp
    Fp = 0;
    for i = 1:c
       for j = 1:size_x
          Fp = Fp + U(i,j)^m*sum(( (arr(j,:)-V(i,:)).^2 )); 
       end
    end
    fun(2,1) = Fp;
    
    %% 循环判断
    while ((F-Fp)>e)
        % 更新隶属度矩阵
        for i = 1:c
           for j = 1:size_x
              if sqrt( sum((arr(j,:)-V(i,:)).^2) ) == 0
                  U(i,j) = 1;
              else
                  U(i,j) = 1/( sum( 1./(sqrt( sum( (repmat(arr(j,:),c,1)-V).^2,2) ).^(2/(m-1))) )* (sqrt( sum((arr(j,:)-V(i,:)).^2) ).^(2/(m-1))) );
              end
           end
        end
        % 更新聚类中心
        for i = 1:c
           V(i,:) = sum(repmat((U(i,:).^m)',1,size_y).*arr) / sum(U(i,:).^m); 
        end
        % 更新F和Fp
        F = Fp;
        Fp = 0;
        for i = 1:c
           for j = 1:size_x
              Fp = Fp + U(i,j)^m*sum(( (arr(j,:)-V(i,:)).^2 )); 
           end
        end
        l = l+1;
        fun(l+2,1) = Fp;
    end
    % 赋值输出
    centers = V;
    T = find(fun == 0 );
    fun(T(1,1):2000,:) = [];
end












