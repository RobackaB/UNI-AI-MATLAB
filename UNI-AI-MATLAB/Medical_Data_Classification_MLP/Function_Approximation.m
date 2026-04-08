% Example for approximation of non-linear function using NN type
% MLP network with 1 input and 1 output
clear
load datafun

% creating NN structure
% 1 input - x coordinate
% 1 hidden layer with number of neurons 25 with function 'tansig'
% 1 output with function 'purelin' - y coordinate
% training method - Levenberg-Marquardt
pocet_neuronov=22;
net=fitnet(pocet_neuronov);

% % selection of division
%net.divideFcn='dividerand'; % random division

% net.divideFcn='divideblock'; % block division

%net.divideFcn='divideint';  % every nth sample

%net.divideFcn='dividetrain';  % only training

 net.divideParam.trainRatio=0.6;
 net.divideParam.valRatio=0;
 net.divideParam.testRatio=0.4;


% net.divideFcn='divideind';      % index-based
% net.divideParam.trainInd=indx_train;
% net.divideParam.valInd=[];
% net.divideParam.testInd=indx_test;


% Setting training parameters
net.trainParam.goal = 1e-4;     % Termination condition for error
net.trainParam.show = 5;        % Frequency of displaying training error progress
net.trainParam.epochs = 100;  % Max. number of training cycles.
net.trainParam.epochs =1000;      % maximum number of training epochs.
net.trainParam.max_fail = 12;

% % Training NN
net=train(net,x,y);

% % Simulation of NN output
outnetsim = sim(net,x);

% Simulation of NN output
outnetsim = sim(net,x);
y1=y(indx_train);
y2=y(indx_test);

% calculation of network error
% to add 
out1 = outnetsim(indx_train); 
out2 = outnetsim(indx_test);

SSEtrain = sum((y1 - out1).^2);
MSEtrain = mean((y1 - out1).^2);
MAEtrain = max(abs(y1 - out1));
fprintf('Training errors:\n');
fprintf('SSE = %.4f MSE = %.4f MAE = %.4f\n',SSEtrain, MSEtrain, MAEtrain);

SSEtest = sum((y2 - out2).^2);
MSEtest = mean((y2 - out2).^2);
MAEtest = max(abs(y2 - out2));
fprintf('Test errors:\n');
fprintf('SSE = %.4f MSE = %.4f MAE = %.4f\n',SSEtest, MSEtest, MAEtest);

% Plotting the curves
figure
plot(x(indx_train),y1,'b+',x(indx_test),y2,'g*')
hold on
plot(x,outnetsim,'-or')