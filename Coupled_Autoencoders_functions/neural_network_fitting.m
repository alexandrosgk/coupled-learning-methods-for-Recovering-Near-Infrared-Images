function [net] = neural_network_fitting(train_rgb, trainLd, num_of_Layers)



    x = train_rgb;
    t = trainLd;

    % Choose a Training Function
    % For a list of all training functions type: help nntrain
    % 'trainlm' is usually fastest.
    % 'trainbr' takes longer but may be better for challenging problems.
    % 'trainscg' uses less memory. Suitable in low memory situations.
     trainFcn = 'trainscg';  % Bayesian Regularization backpropagation.

%   % Create a Fitting Network
%     hiddenLayerSize = num_of_Layers;
%     net = fitnet(hiddenLayerSize,trainFcn);
      net = feedforwardnet(num_of_Layers, trainFcn);
% 

%     net.numLayers = 15;
    % Choose Input and Output Pre/Post-Processing Functions
%     For a list of all processing functions type: help nnprocess
    net.input.processFcns = {'removeconstantrows','mapstd'};
    net.output.processFcns = {'removeconstantrows','mapstd'};
    net.trainParam.showWindow=0;

    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivision
%     net.divideFcn = 'dividerand';  % Divide data randomly
%     net.divideMode = 'sample';     % Divide up every sample
%     net.divideParam.trainRatio = 60/100;
%     net.divideParam.valRatio = 25/100;
%     net.divideParam.testRatio = 15/100;

    % Choose a Performance Function
    % For a list of all performance functions type: help nnperformance
    net.performFcn = 'mse';  % Mean Squared Error
    % net.performParam.regularization = 0.001;
    net.performParam.normalization = 'none';

    % Train the Network
    [net,~] = train(net,x,t);



end