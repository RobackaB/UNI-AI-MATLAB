clear
% x,y,z coordinates of five groups of points
load databody

% plotting points by groups
h=figure;
plot3(data1(:,1),data1(:,2),data1(:,3),'b+')
hold on
plot3(data2(:,1),data2(:,2),data2(:,3),'co')
plot3(data3(:,1),data3(:,2),data3(:,3),'g*')
plot3(data4(:,1),data4(:,2),data4(:,3),'r*')
plot3(data5(:,1),data5(:,2),data5(:,3),'mx')

axis([0 1 0 1 0 1])
title('Data points')
xlabel('x')
ylabel('y')
zlabel('z')

disp(' --------------- press key --------------')
pause

One = ones(1,50);
Zero = zeros(1,50);
% input and output data for neural network training
datainnet=[data1; data2; data3; data4; data5]';
dataoutnet=[[One, Zero, Zero, Zero, Zero];         
    [Zero, One, Zero, Zero, Zero];         
    [Zero, Zero, One, Zero, Zero];         
    [Zero, Zero, Zero, One, Zero];         
    [Zero, Zero, Zero, Zero, One]];

% creating network structure
pocet_neuronov=8;
net = patternnet(pocet_neuronov);

% % parameters for dividing data into training, validation and testing
% net.divideFcn='dividerand';
% net.divideParam.trainRatio=0.8;
% net.divideParam.valRatio=0;
% net.divideParam.testRatio=0.2;

% custom data division, e.g. index-based
indx=randperm(250);
net.divideFcn='divideind';      % index-based
net.divideParam.trainInd=indx(1:150);
net.divideParam.valInd=[];
net.divideParam.testInd=indx(151:250);


% setting training parameters 
net.trainParam.goal = 0.00001;       % termination condition for error
net.trainParam.show = 20;           % error display frequency
net.trainParam.epochs = 2000;        % maximum number of training epochs
net.trainParam.max_fail=12;

% training neural network
net = train(net,datainnet,dataoutnet);

% displaying network structure
view(net)

% simulating neural network output for training data
% testing neural network
outnetsim = sim(net,datainnet);

% neural network and data error
err=(outnetsim-dataoutnet);

% percentage of unsuccessfully classified points
c = confusion(dataoutnet,outnetsim)

% confusion matrix
figure
plotconfusion(dataoutnet,outnetsim)

% classification of 5 new points into classes
% to add

points = zeros(5, 3);
for i = 1:5
    points(i,:) = rand(1,3);
end
points = points';

newOutNetSim = sim(net, points);
figure;
hold on
plot3(data1(:,1),data1(:,2),data1(:,3),'b+')
plot3(data2(:,1),data2(:,2),data2(:,3),'co')
plot3(data3(:,1),data3(:,2),data3(:,3),'g*')
plot3(data4(:,1),data4(:,2),data4(:,3),'r*')
plot3(data5(:,1),data5(:,2),data5(:,3),'mx')

for i = 1:5
    max_hodnota = newOutNetSim(i, 1);
    trieda = 1;
    for j = 2:5
        if newOutNetSim(j, i) > max_hodnota
            max_hodnota = newOutNetSim(j, i);
            trieda = j;
        end
    end
    fprintf('Point %d, class: %d\n', i, trieda);
    if trieda == 1
        plot3(points(1,i), points(2,i), points(3,i), 'b+')
    elseif trieda == 2
        plot3(points(1,i), points(2,i), points(3,i), 'co')
    elseif trieda == 3
        plot3(points(1,i), points(2,i), points(3,i), 'g*')
    elseif trieda == 4
        plot3(points(1,i), points(2,i), points(3,i), 'r*')
    elseif trieda == 5
        plot3(points(1,i), points(2,i), points(3,i), 'mx')
    end
end

axis([0 1 0 1 0 1])
title('Data points + new points')
xlabel('x')
ylabel('y')
zlabel('z')
