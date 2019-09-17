clc; clear; tic;
WarnWave = [sec(1:.15:500)];
Audio = audioplayer(WarnWave, 20000);
play(Audio);

%% INITIALIZATION

gen = 27; pop = 500;
 
x1 = generateEggHolderX(pop,gen);
x2 = generateEggHolderX(pop,gen);
x3 = generateEggHolderX(pop,gen);
x4 = generateEggHolderX(pop,gen);
x5 = generateEggHolderX(pop,gen);

x1val = bin2num(x1);
x2val = bin2num(x2);
x3val = bin2num(x3);
x4val = bin2num(x4);
x5val = bin2num(x5);

fitness = fitProb29fiveVar(bin2num(x1),bin2num(x2),bin2num(x3),bin2num(x4),bin2num(x5));

pcross = 0.5;
pmut = 0.5;
max_Iteration = 500;
%% GENETIC ALGORITHM

for iterasi = 1:max_Iteration
    iterasi
    %% SELECTION %%
    x1new = selection_EggHolder(x1,fitness);
    x2new = selection_EggHolder(x2,fitness);
    x3new = selection_EggHolder(x3,fitness);
    x4new = selection_EggHolder(x4,fitness);
    x5new = selection_EggHolder(x5,fitness);

    %% CROSS OVER %%
    x1new = crossover_EggHolder(x1new,pcross);
    x2new = crossover_EggHolder(x2new,pcross);
    x3new = crossover_EggHolder(x3new,pcross);
    x4new = crossover_EggHolder(x4new,pcross);
    x5new = crossover_EggHolder(x5new,pcross);

    %% MUTATION %%
    x1new = mutation_EggHolder(x1new, pmut);
    x2new = mutation_EggHolder(x2new, pmut);
    x3new = mutation_EggHolder(x3new, pmut);
    x4new = mutation_EggHolder(x4new, pmut);
    x5new = mutation_EggHolder(x5new, pmut);

    %% NEW GENERATION %%   
    fitnessbaru = fitProb29fiveVar(bin2num(x1new),bin2num(x2new),bin2num(x3new),bin2num(x4new),bin2num(x5new));
    for i = 1:pop
        if fitnessbaru(i)>fitness(i)
            x1(i,:) = x1new(i,:);
            x2(i,:) = x2new(i,:);
            x3(i,:) = x3new(i,:);
            x4(i,:) = x4new(i,:);
            x5(i,:) = x5new(i,:); 
        end
        if fitnessbaru == fitness
            break; 
        end
    end
    fitness = fitProb29fiveVar(bin2num(x1),bin2num(x2),bin2num(x3),bin2num(x4),bin2num(x5))
    temp(iterasi) = max(fitness);
    posisi = find(fitness==max(fitness));
    tempx1(iterasi) = max(bin2num(x1(posisi(1),:)));
    tempx2(iterasi) = max(bin2num(x2(posisi(1),:)));
    tempx3(iterasi) = max(bin2num(x3(posisi(1),:)));
    tempx4(iterasi) = max(bin2num(x4(posisi(1),:)));
    tempx5(iterasi) = max(bin2num(x5(posisi(1),:)));
end

%% EVALUASI POPULASI
cla;
plot(1:max_Iteration,temp); hold on;
plot(1:max_Iteration,tempx1); hold on;
plot(1:max_Iteration,tempx2); hold on;
plot(1:max_Iteration,tempx3); hold on;
plot(1:max_Iteration,tempx4); hold on;
plot(1:max_Iteration,tempx5); hold on;
legend('fitness','x1','x2','x3','x4','x5');

result = find(fitness == max(fitness));
index = result(1);
fitness = -fitProb29fiveVar(bin2num(x1(index,:)),bin2num(x2(index,:)),bin2num(x3(index,:)),bin2num(x4(index,:)),bin2num(x5(index,:)))
[bin2num(x1(index,:)),bin2num(x2(index,:)),bin2num(x3(index,:)),bin2num(x4(index,:)),bin2num(x5(index,:))]
toc;

WarnWave = [sec(1:.15:500)];
Audio = audioplayer(WarnWave, 22050);
play(Audio);