clc, clearvars;
coords=[0,0; 25,68; 12,75; 32,17; 51,64; 20,19; 52,87;
80,37; 35,82; 2,15; 50,90; 13,50; 85,52; 97,27; 37,67;
20,82; 49,0; 62,14; 7,60; 100,100];

space = [zeros(1,18); ones(1,18)];
pop = genrpop(100,space);
gen = 2000;
evolution = zeros(1, gen);
pop_perm = zeros(size(pop));

for i = 1:size(pop, 1)
    val = pop(i, :);
    ord = 1:length(val);
    for j = 1:length(ord) - 1
        for k = j + 1:length(ord)
            if(val(j) > val(k))
                temp = val(j);
                val(j) = val(k);
                val(k) = temp;
                temp = ord(j);
                ord(j) = ord(k);
                ord(k) = temp;
            end
        end
    end
    pop_perm(i, :) = ord + 1;
end

for l = 1:gen
    num = size(pop_perm, 1);
    fitness = zeros(num, 1);

    for m = 1:num
        route = [1, pop_perm(m, :), 20];
        len = 0;
        for n = 1:length(route) - 1
            x1 = coords(route(n), 1);
            y1 = coords(route(n), 2);
            x2 = coords(route(n + 1), 1);
            y2 = coords(route(n + 1), 2);

            dist = sqrt((x2 - x1)^2 + (y2 - y1)^2);
            len = len + dist;
        end
        fitness(m) = len;
    end

    A = selbest(pop_perm, fitness, [25,]);
    B = selbest(pop_perm, fitness, [25,]);
    C = seltourn(pop_perm, fitness, [50,]);
    D = [B; C];
    D = crosord(D, 0);
    D = swappart(D, 0.2);
    D = invord(D, 0.2);
    pop_perm = [A; D];
    evolution(l) = min(fitness);
    
end

figure(1);
plot(evolution);
xlabel('generation');
ylabel('F(x)');
hold on;

figure(2);
clf;
hold on;

best_route = [1, pop_perm(1, :), 20];
for o = 1:length(best_route) - 1
    x1 = coords(best_route(o), 1);
    y1 = coords(best_route(o), 2);
    x2 = coords(best_route(o + 1), 1);
    y2 = coords(best_route(o + 1), 2);

    plot([x1, x2], [y1, y2],'-o','Color',[0, 0.7, 0], ...
        'MarkerEdgeColor',[0, 0, 0.2],'MarkerSize',10, ...
        'MarkerFaceColor',[0, 0, 0.6]);
    text(x1, y1 - 2, num2str(best_route(o)), 'VerticalAlignment', 'top', ...
        'HorizontalAlignment', 'center','Color','b');
end
plot(coords(1,1), coords(1,2),'-o','Color',[0, 0.7, 0], ...
    'MarkerEdgeColor',[0, 0, 0.2],'MarkerSize',10, ...
    'MarkerFaceColor',[0, 0.7, 0]);

plot(coords(20,1),coords(20,2),'-o','Color',[0, 0.7, 0], ...
        'MarkerEdgeColor',[0, 0, 0.2],'MarkerSize',10, ...
        'MarkerFaceColor',[1, 0, 0]);

text(coords(20,1),coords(20,2) - 2, num2str(best_route(20)), 'VerticalAlignment', 'top', ...
        'HorizontalAlignment', 'center','Color','b')

fprintf('Best route is: [%s]\n', num2str(best_route));
fprintf('Its length is: %d', min(fitness));
