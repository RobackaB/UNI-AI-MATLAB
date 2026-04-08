function accRuns = CNN(layers, allImages4D, labelsCategorical, numRuns, options)
    numSamples = size(allImages4D, 4);
    accRuns = zeros(numRuns, 1);
    
    for i = 1:numRuns
        idxLogic = rand(1, numSamples) < 0.6;
        train4D = allImages4D(:, :, :, idxLogic);
        test4D = allImages4D(:, :, :, ~idxLogic);
        trainLbl = labelsCategorical(idxLogic);
        testLbl = labelsCategorical(~idxLogic);
        
        net = trainNetwork(train4D, trainLbl, layers, options);
        pred = classify(net, test4D);
        accRuns(i) = (sum(pred == testLbl) / numel(testLbl)) * 100;
        
        figure;
        plotconfusion(testLbl, pred);
    end
end