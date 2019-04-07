function pcs = pca()
    % load train and test images
    [train_images, test_images] = load_images();
    % generate train and test label
    [train_label, test_label] = generate_label();
    % calculate eigen values and eigen vectors, sort eigen values in
    % descending order
    [eigen_values, eigen_vectors] = get_eigen(train_images);
    % draw eigenfaces
    draw_eigenface(eigen_values, eigen_vectors);
    % get pca
    pcs = get_pcs(eigen_values, eigen_vectors);
    % visualize in 2D space
    visualization_2D(train_images, pcs);
    % visualize in 3D space
    visualization_3D(train_images, pcs);
    % visualize 3 eigen faces
    figure();
    for i = 1:3
        subplot(1, 3, i), imshow(reshape(eigen_vectors(:, i), 32, 32), []);
    end
    % reduce dimensionality to 40 and do classification using nearest
    % neighbor
    train_images_40 = train_images' * eigen_vectors(:, 1:20);
    test_images_40 = test_images' * eigen_vectors(:, 1:20);
    [test_acc, self_acc] = nearest_neighbor(train_images_40, train_label, test_images_40, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
    % reduce dimensionality to 80 and do classification using nearest
    % neighbor
    train_images_80 = train_images' * eigen_vectors(:, 1:80);
    test_images_80 = test_images' * eigen_vectors(:, 1:80);
    [test_acc, self_acc] = nearest_neighbor(train_images_80, train_label, test_images_80, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
    % reduce dimensionality to 200 and do classification using nearest
    % neighbor
    train_images_200 = train_images' * eigen_vectors(:, 1:200);
    test_images_200 = test_images' * eigen_vectors(:, 1:200);
    [test_acc, self_acc] = nearest_neighbor(train_images_200, train_label, test_images_200, test_label);
    display(strcat('PIE test data accuracy is:', num2str(test_acc), '. Self photo accuracy is:', num2str(self_acc)));
end