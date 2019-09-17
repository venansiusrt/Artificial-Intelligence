clc; clear;
tic;
%% INITIALIZATION
gen = 10; pop = 10;

x1 = generateMishra(pop,gen);
x2 = generateMishra(pop,gen);
x3 = generateMishra(pop,gen);
x4 = generateMishra(pop,gen);
x5 = generateMishra(pop,gen);

x1val = bin2numMishra(x1);
x2val = bin2numMishra(x2);
x3val = bin2numMishra(x3);
x4val = bin2numMishra(x4);
x5val = bin2numMishra(x5);

fitness = fitProb45fiveVar(bin2numMishra(x1),bin2numMishra(x2),bin2numMishra(x3),bin2numMishra(x4),bin2numMishra(x5));

pcross = 0.30;
pmut = 0.40;

%% GENETIC ALGORITHM
for iterasi = 1:3000
    iterasi
    %% SELECTION %%
    x1new = selection_Mishra(x1,fitness);
    x2new = selection_Mishra(x2,fitness);
    x3new = selection_Mishra(x3,fitness);
    x4new = selection_Mishra(x4,fitness);
    x5new = selection_Mishra(x5,fitness);

    %% CROSS OVER %%
    x1new = crossover_Mishra(x1new,pcross);
    x2new = crossover_Mishra(x2new,pcross);
    x3new = crossover_Mishra(x3new,pcross);
    x4new = crossover_Mishra(x4new,pcross);
    x5new = crossover_Mishra(x5new,pcross);

    %% MUTATION %%
    x1new = mutation_Mishra(x1new,pmut);
    x2new = mutation_Mishra(x2new,pmut);
    x3new = mutation_Mishra(x3new,pmut);
    x4new = mutation_Mishra(x4new,pmut);
    x5new = mutation_Mishra(x5new,pmut);

    %% NEW GENERATION %%
    fitnessbaru = fitProb45fiveVar(bin2numMishra(x1new),bin2numMishra(x2new),bin2numMishra(x3new),bin2numMishra(x4new),bin2numMishra(x5new));
    for i = 1:pop
        if fitnessbaru(i)<fitness(i)
            fitness(i) = fitnessbaru(i);
            x1(i,:) = x1new(i,:);
            x2(i,:) = x2new(i,:);
            x3(i,:) = x3new(i,:);
            x4(i,:) = x4new(i,:);
            x5(i,:) = x5new(i,:);
        end
    end
    
    fitness = fitProb45fiveVar(bin2numMishra(x1),bin2numMishra(x2),bin2numMishra(x3),bin2numMishra(x4),bin2numMishra(x5))
    if fitness == zeros([pop 1])
        break;
    end
end

%% EVALUASI POPULASI
result = find(fitness == min(fitness));
index = result(1);
[bin2numMishra(x1(index,:)) bin2numMishra(x2(index,:)) bin2numMishra(x3(index,:)) bin2numMishra(x4(index,:)) bin2numMishra(x5(index,:))]
toc