function [num] = bin2numSchumer(x)
    ukuran = size(x);
    pop = ukuran(1);
    gen = ukuran(2);
    for i = 1:pop
        temp = 0;
        for j = 1:gen
            temp = temp + x(i,j)*2^(gen-j);
        end
        fitness(i) = temp;
    end
    num = fitness';
end