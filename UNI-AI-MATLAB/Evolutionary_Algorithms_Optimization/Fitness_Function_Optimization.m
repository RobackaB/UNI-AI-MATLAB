clc, clearvars;

space = [0 * ones(1,5); 2500000 * ones(1,5)];
pop = genrpop(50, space);
gen = 10000;
opt = 2;
evolution = zeros(1, gen);
f = fitness(pop, opt);      
for i = 1:gen
    evolution(i) = max(f);  
    A = selbest(pop, -f, [15,]);
    B = selbest(pop, -f, [15,]);
    C = seltourn(pop, -f, [20,]);
    D = [B; C];
    D = crossov(D, 1, 0);
    D = mutx(D, 0.1, space);
    pop = [A;D];
    f = fitness(pop, opt);
    evolution(i) = max(f);
end

plot(evolution,LineWidth=1);
hold on;
xlabel('x');
ylabel('F(x)');

disp(max(evolution));
best = selbest(pop, -f, 1)
