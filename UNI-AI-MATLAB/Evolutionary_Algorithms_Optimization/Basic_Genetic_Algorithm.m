clc, clearvars

searchSpace = [-800 * ones(1,10); 800 * ones(1,10)];
population = genrpop(20, searchSpace);
fitness = testfn3b(population);
numGenerations = 500;
bestFitnessHistory = zeros(1, numGenerations);

for i = 1:numGenerations
    A = selbest(population, fitness, [2,]);
    B = selbest(population, fitness, [4,]);
    C = seltourn(population, fitness, [14,]);
    D = [B; C];
    D = crossov(D, 1, 0);
    D = mutx(D, 0.1, searchSpace);
    population = [A; D];
    fitness = testfn3b(population);
    bestFitnessHistory(i) = min(fitness);
end
plot(bestFitnessHistory);
xlabel('generation');
ylabel('F(x)');
hold on;

bestGenerationIndex = 1;
minValue = bestFitnessHistory(1);
for i = 2:length(bestFitnessHistory)
    if bestFitnessHistory(i) < minValue
        minValue = bestFitnessHistory(i);
        bestGenerationIndex = i;
    end
end

bestIndividualIndex = 1;
bestIndividualFitness = fitness(1);
for j = 2:length(fitness)
    if fitness(j) < bestIndividualFitness
        bestIndividualFitness = fitness(j);
        bestIndividualIndex = j;
    end
end
bestIndividual = population(bestIndividualIndex, :);

disp(['Global minimum: = ', num2str(bestFitnessHistory(bestGenerationIndex))]);
disp('Best individual is: ');
disp(bestIndividual);