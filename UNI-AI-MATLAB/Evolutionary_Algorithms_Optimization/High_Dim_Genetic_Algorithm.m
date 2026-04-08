clc, clearvars

space = [-800 * ones(1,100);800 * ones(1,100)];
pop = genrpop(100, space);
fitness = testfn3b(pop);
gen = 10000;
evolution = zeros(1,gen);

for i = 1:gen
    A = selbest(pop, fitness, [25,]);
    B = selbest(pop, fitness, [25,]);
    C = seltourn(pop, fitness, [50,]);
    D = [B; C];
    D = crossov(D, 1, 0);
    D = mutx(D, 0.1, space);
    pop = [A;D];
    fitness = testfn3b(pop);
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

individual_index = 1;
best_individual = fitness(1);
for j = 2:length(fitness)
    if fitness(j) < best_individual
        best_individual = fitness(j);
        individual_index = j;
    end
end
best_individual = pop(individual_index, :);

disp(['Global minimum: = ', num2str(evolution(index))]);
disp('Best individual is: ');
disp(best_individual);