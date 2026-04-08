function [f] = fitness(pop, opt)
[lpop,lstring]=size(pop);

f = zeros(1, lpop);
for j = 1:lpop
    r = pop(j, :);
    x1 = r(1);
    x2 = r(2);
    x3 = r(3);
    x4 = r(4);
    x5 = r(5);
    J = 0.04*x1 + 0.07*x2 + 0.11*x3 + 0.06*x4 + 0.05*x5;
    p1 = (x1 + x2 + x3 + x4 + x5) > 10000000;
    p2 = (x1 + x2) > 2500000;
    p3 = (-x4 + x5) > 0;
    p4 = (-0.5*x1 - 0.5*x2 + 0.5*x3 + 0.5*x4 - 0.5*x5) > 0;
    q = 0;
    f(j) = 0;
    pokuta = 0;
    switch opt
        case 1
            if p1
                pokuta = inf;
            end
            if p2
                pokuta = inf;
            end
            if p3
                pokuta = inf;
            end
            if p4
                pokuta = inf;
            end
        case 2
            if p1
                q = q + 1;
            end
            if p2
                q = q + 1;
            end
            if p3
                q = q + 1;
            end
            if p4
                q = q + 1;
            end
            pokuta = (10^7)*q;
        case 3
            if p1
                pokuta = pokuta + (x1 + x2 + x3 + x4 + x5 - 10000000);
            end
            if p2
                pokuta = pokuta + (x1 + x2 - 2500000);
            end
            if p3
                pokuta = pokuta + (-x4 + x5);
            end
            if p4
                pokuta = pokuta + (-0.5*x1 - 0.5*x2 + 0.5*x3 + 0.5*x4 - 0.5*x5);
            end
        otherwise
            pokuta = 0;
    end    
    f(j) =f(j) + J - pokuta;
end
end

