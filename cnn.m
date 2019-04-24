function accuracy = cnn()
    imagePath = fullfile('images');
    ims = imageDatastore(imagePath, 'IncludeSubfolders', true, 'LabelSource','foldernames');
    [image_train, image_test] = splitEachLabel(ims, 0.7);
    layers = [
        imageInputLayer([32 32 1])

        convolution2dLayer(5, 20, 'Padding', 'same')
        maxPooling2dLayer(2, 'Stride', 2)
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(5, 50, 'Padding', 'same')
        maxPooling2dLayer(2, 'Stride', 2)
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(5, 50, 'Padding', 'same')
        maxPooling2dLayer(2, 'Stride', 2)
        batchNormalizationLayer
        reluLayer

        fullyConnectedLayer(21)
        reluLayer

        softmaxLayer

        classificationLayer
    ];

    options = trainingOptions('sgdm', ...
        'InitialLearnRate',0.01, ...
        'MaxEpochs',4, ...
        'Shuffle','every-epoch', ...
        'ValidationData',image_test, ...
        'ValidationFrequency',30, ...
        'Verbose',false, ...
        'Plots','training-progress');

    net = trainNetwork(image_train, layers, options);

    predict = classify(net, image_test);
    label = image_test.Labels;

    accuracy = sum(predict == label)/numel(label);

    display(strcat('accuracy:', num2str(accuracy)));
end