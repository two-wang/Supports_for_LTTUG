function [centers,U,fun] = fuzzyfcm(arr , c , m, random)

    %INPUT:  n*m����nΪ��������mΪ������������������cΪ��������mΪģ��ָ����m>=1.
    %OUTPUT: centersΪ�������ģ�UΪ�����ȣ�funΪĿ�꺯������ֵ�������顣
    fun = zeros(2000,1);
    
    %% ��ʼ���������ļ����Ӧ�������Ⱦ���
    [size_x,size_y] = size(arr);
    V = zeros(c,size_y);
    U = zeros(c,size_x);
    if random == 1
        random = randi(floor(size_x/c));
        for i = 1:c
            V(i,:) = arr( round((i-1)*size_x/c)+ random ,:);
        end
    else
        V = centers_based_on_density(arr,c); % �����ܶ��Ż�ѡ������ʼ����
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
    %% ����F
    F = 0;
    for i = 1:c
       for j = 1:size_x
          F = F + U(i,j)^m*sum(( (arr(j,:)-V(i,:)).^2 )); 
       end
    end
    fun(1,1) = F;
    %% �趨��������e����ʼ��������l,���¾�������
    e = 0.00000001;
    l = 0;
    for i = 1:c
       V(i,:) = sum(repmat((U(i,:).^m)',1,size_y).*arr) / sum(U(i,:).^m); 
    end
    
    %% ����Fp
    Fp = 0;
    for i = 1:c
       for j = 1:size_x
          Fp = Fp + U(i,j)^m*sum(( (arr(j,:)-V(i,:)).^2 )); 
       end
    end
    fun(2,1) = Fp;
    
    %% ѭ���ж�
    while ((F-Fp)>e)
        % ���������Ⱦ���
        for i = 1:c
           for j = 1:size_x
              if sqrt( sum((arr(j,:)-V(i,:)).^2) ) == 0
                  U(i,j) = 1;
              else
                  U(i,j) = 1/( sum( 1./(sqrt( sum( (repmat(arr(j,:),c,1)-V).^2,2) ).^(2/(m-1))) )* (sqrt( sum((arr(j,:)-V(i,:)).^2) ).^(2/(m-1))) );
              end
           end
        end
        % ���¾�������
        for i = 1:c
           V(i,:) = sum(repmat((U(i,:).^m)',1,size_y).*arr) / sum(U(i,:).^m); 
        end
        % ����F��Fp
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
    % ��ֵ���
    centers = V;
    T = find(fun == 0 );
    fun(T(1,1):2000,:) = [];
end












