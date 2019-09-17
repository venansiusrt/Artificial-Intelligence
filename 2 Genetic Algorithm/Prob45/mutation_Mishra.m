function [X] = mutation_Mishra(x,mutationRate)
    ukuran = size(x);
    pop = ukuran(1);
    gen = ukuran(2);
    for i = 1:pop
        %Mendapatkan individu yang akan mutasi
        posMutPop = round((pop-1)*rand(1)+1);

        %Mendapatkan posisi gen yang akan termutasi
        posMutGen = round((gen-1)*rand(1)+1);
        pMutRand = rand(1);

        %Mutasi
        if pMutRand < mutationRate
            x(posMutPop,posMutGen) = 1-x(posMutPop,posMutGen);
        end
    end
    X = x;
end

