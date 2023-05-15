%% ��ʼ��
clc;clear
load('data_base.mat')                    % ԭʼ����
load('verify_electric_database_M1.mat')  % M1Ϊȫ������ĵ��͸������ݿ�Ϊ���������Ż���Ľ��
load('verify_electric_database_M2.mat')  % M2Ϊ�ֽڵ�����ĵ������ݿ�Ϊ��������Ż���Ľ��


%% ����ǰ˲ʱ���಻ƽ���
electric_database_original(:,29) = electric_database_original(:,27);
plot_network_g(electric_database_original,1,'k');


%% ���е����Ż�
G = 500;
accuracy = 0.00001;
P_ABC_0 = zeros(3,24);
[x,~,~,~] = ma_fun(electric_database_M1,P_ABC_0,G,accuracy);
electric_database_M1(:,29) = x';
% ���������
save('verify_electric_database_M1','electric_database_M1')


%% ���������Ż��ĸ��ڵ����಻ƽ���
electric_database_M1(:,2:25) = electric_database_original(:,2:25);
plot_network_g(electric_database_M1,2,'b');


%% ���ж���Ż�
G = 500;
[x,Fmin1] = fun_hierarchical_optimization(electric_database_M2,G);
electric_database_M2(:,29) = x';
% ���������
save('verify_electric_database_M2','electric_database_M2')


%% ��������Ż��ĸ��ڵ����಻ƽ���
electric_database_M2(:,2:25) = electric_database_original(:,2:25);
plot_network_g(electric_database_M2,2,'r');














