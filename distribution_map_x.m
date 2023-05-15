function  [Temp,x] = distribution_map_x(data,x,display)
     data = data(:);
     x = x(:);
     if display
        figure
        Temp = [];
        for i = 1:size(x,1)-1
            Temp = [Temp sum(data>x(i) & data<=x(i+1))/size(data,1)*100];
        end
        b = bar(x(1:end-1),Temp);
        b.BarWidth = 1;
     else
        Temp = [];
        for i = 1:size(x,1)-1
            Temp = [Temp sum(data>x(i) & data<=x(i+1))/size(data,1)*100];
        end
     end
     Temp = Temp(:);
end