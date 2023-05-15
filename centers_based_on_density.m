function [centers,mean_d_Arr] = centers_based_on_density(arr,c)
    % ��ȡ����������
    n = size(arr,1);
    % ��ʼ�ܶȻ���ϵ��k������
    for k = 0.2:0.001:0.6
%         disp(k)
        % ����ŷʽ������������Ǿ���
        for i = 1:n-1
           for j= i+1:n
               d(i,j) = sqrt(sum((arr(i,:)-arr(j,:)).^2));
           end
        end
        d(n,:) = 0;
        d = d+d';
        % ����ƽ��ŷʽ����
        mean_d = k*sum(sum(d))/(n*(n-1));
        mean_d_Arr(1) = mean_d;
        % �����ܶȲ�������density
        density = sum(d<mean_d)-1;
        % ѭ����ȡǰc���ܶ�������ĵ�
        for i = 1:c
            % ��ȡ����ܶȵ�
            [~,idx] = sort(density,'descend');
            idx = idx(1);
            centers(i,:) = arr(idx,:);
            % �޳�����ܶȵ���������
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
            % ����ŷʽ�������
            d_p = d;
            d_p(temp_T,:) = 0;
            d_p(:,temp_T) = 0;
            % ����ƽ��ŷʽ����
            n_p = n-size(temp_T,1);
            if n_p <= floor(n/20)
%              disp('1')
               break;
            end
            mean_d = k*sum(sum(d_p))/(n_p*(n_p-1));
            mean_d_Arr(i+1) = mean_d;
            % �����ܶȲ�������density���޳����ҵ����ܶȴ�
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















