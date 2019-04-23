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


function [eigen_values, eigen_vectors] = get_eigen(images)
    mean_value = mean(images, 2);
    S = (images - mean_value) * (images - mean_value)' / (20 * 119 + 7);
    [V, D] = eig(S);
    all_eigen_values = sum(D, 1);
    [~, I] = sort(all_eigen_values, 'descend');
    eigen_values = all_eigen_values(1, I);
    eigen_vectors = V(:, I);
end


function draw_eigenface(eigen_values, eigen_vectors)
    eigen_values_count = size(eigen_values, 2);
    eigen_count = 0;
    for i=1:eigen_values_count
        if eigen_values(i) < 1e-1
            eigen_count = i - 1;
            break;
        end
    end
    % draw max 25 eigen faces
    eigen_count = min(eigen_count, 25);
    eigen_faces = eigen_vectors(:, 1:eigen_count);
    rows = ceil(eigen_count / 5);
    figure();
    for i = 1:eigen_count
        subplot(rows, 5, i), imshow(reshape(eigen_faces(:, i), 32, 32), []);
    end
end


function pcs = get_pcs(eigen_values, eigen_vectors)
    eigen_values_count = size(eigen_values, 2);
    eigen_values_total = sum(eigen_values);
    % set threshold to 0.95
    threshold = eigen_values_total * 0.95;
    pc_count = 1;
    total = 0;
    for i=1:eigen_values_count
        total = total + eigen_values(i);
        if total >= threshold
            pc_count = i;
            break;
        end
    end
    pcs = eigen_vectors(:, 1:pc_count);
end