function [test_acc, self_acc] = nearest_neighbor(train_images, train_label, test_images, test_label)
    mdl = fitcknn(train_images, train_label, 'NumNeighbors', 1, 'Standardize', 1);
    label = predict(mdl, test_images);
    test_acc = sum(label(1:51*20) == test_label(1:51*20)') / (size(test_label, 2)-3);
    self_acc = sum(label(51*20+1:51*20+3) == test_label(51*20+1:51*20+3)') / 3;
end