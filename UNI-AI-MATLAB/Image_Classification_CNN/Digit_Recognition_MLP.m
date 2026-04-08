clear;
% x,y,z coordinates of five groups of points
load datapiscisla_all.mat

runs = 5;
best = zeros(1, runs);
bestC = 2;
bestN = [];
pocet_neuronov = 40;
for i = 1:runs
    net = patternnet(pocet_neuronov);
    
    % parameters for splitting data into training, validation and testing
    net.divideFcn='dividerand';
    net.divideParam.trainRatio=0.6;
    net.divideParam.valRatio=0;
    net.divideParam.testRatio=0.4;
      
  
    % setting training parameters 
    net.trainParam.goal = 1e-4;       % termination condition for error
    net.trainParam.show = 20;           % frequency of displaying error
    net.trainParam.epochs = 200;        % maximum number of training epochs
    net.trainParam.max_fail=12;
    
    % training NN
    net = train(net,XDataall,YDataall);
        
    % simulation of NN output for training data
    % testing NN
    outnetsim = sim(net,XDataall);
    
    % NN and data error
    err=(outnetsim-YDataall);
    
    % percentage of unsuccessfully classified points
    c = confusion(YDataall,outnetsim);
    best(i) = c;
    if c < bestC
        bestC = c;
        bestN = net;
    end
    % confusion matrix
    figure
    plotconfusion(YDataall,outnetsim)
end

fprintf('Best: %.2f%%\n', (1 - min(best)) * 100);
fprintf('Average: %.2f%%\n', (1 - mean(best)) * 100);
fprintf('Worst: %.2f%%\n', (1 - max(best)) * 100);
fprintf('\n');

idx = zeros(1, 10);
for i = 1:10
    index = find(YDataall(i, :) == 1);
    if ~isempty(index)
    idx(i) = index(1); 
    end
end

X_test = XDataall(:, idx);
Y_test = YDataall(:, idx);
outTest = sim(bestN, X_test);

for i = 1:10
    [~, targetClass] = max(Y_test(:, i));
    [~, predictedClass] = max(outTest(:, i));
    fprintf('Actual = %d, Prediction = %d\n', targetClass - 1, predictedClass - 1);
    dispznak(X_test(:, i), 28, 28);
end