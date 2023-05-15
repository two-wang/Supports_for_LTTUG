%% 分别对每个节点单独进行聚类
clc;clear
load('data_base.mat')                    % 原始数据

% 判断最佳聚类数
for k = 2:20                             
    n = size(electric_database_original(:,2:25),1);
    [centers,U,~] = fuzzyfcm(electric_database_original(:,2:25), k, 2, 0);
    % 计算第一种聚类有效性函数
    F = (sum(sum(U.^2)))/n;             
    P = sum(sum(U.^2,2)./sum(U,2))/k;    
    FP(1,k-1) = F-P;
    % 计算第二种聚类有效性函数
    V0 = (sum(electric_database_original(:,2:25))./n);
    J0 = sum(sum((electric_database_original(:,2:25)-repmat(V0,n,1)).^2,2));
    ST1 = 0;
    for i=1:k
        S = sum( (U(i,:).^2).*sum(( electric_database_original(:,2:25)'-repmat(centers(i,:)',1,n) ).^2) );
        ST1 = ST1 + S;
    end
    P_p(1,k-1) = ( min(sum(U,2))/max(sum(U,2)) ) * (P + 1 - ST1/J0);

    % 计算第三种聚类有效性函数
    ST3 = 0;
    for i = 1:k
       for j = 1:n
           ST3 = ST3 + U(i,j)^2* sum( (electric_database_original(j,2:25)-centers(i,:)).^2 ) ;
       end
    end
    ST3 = ST3/(n-k);
    ST3Z = sum(sum(U.^2,2).* sum( (centers-repmat(V0,k,1)).^2,2 ))/(k-1) ;
    L(1,k-1) = ST3Z/ST3;
end
clear centers F i j J0 k n P S ST1 ST3 ST3Z U V0 
FP = FP ./repmat(max(FP),size(FP,1),1); 
P_p = P_p ./repmat(max(P_p),size(P_p,1),1); 
L = L ./repmat(max(L),size(L,1),1); 
comprehensive = (P_p+L)-FP;                         % 综合判据
figure
k_x = 2:20;
plot(k_x,comprehensive)

% 进行聚类
[~,c] = max(comprehensive);
c = c + 1;


c=5;
[centers,U,fun] = fuzzyfcm(electric_database_original(:,2:25), c, 2, 0);
U_max = max(U);
[U_m,~] = find(repmat(U_max,c,1)==U);
electric_database_M1(:,26) = U_m;
clear U_max


% 画出每类的图
figure
t = 1:24;
for i =1:c
   idx = find(U_m == i);
   disp(size(idx,1))
   subplot(3,2,i)
   for j =1:size(idx,1)
       plot(t,electric_database_original(idx(j),2:25))
       hold on
       axis([1 24 0 1])
   end
end

% 画出聚类中心的图
figure
for i = 1:c
    plot(centers(i,:))
    hold on
    axis([1 24 0 1])
end

% 将聚类中心替代到实际负荷当中
for i = 1:c
   idx = find(U_m == i);
   electric_database_M1(idx,2:25) = repmat(centers(i,:),size(idx,1),1);
end

%% 保存
electric_database_M1(:,1) = electric_database_original(:,1);
electric_database_M1(:,27:28) = electric_database_original(:,27:28);

save('verify_electric_database_M1','electric_database_M1')












