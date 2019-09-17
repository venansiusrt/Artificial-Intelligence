function [X] = selection_Schumer (x,fitness)
    totFit = sum(abs(fitness));
    fitness = abs(fitness)/totFit;
    ukuran = size(x);
    pop = ukuran(1);
    
    %Membuat partisi roulette
    q = [];
    q(1) = 0; temp = 0; counterQ = 1;
    for i = 1:pop
        temp = temp + fitness(i);
        q(counterQ+1) = temp;
        counterQ = counterQ + 1;
    end

    %Menentukan individu yang terseleksi
    chosen = []; t = true;
    for counterChosen = 1:pop
        r = rand();
        counterQ = 1;
        while t || counterQ <= pop
            if ((q(counterQ)<r) && (r<=q(counterQ+1)))
                chosen(counterChosen) = counterQ;
            end
            counterQ = counterQ + 1; t = ~t;
        end
    end
    X = x(chosen,:);
end