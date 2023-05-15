function [centers,mean_d_Arr] = centers_based_on_density(arr,c)
    % 获取数据样本数
    n = size(arr,1);
    % 初始密度划分系数k及步长
    for k = 0.2:0.001:0.6
%         disp(k)
        % 计算欧式距离矩阵，上三角矩阵
        for i = 1:n-1
           for j= i+1:n
               d(i,j) = sqrt(sum((arr(i,:)-arr(j,:)).^2));
           end
        end
        d(n,:) = 0;
        d = d+d';
        % 计算平均欧式距离
        mean_d = k*sum(sum(d))/(n*(n-1));
        mean_d_Arr(1) = mean_d;
        % 计算密度参数矩阵density
        density = sum(d<mean_d)-1;
        % 循环求取前c个密度最大中心点
        for i = 1:c
            % 获取最大密度点
            [~,idx] = sort(density,'descend');
            idx = idx(1);
            centers(i,:) = arr(idx,:);
            % 剔除最大密度点所包含点
            if i ==1
                temp = d<mean_d;
                temp = temp(:,idx);
                temp_T = find(temp);
            else 
                temp = d_p<mean_d;
                temp = temp(:,idx);
                temp_T = [temp_T;find(temp)];
            end
            temp_T = unique(temp_T);
            % 更新欧式距离矩阵
            d_p = d;
            d_p(temp_T,:) = 0;
            d_p(:,temp_T) = 0;
            % 计算平均欧式距离
            n_p = n-size(temp_T,1);
            if n_p <= floor(n/20)
%              disp('1')
               break;
            end
            mean_d = k*sum(sum(d_p))/(n_p*(n_p-1));
            mean_d_Arr(i+1) = mean_d;
            % 更新密度参数矩阵density并剔除已找到的密度簇
            density = sum(d_p<mean_d)-1-size(temp_T,1);
            density(1,temp_T) = 0;
        end
        if size(centers,1) == c
%             disp(k)
            break;
        else
            clear d d_p density i idx n_p temp_T temp mean_d j centers
%             disp(['**********',num2str(k),'*************'])
        end
    end
end















