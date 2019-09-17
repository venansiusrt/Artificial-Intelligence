clc; clear;
tic;

%% INITIALIZATION
gen = 12; pop = 450;

x1 = generateSchumer(pop,gen);
x2 = generateSchumer(pop,gen);
x3 = generateSchumer(pop,gen);
x4 = generateSchumer(pop,gen);
x5 = generateSchumer(pop,gen);

x1val = bin2numSchumer(x1);
x2val = bin2numSchumer(x2);
x3val = bin2numSchumer(x3);
x4val = bin2numSchumer(x4);
x5val = bin2numSchumer(x5);

fitness = fitProb71fiveVar(bin2numSchumer(x1),bin2numSchumer(x2),bin2numSchumer(x3),bin2numSchumer(x4),bin2numSchumer(x5));

pcross = 0.3;
pmut = 0.2;

%% GENETIC ALGORITHM
for iterasi = 1:2000
    iterasi
    %% SELECTION %%
    x1new = selection_Schumer(x1,fitness);
    x2new = selection_Schumer(x2,fitness);
    x3new = selection_Schumer(x3,fitness);
    x4new = selection_Schumer(x4,fitness);
    x5new = selection_Schumer(x5,fitness);

    %% CROSS OVER %%
    x1new = crossover_Schumer(x1new,pcross);
    x2new = crossover_Schumer(x2new,pcross);
    x3new = crossover_Schumer(x3new,pcross);
    x4new = crossover_Schumer(x4new,pcross);
    x5new = crossover_Schumer(x5new,pcross);

    %% MUTATION %%
    x1new = mutation_Schumer(x1new,pmut);
    x2new = mutation_Schumer(x2new,pmut);
    x3new = mutation_Schumer(x3new,pmut);
    x4new = mutation_Schumer(x4new,pmut);
    x5new = mutation_Schumer(x5new,pmut);

    %% NEW GENERATION %%
    fitnessbaru = fitProb71fiveVar(bin2numSchumer(x1new),bin2numSchumer(x2new),bin2numSchumer(x3new),bin2numSchumer(x4new),bin2numSchumer(x5new));
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
    fitness = fitProb71fiveVar(bin2numSchumer(x1),bin2numSchumer(x2),bin2numSchumer(x3),bin2numSchumer(x4),bin2numSchumer(x5))
    if fitness == zeros([pop 1])
        break
    end
end

%% EVALUASI POPULASI
result = find(fitness == min(fitness));
index = result(1);
iterasi
xstar = [bin2numSchumer(x1(index,:)) bin2numSchumer(x2(index,:)) bin2numSchumer(x3(index,:)) bin2numSchumer(x4(index,:)) bin2numSchumer(x5(index,:))]
toc