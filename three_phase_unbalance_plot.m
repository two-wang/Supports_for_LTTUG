function [g_res] = three_phase_unbalance_plot(data,frase,display)
    I_A = sum(data(frase == 1,:));
    I_B = sum(data(frase == 2,:));
    I_C = sum(data(frase == 3,:));
    I_mean = (I_A+I_B+I_C)./3;
    y = [I_A ; I_B ; I_C]';
    g = (max(y') - I_mean)./ I_mean*100;
    if display
        figure
        yyaxis left
        b = bar(y,'hist');
        xlabel('时间/h')
        ylabel('功率/kw')
        b(1).FaceColor = 'yellow';
        b(2).FaceColor = 'green';
        b(3).FaceColor = 'red';
        yyaxis right
        p = plot(g,'-*');
        p.LineWidth=2;
        p.Color = 'magenta';
        ylabel('三相不平衡度（%）')
        legend('A相','B相','C相','三相不平衡度')
    end
    % 输出平均三相不平衡度
    g_res = mean(g);
end