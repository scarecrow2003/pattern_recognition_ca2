function w = lda()
    % load train and test images
    [train_images, test_images] = load_images();
    % generate train and test label
    [train_label, test_label] = generate_label();
    
    w = get_lda_projection(train_images);
    % visualize in 2D space
    visualization_2D(train_images, w);
    % visualize in 3D space
    visualization_3D(train_images, w);
    % reduce dimensionality to 2 and do classification using nearest
    % neighbor
    train_images_2 = train_images' * w(:, 1:2);
    test_images_2 = test_images' * w(:, 1:2);
    [test_acc, self_acc] = nearest_neighbor(train_images_2, train_label, test_images_2, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
    % reduce dimensionality to 80 and do classification using nearest
    % neighbor
    train_images_3 = train_images' * w(:, 1:3);
    test_images_3 = test_images' * w(:, 1:3);
    [test_acc, self_acc] = nearest_neighbor(train_images_3, train_label, test_images_3, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
    % reduce dimensionality to 200 and do classification using nearest
    % neighbor
    train_images_9 = train_images' * w(:, 1:9);
    test_images_9 = test_images' * w(:, 1:9);
    [test_acc, self_acc] = nearest_neighbor(train_images_9, train_label, test_images_9, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
end