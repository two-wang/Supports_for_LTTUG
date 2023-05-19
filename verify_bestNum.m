%% ��ʼ��
clc;clear
% IRIS���ݼ���4ά3��150������
load IRIS.mat
% WINE���ݼ���13ά3��178������
load WINE.mat
wine_label = wine(:,1);
wine(:,1)=[];
% Gauss���ݼ�
gauss(1:100,1) = normrnd(3,1,[100,1]);
gauss(101:400,1) = normrnd(0,1,[300,1]);
gauss(1:100,2) = normrnd(0,1,[100,1]);
gauss(101:200,2) = normrnd(3,1,[100,1]);
gauss(201:400,2) = normrnd(0,1,[200,1]);
gauss(1:200,3) = normrnd(0,1,[200,1]);
gauss(201:300,3) = normrnd(3,1,[100,1]);
gauss(301:400,3) = normrnd(0,1,[100,1]);
gauss(1:300,4) = normrnd(0,1,[300,1]);
gauss(301:400,4) = normrnd(3,1,[100,1]);

%% ����Ԥ����(���ü���ֵ��׼����)
iris = iris ./repmat(max(iris),size(iris,1),1);     
wine = wine ./repmat(max(wine),size(wine,1),1); 

%% ������Ч�Ժ����б�
for k = 2:10                            % Gauss���ݼ�
    n = size(gauss,1);
    [centers,U,~] = fuzzyfcm(gauss, k, 2, 0);
    % �����һ�־�����Ч�Ժ���
    F = (sum(sum(U.^2)))/n;              % ���㻮��ϵ��
    P = sum(sum(U.^2,2)./sum(U,2))/k;    % ������ܻ���ϵ��
    FP1(1,k-1) = F-P;
    % ����ڶ��־�����Ч�Ժ���
    V0 = (sum(gauss)./n);
    J0 = sum(sum((gauss-repmat(V0,n,1)).^2,2));
    ST1 = 0;
    for i=1:k
        S = sum( (U(i,:).^2).*sum(( gauss'-repmat(centers(i,:)',1,n) ).^2) );
        ST1 = ST1 + S;
    end
    P_p1(1,k-1) = ( min(sum(U,2))/max(sum(U,2)) ) * (P + 1 - ST1/J0);

    % ��������־�����Ч�Ժ���
    ST3 = 0;
    for i = 1:k
       for j = 1:n
           ST3 = ST3 + U(i,j)^2* sum( (gauss(j,:)-centers(i,:)).^2 ) ;
       end
    end
    ST3 = ST3/(n-k);
    ST3Z = sum(sum(U.^2,2).* sum( (centers-repmat(V0,k,1)).^2,2 ))/(k-1) ;
    L1(1,k-1) = ST3Z/ST3;
end
clear centers F i j J0 k n P S ST1 ST3 ST3Z U V0 

for k = 2:10                            % �β�����ݼ�
    n = size(iris,1);
    [centers,U,~] = fuzzyfcm(iris, k, 2, 0);
    % �����һ�־�����Ч�Ժ���
    F = (sum(sum(U.^2)))/n;             
    P = sum(sum(U.^2,2)./sum(U,2))/k;    
    FP2(1,k-1) = F-P;
    % ����ڶ��־�����Ч�Ժ���
    V0 = (sum(iris)./n);
    J0 = sum(sum((iris-repmat(V0,n,1)).^2,2));
    ST1 = 0;
    for i=1:k
        S = sum( (U(i,:).^2).*sum(( iris'-repmat(centers(i,:)',1,n) ).^2) );
        ST1 = ST1 + S;
    end
    P_p2(1,k-1) = ( min(sum(U,2))/max(sum(U,2)) ) * (P + 1 - ST1/J0);

    % ��������־�����Ч�Ժ���
    ST3 = 0;
    for i = 1:k
       for j = 1:n
           ST3 = ST3 + U(i,j)^2* sum( (iris(j,:)-centers(i,:)).^2 ) ;
       end
    end
    ST3 = ST3/(n-k);
    ST3Z = sum(sum(U.^2,2).* sum( (centers-repmat(V0,k,1)).^2,2 ))/(k-1) ;
    L2(1,k-1) = ST3Z/ST3;
end
clear centers F i j J0 k n P S ST1 ST3 ST3Z U V0 

for k = 2:10                            % ���Ѿ����ݼ�
    n = size(wine,1);
    [centers,U,~] = fuzzyfcm(wine, k, 2, 0);
    % �����һ�־�����Ч�Ժ���
    F = (sum(sum(U.^2)))/n;            
    P = sum(sum(U.^2,2)./sum(U,2))/k;  
    FP3(1,k-1) = F-P;
    % ����ڶ��־�����Ч�Ժ���
    V0 = (sum(wine)./n);
    J0 = sum(sum((wine-repmat(V0,n,1)).^2,2));
    ST1 = 0;
    for i=1:k
        S = sum( (U(i,:).^2).*sum(( wine'-repmat(centers(i,:)',1,n) ).^2) );
        ST1 = ST1 + S;
    end
    P_p3(1,k-1) = ( min(sum(U,2))/max(sum(U,2)) ) * (P + 1 - ST1/J0);

    % ��������־�����Ч�Ժ���
    ST3 = 0;
    for i = 1:k
       for j = 1:n
           ST3 = ST3 + U(i,j)^2* sum( (wine(j,:)-centers(i,:)).^2 ) ;
       end
    end
    ST3 = ST3/(n-k);
    ST3Z = sum(sum(U.^2,2).* sum( (centers-repmat(V0,k,1)).^2,2 ))/(k-1) ;
    L3(1,k-1) = ST3Z/ST3;
end
clear centers F i j J0 k n P S ST1 ST3 ST3Z U V0 
%% ��ͼ
k_x = 2:10;
figure(1)
plot(k_x,FP1)
hold on
plot(k_x,FP2)
plot(k_x,FP3)
legend('Gauss���ݼ�','IRIS���ݼ�','WINE���ݼ�')

figure(2)
plot(k_x,P_p1)
hold on
plot(k_x,P_p2)
plot(k_x,P_p3)
legend('Gauss���ݼ�','IRIS���ݼ�','WINE���ݼ�')

figure(3)
plot(k_x,L1)
hold on
plot(k_x,L2)
plot(k_x,L3)
legend('Gauss���ݼ�','IRIS���ݼ�','WINE���ݼ�')

%% �ۺ��о�
FP1 = FP1 ./repmat(max(FP1),size(FP1,1),1); 
FP2 = FP2 ./repmat(max(FP2),size(FP2,1),1);  
FP3 = FP3 ./repmat(max(FP3),size(FP3,1),1);  

P_p1 = P_p1 ./repmat(max(P_p1),size(P_p1,1),1); 
P_p2 = P_p2 ./repmat(max(P_p2),size(P_p2,1),1);  
P_p3 = P_p3 ./repmat(max(P_p3),size(P_p3,1),1);  

L1 = L1 ./repmat(max(L1),size(L1,1),1); 
L2 = L2 ./repmat(max(L2),size(L2,1),1);  
L3 = L3 ./repmat(max(L3),size(L3,1),1);  

comprehensive1 = (P_p1+L1)-FP1;
comprehensive2 = (P_p2+L2)-FP2;
comprehensive3 = (P_p3+L3)-FP3;

figure(4)
plot(k_x,comprehensive1)
hold on
plot(k_x,comprehensive2)
plot(k_x,comprehensive3)
legend('Gauss���ݼ�','IRIS���ݼ�','WINE���ݼ�')

























