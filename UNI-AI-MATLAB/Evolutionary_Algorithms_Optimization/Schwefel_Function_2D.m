clc, clearvars, close all

x0 = -800:5:800;
y0 = -800:5:800;
[X, Y] = meshgrid(x0, y0);
Z = zeros(size(x0));
for i = 1:size(X,1)
    for j = 1:size(Y,2)
        Z(i,j) = testfn3b([X(i,j),Y(i,j)]);
    end
end

surf(X,Y,Z, EdgeColor="none");
ylabel('x2');
xlabel('x1')
zlabel('y=F(x)');
title('New Schwefel f.');
hold on;

maxAttempts = 10;
minimum_y = zeros(1, maxAttempts);
minimum_x = zeros(1, maxAttempts);
minimum_z = zeros(1, maxAttempts);
foundCount = 0;

x0 = -800 + 1600 * rand;
y0 = -800 + 1600 * rand;
z0 = testfn3b([x0,y0]);
d = 5;

while (foundCount < maxAttempts)
    if(testfn3b([x0 + d,y0]) > z0 && testfn3b([x0 - d,y0]) > z0 && testfn3b([x0,y0 + d]) > z0 ...
            && testfn3b([x0,y0 - d]) > z0)
        minimum_y(foundCount + 1) = y0;
        minimum_x(foundCount + 1) = x0;
        minimum_z(foundCount + 1) = z0;
        plot3(x0,y0,z0,'go','MarkerFaceColor','g','MarkerSize',5);
        hold on;
        x0 = -800 + 1600 * rand;
        y0 = -800 + 1600 * rand;
        z0 = testfn3b([x0,y0]);
        foundCount = foundCount + 1;
    end
    if (testfn3b([x0 + d,y0]) < z0)
        x0 = x0 + d;
    elseif (testfn3b([x0 - d,y0]) < z0)
        x0 = x0 - d;
    elseif (testfn3b([x0,y0 + d]) < z0)
        y0 = y0 + d;
    elseif (testfn3b([x0,y0 - d]) < z0)
        y0 = y0 - d;
    end
    z0 = testfn3b([x0,y0]);
    plot3(x0,y0,z0,'bo','MarkerFaceColor','b','MarkerSize',3);
    hold on;
    pause(0.01);
end

globalMinY = minimum_y(1);
index = 1;
for i = 2:length(minimum_y)
    if minimum_y(i) < globalMinY
        globalMinY = minimum_y(i);
        index = i;
    end
end
disp(['Global minimum: x = ', num2str(minimum_x(index)), ' y = ', num2str(minimum_y(index)),' z = ', num2str(minimum_z(index))]);
