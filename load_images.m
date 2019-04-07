function [train_images, test_images] = load_images()
    folder_count = 20;
    image_count = 170;
    train_ratio = 0.7;
    train_count = round(image_count * train_ratio);
    test_count = round(image_count * (1 - train_ratio));
    train_images = zeros(1024, folder_count * train_count+7);
    test_images = zeros(1024, folder_count * test_count+3);
    % load PIE images
    for i=1:folder_count
        folder_name = strcat('images/', num2str(i), '/');
        images = zeros(1024, image_count);
        for j=1:image_count
            image_name = strcat(folder_name, num2str(j), '.jpg');
            images(:, j) = reshape(imread(image_name), [1024, 1]);
        end
        perm = randperm(170);
        train_images(:, (i-1)*train_count+1:i*train_count) = images(:, perm(1:train_count));
        test_images(:, (i-1)*test_count+1:i*test_count) = images(:, perm(train_count+1:image_count));
    end
    % load self photo
    self_images = zeros(1024, 10);
    for i=1:10
        image_name = strcat('images/me/', num2str(i), '.jpg');
        self_images(:, i) = reshape(imread(image_name), [1024, 1]);
    end
    train_images(:, folder_count*train_count+1:folder_count*train_count+7) = self_images(:, 1:7);
    test_images(:, folder_count*test_count+1:folder_count*test_count+3) = self_images(:, 8:10);
end
