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
    % reduce dimensionality to 3 and do classification using nearest
    % neighbor
    train_images_3 = train_images' * w(:, 1:3);
    test_images_3 = test_images' * w(:, 1:3);
    [test_acc, self_acc] = nearest_neighbor(train_images_3, train_label, test_images_3, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
    % reduce dimensionality to 9 and do classification using nearest
    % neighbor
    train_images_9 = train_images' * w(:, 1:9);
    test_images_9 = test_images' * w(:, 1:9);
    [test_acc, self_acc] = nearest_neighbor(train_images_9, train_label, test_images_9, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
end


function w = get_lda_projection(images)
    length = size(images, 2);
    mu = mean(images, 2);
    sw = zeros(1024, 1024);
    sb = zeros(1024, 1024);
    for i=1:20
        class_data = images(:, (i-1)*119+1:i*119);
        mui = mean(class_data, 2);
        s = (class_data - mui) * (class_data - mui)' / 119;
        sw = sw + s * (119 / length);
        sb = sb + (mui - mu) * (mui - mu)' * (119 / length);
    end
    self_photo = images(:, 20*119+1:20*119+7);
    self_photo_mu = mean(self_photo, 2);
    sw = sw + (self_photo - self_photo_mu) * (self_photo - self_photo_mu)' / length;
    sb = sb + (self_photo_mu - mu) * (self_photo_mu - mu)' * (7 / length);
    [V, D] = eig(sw \ sb);
    all_eigen_values = sum(D, 1);
    [~, I] = sort(all_eigen_values, 'descend');
    w = V(:, I);
end