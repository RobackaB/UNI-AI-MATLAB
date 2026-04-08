clear;
clc;

load datapiscisla_all.mat

numSamples = size(XDataall, 2);
imgSize = [28, 28, 1];

imagesCell = cell(numSamples, 1);
labelsNumeric = zeros(numSamples, 1);
for i = 1:numSamples
    imagesCell{i} = reshape(XDataall(:, i), [28, 28]);
    [~, idx] = max(YDataall(:, i));
    labelsNumeric(i) = idx - 1; 
end
labelsCategorical = categorical(labelsNumeric);

allImages4D = cat(4, imagesCell{:});

inputSize = [28 28 1];
numClasses = numel(categories(labelsCategorical));

layersCNN2 = [
    imageInputLayer(inputSize)
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

layersCNN3 = [
    imageInputLayer(inputSize)
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', 'MaxEpochs',4, 'MiniBatchSize',64, 'InitialLearnRate',0.01, 'Shuffle','every-epoch','Plots','training-progress', 'Verbose',false);

numRuns = 5;
CNN2 = CNN(layersCNN2, allImages4D, labelsCategorical, numRuns, options);
fprintf('Min: %.2f%%\n', min(CNN2));
fprintf('Max: %.2f%%\n', max(CNN2));
fprintf('Average: %.2f%%\n', mean(CNN2));
fprintf('\n');

CNN3 = CNN(layersCNN3, allImages4D, labelsCategorical, numRuns, options);
fprintf('Min: %.2f%%\n', min(CNN3));
fprintf('Max: %.2f%%\n', max(CNN3));
fprintf('Average: %.2f%%\n', mean(CNN3));
fprintf('\n');

runs = 5;
best = zeros(1, runs);
numOfNeurons = 40;
for i = 1:runs
        net = patternnet(numOfNeurons);
        net.divideFcn='dividerand';
        net.divideParam.trainRatio=0.6;
        net.divideParam.valRatio=0;
        net.divideParam.testRatio=0.4;

        net.trainParam.goal = 1e-4;
        net.trainParam.show = 20;
        net.trainParam.epochs = 100;
        net.trainParam.max_fail=12;

        net = train(net,XDataall,YDataall);
        outnetsim = sim(net,XDataall);

        err=(outnetsim-YDataall);
        c = confusion(YDataall,outnetsim);
        best(i) = c;

        figure
        plotconfusion(YDataall,outnetsim)
end

fprintf('Min: %.2f%%\n', (1 - max(best)) * 100);
fprintf('Max: %.2f%%\n', (1 - min(best)) * 100);
fprintf('Average: %.2f%%\n', (1 - mean(best)) * 100);
fprintf('\n');