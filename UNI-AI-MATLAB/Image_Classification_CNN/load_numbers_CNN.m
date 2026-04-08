% Loading and preparing data for digit recognition (0-9), MNIST dataset
% data - XDataall - 784 x 4940 (input data x samples)
clear

% Loading data
load('datapiscisla_all.mat');

XTrain = [];
YTrain = [];
YTr = [];
XvalDat = [];
YvalDat = [];

trainLen = 1;        %  training data sample index        
valLen = 1;         % validation data sample index
imgSize = 28;       % input image dimension
percentage=60;        % percentage of training data
len = length(YDataall); % data length

Train_idx = randperm(len,len/100*percentage);   % randomly generated indices for training data

for i = 1:10
    YTr = [YTr, i*ones(1,494)];
end

for i = 1:len
    xhelp = [];
    yhelp = [];
    y = 1;
    
    % splitting vector into 28x28 image by rows
    for x = 1:784
        yhelp = [yhelp, XDataall(x, i)];
        if y == 28
            xhelp = [xhelp; yhelp];
            yhelp = [];
            y = 0;
        end
        y = y + 1;
    end
    
    % if sample index is in training data
    if ismember(i, Train_idx)
        XTrain(:,:,1,trainLen) = xhelp;
        YTrain = [YTrain, YTr(i)];
        trainLen = trainLen + 1;
    else
        XvalDat(:,:,1,valLen) = xhelp;
        YvalDat = [YvalDat, YTr(i)];
        valLen = valLen + 1;
    end
end

% change to categorical type
YTrain = categorical(YTr');
YvalDat = categorical(YvalDat');


figure
idx = randperm(length(YvalDat),10);       % randomly generated 10 samples

for i = 1:numel(idx)
    subplot(2,5,i)    
    imshow(XvalDat(:,:,:,idx(i)))
    title(char(YvalDat(idx(i))))
    drawnow
end