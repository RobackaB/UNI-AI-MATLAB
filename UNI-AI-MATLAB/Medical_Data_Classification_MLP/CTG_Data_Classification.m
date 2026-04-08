clear;
% coordinates x,y,z of five point groups
load CTGdata.mat

% input and output data for neural network training
    datainnet=[NDATA]';
    dataoutnet = zeros(3, 2126);
    for i = 1:2126
        trieda = typ_ochorenia(i);
        dataoutnet(trieda, i) = 1;
    end

pocet = 1;
best = zeros(1, 15);
bestC = 2;
bestN = [];
for i = 1:5
    for j = 1:3
        if j == 1
        pocet_neuronov=10;
        end
        if j == 2
        pocet_neuronov=15;
        end
        if j == 3
        pocet_neuronov=20;
        end
        net = patternnet(pocet_neuronov,'trainbr');
        
        % parameters for dividing data into training, validation and testing
        % net.divideFcn='dividerand';
        % net.divideParam.trainRatio=0.8;
        % net.divideParam.valRatio=0;
        % net.divideParam.testRatio=0.2;
        
        % custom data division, e.g. index-based
        indx=randperm(2126);
        net.divideFcn='divideind';      % index-based
        net.divideParam.trainInd=indx(1:1062);
        net.divideParam.valInd=[];
        net.divideParam.testInd=indx(1063:2126);
        
        
        % setting training parameters 
        net.trainParam.goal = 1e-4;       % termination condition for error
        net.trainParam.show = 20;           % frequency of error display
        net.trainParam.epochs = 50;        % maximum number of training epochs
        net.trainParam.max_fail=12;
        
        % neural network training
        net = train(net,datainnet,dataoutnet);
                
        % neural network output simulation for training data
        % neural network testing
        outnetsim = sim(net,datainnet);
        
        % neural network and data error
        err=(outnetsim-dataoutnet);
        
        % percentage of unsuccessfully classified points
        c = confusion(dataoutnet,outnetsim)
        best(pocet) = c;
        if c < bestC
            bestC = c;
            bestN = net;
        end
        % confusion matrix
        figure
        plotconfusion(dataoutnet,outnetsim)

        pocet = pocet + 1;
    end
end

index = 1;
najlepsie = best(index);
for k = 1:5
    if najlepsie > best(k)
        najlepsie = best(k);
        index = k;
    end
end
avg1 = mean(best(1:5));
max1 = max(best(1:5));
fprintf('Best using 10 neurons: %.2d%%\n', (1 - best(index)) * 100);
fprintf('Average using 10 neurons: %.2d%%\n', (1 - avg1)* 100);
fprintf('Worst using 10 neurons: %.2d%%\n', (1 - max1) * 100);
fprintf('\n');
index = 1;
najlepsie = best(index);
for k = 6:10
    if najlepsie > best(k)
        najlepsie = best(k);
        index = k;
    end
end
avg2 = mean(best(6:10));
max2 = max(best(6:10));
fprintf('Best using 15 neurons: %.2d%%\n', (1 - best(index))*100);
fprintf('Average using 15 neurons: %.2d%%\n', (1-avg2)*100);
fprintf('Worst using 15 neurons: %.2d%%\n', (1-max2)*100);
fprintf('\n');

index = 1;
najlepsie = best(index);
for k = 11:15
    if best(k) < najlepsie
        najlepsie = best(k);
        index = k;
    end
end
avg3 = mean(best(11:15));
max3 = max(best(11:15));
fprintf('Best using 20 neurons: %.2d%%\n', (1-best(index))*100);
fprintf('Average using 20 neurons: %.2d%%\n', (1-avg3)*100);
fprintf('Worst using 20 neurons: %.2d%%\n', (1-max3)*100);
fprintf('\n');

index = zeros(1,3);
samples = zeros(1,3);
counter = 0;
perm = randperm(2126);

for i = 1:length(perm)
    k = perm(i);
    type = typ_ochorenia(k);
    if samples(type) == 0
        index(type) = k;
        samples(type) = 1;
        counter = counter + 1;
    end
    if counter == 3
        break;
    end
end

testInd = bestN.divideParam.testInd;
testData = datainnet(:, testInd);
testSamples = datainnet(:, index);

testOut = sim(bestN, testData);
testOutSamples = sim(bestN, testSamples);

[~, predictedClass] = max(testOutSamples, [], 1);
for i = 1:3
    skutocny_typ = typ_ochorenia(index(i));
    fprintf('Disease type %d: class %d\n',skutocny_typ, predictedClass(i));
end

[~, predictedClass] = max(testOut, [], 1);

predicted = zeros(1, length(predictedClass));
true = zeros(1, length(predictedClass));

for idx = 1:length(predictedClass)
    if predictedClass(idx) == 1
        predicted(idx) = 0;
    else
        predicted(idx) = 1;
    end
    
    if typ_ochorenia(testInd(idx)) == 1
        true(idx) = 0;
    else
        true(idx) = 1;
    end
end

TP = 0; 
TN = 0; 
FP = 0; 
FN = 0; 

for idx = 1:length(predicted)
    if true(idx) == 1 && predicted(idx) == 1
        TP = TP + 1;
    elseif true(idx) == 1 && predicted(idx) == 0
        FN = FN + 1;
    elseif true(idx) == 0 && predicted(idx) == 1
        FP = FP + 1;
    elseif true(idx) == 0 && predicted(idx) == 0
        TN = TN + 1;
    end
end


sensitivity = TP / (TP + FN);
specificity = TN / (TN + FP);

fprintf('\n');
fprintf('Sensitivity: %.2f%%\n', sensitivity * 100);
fprintf('Specificity: %.2f%%\n', specificity * 100);