clc; clear; tic;
WarnWave = [sec(1:.15:500)];
Audio = audioplayer(WarnWave, 22050);
play(Audio);

%% INITIALIZATION

gen = 80; pop = 1000;

x1 = generateEggHolderX(pop,gen);
x2 = generateEggHolderX(pop,gen);

x1val = bin2num(x1);
x2val = bin2num(x2);

fitness = fitProb29twoVar(bin2num(x1),bin2num(x2));

pcross = 0.5;
pmut = 0.5;
max_Iteration = 2000;

%% GENETIC ALGORITHM
for iterasi = 1:max_Iteration
    iterasi
    %% SELECTION %%
    x1new = selection_EggHolder(x1,fitness);
    x2new = selection_EggHolder(x2,fitness);

    %% CROSS OVER %%
    x1new = crossover_EggHolder(x1new, pcross);
    x2new = crossover_EggHolder(x2new, pcross);

    %% MUTATION %%
    x1new = mutation_EggHolder(x1new, pmut);
    x2new = mutation_EggHolder(x2new, pmut);

    %% NEW GENERATION %%
    fitnessbaru = fitProb29twoVar(bin2num(x1new),bin2num(x2new));
    for i = 1:pop
        if fitnessbaru(i)>fitness(i)
            x1(i,:) = x1new(i,:);
            x2(i,:) = x2new(i,:);
        end
    end
    fitness = fitProb29twoVar(bin2num(x1),bin2num(x2))
    temp(iterasi) = max(fitness);
    posisi = find(fitness==max(fitness));
    tempx1(iterasi) = max(bin2num(x1(posisi(1),:)));
    tempx2(iterasi) = max(bin2num(x2(posisi(1),:)));
end

%% EVALUASI POPULASI
plot(1:max_Iteration,temp); hold on;
plot(1:max_Iteration,tempx1); hold on;
plot(1:max_Iteration,tempx2); hold on;
legend('fitness','x1','x2');

result = find(fitness == max(fitness));
index = result(1);
fitness = -fitProb29twoVar(bin2num(x1(index,:)),bin2num(x2(index,:)))
[bin2num(x1(index,:)) bin2num(x2(index,:))]
toc;

% WarnWave = [sec(1:.15:750),tan(1:.45:750)];
% Audio = audioplayer(WarnWave, 22050);
% play(Audio);

load chirp.mat;
sound(y, Fs);