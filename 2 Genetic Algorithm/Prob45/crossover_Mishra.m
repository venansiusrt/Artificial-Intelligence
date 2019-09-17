function [X] = crossover_Mishra(x,crossRate)
    ukuran = size(x);
    pop = ukuran(1);
    gen = ukuran(2);
    for i = 1:pop
        r = rand(1);
        if r<crossRate
            while true
                parent1 = round((pop-1)*rand(1)+1);
                parent2 = round((pop-1)*rand(1)+1);
                if (parent1 ~= parent2)
                    tempparent = [x(parent1,:); x(parent2,:)];
                    break; 
                end
            end

            %mendapatkan indeks yang akan disilangkan
            posCross = round((gen-1)*rand(1)+1);

            %CrossOver
            for k = posCross:gen
                tempparent([2*k-1 2*k]) = tempparent([2*k 2*k-1]);
            end
            x(parent1,:) = tempparent(1,:);
            x(parent2,:) = tempparent(2,:);
        end
    end
    X = x;
end

