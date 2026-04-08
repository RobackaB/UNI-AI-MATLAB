clc, clearvars

searchSpace = [-512 * ones(1,10);512 * ones(1,10)];
pop = genrpop(500, searchSpace);
fitness = eggholder(pop);
gen = 5000;
evolution = zeros(1,gen);

for i = 1:gen
    A = selbest(pop, fitness, [150,]);
    B = selbest(pop, fitness, [150,]);
    C = seltourn(pop, fitness, [200,]);
    D = [B; C];
    D = crossov(D, 1, 0);
    D = mutx(D, 0.1, searchSpace);
    pop = [A;D];
    fitness = eggholder(pop);
    evolution(i) = min(fitness);
end
plot(evolution);
xlabel('generation');
ylabel('F(x)');
hold on;

index = 1;
smallest = evolution(1);
for i = 2:length(evolution)
    if evolution(i) < smallest
        smallest = evolution(i);
        index = i;
    end
end

individualIndex = 1;
bestIndividual = fitness(1);
for j = 2:length(fitness)
    if fitness(j) < bestIndividual
        bestIndividual = fitness(j);
        individualIndex = j;
    end
end
bestIndividual = pop(individualIndex, :);

disp(['Global minimum: = ', num2str(evolution(index))]);
disp('Best individual is: ');
disp(bestIndividual);