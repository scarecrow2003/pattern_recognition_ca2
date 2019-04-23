function [acc_origin, acc_80, acc_200] = svm(C)
    % load train and test images
    [train_images, test_images] = load_images();
    % generate train and test label
    [train_label, test_label] = generate_label();
    model_origin = svmtrain(train_label', train_images', ['-t 0 -c ' num2str(C)]);
    [~, acc_origin_pie, ~] = svmpredict(test_label(1:1020)', test_images(:, 1:1020)', model_origin);
    [~, acc_origin_self, ~] = svmpredict(test_label(1021:1023)', test_images(:, 1021:1023)', model_origin);
    display(strcat('PIE origin images test accuracy is:', num2str(acc_origin_pie(1))));
    display(strcat('Self photo origin test accuracy is:', num2str(acc_origin_self(1))));
    acc_origin = [acc_origin_pie(1) acc_origin_self(1)];
    % calculate eigen values and eigen vectors, sort eigen values in
    % descending order
    [eigen_values, eigen_vectors] = get_eigen(train_images);
    % reduce dimensionality to 80 and do classification using svm
    train_images_80 = train_images' * eigen_vectors(:, 1:80);
    test_images_80 = test_images' * eigen_vectors(:, 1:80);
    model_80 = svmtrain(train_label', train_images_80, ['-t 0 -c ' num2str(C)]);
    [~, acc_80_pie, ~] = svmpredict(test_label(1:1020)', test_images_80(1:1020, :), model_80);
    [~, acc_80_self, ~] = svmpredict(test_label(1021:1023)', test_images_80(1021:1023, :), model_80);
    display(strcat('PIE dimensionality 80 accuracy is:', num2str(acc_80_pie(1))));
    display(strcat('Self photo dimensionality 80 accuracy is:', num2str(acc_80_self(1))));
    acc_80 = [acc_80_pie(1) acc_80_self(1)];
    % reduce dimensionality to 200 and do classification using svm
    train_images_200 = train_images' * eigen_vectors(:, 1:200);
    test_images_200 = test_images' * eigen_vectors(:, 1:200);
    model_200 = svmtrain(train_label', train_images_200, ['-t 0 -c ' num2str(C)]);
    [~, acc_200_pie, ~] = svmpredict(test_label(1:1020)', test_images_200(1:1020, :), model_200);
    [~, acc_200_self, ~] = svmpredict(test_label(1021:1023)', test_images_200(1021:1023, :), model_200);
    display(strcat('PIE dimensionality 200 accuracy is:', num2str(acc_200_pie(1))));
    display(strcat('Self photo dimensionality 200 accuracy is:', num2str(acc_200_self(1))));
    acc_200 = [acc_200_pie(1) acc_200_self(1)];
end