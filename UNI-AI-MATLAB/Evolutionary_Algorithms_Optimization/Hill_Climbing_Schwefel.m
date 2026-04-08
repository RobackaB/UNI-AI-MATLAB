clc, clearvars, close all

range = -800:0.1:800;
y = testfn3b(range');

plot(range,y,'r','LineWidth',1);
xlabel('x');
ylabel('y=F(x)');
title('New Schwefel f.');
hold on;

x0 = -800 + 1600 * rand;
y0 = testfn3b(x0);
d = 0.1;

plot(x0,y0,'bo','MarkerFaceColor','b','MarkerSize',5);
hold on;

opt = 2;
if(opt == 1)
% Classic hill climbing algorithm
%###########################################################
    while (1)
        if(testfn3b(x0 + d) > y0 && testfn3b(x0 - d) > y0)
            minimum_y = y0;
            minimum_x = x0;
            disp(['Global minimum: x = ', num2str(minimum_x), ' y = ', num2str(minimum_y)]);
            plot(x0,y0,'go','MarkerFaceColor','g','MarkerSize',5);
            hold on;
            break;
        end
        if (testfn3b(x0 + d) < y0)
            x0 = x0 + d;
        elseif (testfn3b(x0 - d) < y0)
            x0 = x0 - d;
        end
        y0 = testfn3b(x0);
        plot(x0,y0,'bo','MarkerFaceColor','b','MarkerSize',3);
        hold on;
        pause(0.01);
    end
%###########################################################
end

if(opt == 2)
% Stochastic hill climbing algorithm
%###########################################################
    minimum_y = zeros(1, 3);
    minimum_x = zeros(1, 3);
    count = 0;
    while (1)
        if(testfn3b(x0 + d) > y0 && testfn3b(x0 - d) > y0)
            minimum_y(count + 1) = y0;
            minimum_x(count + 1) = x0;
            plot(x0,y0,'go','MarkerFaceColor','g','MarkerSize',5);
            hold on;
            x0 = -800 + 1600 * rand;
            y0 = testfn3b(x0);
            count = count + 1;
            if (count == 3)
                break;
            end
        end
        if (testfn3b(x0 + d) < y0)
            x0 = x0 + d;
        elseif (testfn3b(x0 - d) < y0)
            x0 = x0 - d;
        end
        y0 = testfn3b(x0);
        plot(x0,y0,'bo','MarkerFaceColor','b','MarkerSize',3);
        hold on;
        pause(0.01);
    end
    
    smallest = minimum_y(1);
    index = 1;
    for i = 2:length(minimum_y)
        if minimum_y(i) < smallest
            smallest = minimum_y(i);
            index = i;
        end
    end
    disp(['Global minimum: x = ', num2str(minimum_x(index)), ' y = ', num2str(minimum_y(index))]);
%###########################################################
end