clc, clearvars, close all

x0 = -800:50:800;
y0 = -800:50:800;
z0 = -800:50:800;

[X, Y, Z] = ndgrid(x0, y0, z0);
W = zeros(size(x0));
for i = 1:size(X,1)
    for j = 1:size(Y,2)
        for  k = 1:size(Z,3)
            W(i,j,k) = testfn3b([X(i,j,k),Y(i,j,k),Z(i,j,k)]);
        end
    end
end

attempts = 10;
minimum_y = zeros(1, attempts);
minimum_x = zeros(1, attempts);
minimum_z = zeros(1, attempts);
minimum_w = zeros(1, attempts);
count = 0;

x0 = -800 + 1600 * rand;
y0 = -800 + 1600 * rand;
z0 = -800 + 1600 * rand;
w0 = testfn3b([x0,y0,z0]);
d = 50;

while (count < attempts)
    if(testfn3b([x0 + d,y0,z0]) > w0 && testfn3b([x0 - d,y0,z0]) > w0 && testfn3b([x0,y0 + d,z0]) > w0 ...
            && testfn3b([x0,y0 - d,z0]) > w0 && ...
            testfn3b([x0,y0,z0 + d]) > w0 && testfn3b([x0,y0,z0 - d]) > w0)
        minimum_y(count + 1) = y0;
        minimum_x(count + 1) = x0;
        minimum_z(count + 1) = z0;
        minimum_w(count + 1) = w0;
        x0 = -800 + 1600 * rand;
        y0 = -800 + 1600 * rand;
        z0 = -800 + 1600 * rand;
        w0 = testfn3b([x0,y0,z0]);
        count = count + 1;
    end
    if (testfn3b([x0 + d,y0,z0]) < w0)
        x0 = x0 + d;
    elseif (testfn3b([x0 - d,y0,z0]) < w0)
        x0 = x0 - d;
    elseif (testfn3b([x0,y0 + d,z0]) < w0)
        y0 = y0 + d;
    elseif (testfn3b([x0,y0 - d,z0]) < w0)
        y0 = y0 - d;
    elseif (testfn3b([x0,y0,z0 + d]) < w0)
        z0 = z0 + d;
    elseif (testfn3b([x0,y0,z0 - d]) < w0)
        z0 = z0 - d; 
    end
    w0 = testfn3b([x0,y0,z0]);
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
disp(['Global minimum: x = ', num2str(minimum_x(index)), ' y = ', num2str(minimum_y(index)), ...
    ' z = ', num2str(minimum_z(index)),' w = ',num2str(minimum_w(index))]);