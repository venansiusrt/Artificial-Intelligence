function [Xbin] = generateSchumer(pop,gen)
    x = [];
    for i = 1:pop
        temp = 0;
        for k = 1:gen
            x(i,k) = round(rand(1));
        end  
    end
    Xbin = x;
end