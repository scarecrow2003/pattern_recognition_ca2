function images = load_images()
    images = zeros(1024, 20 * 119);
    for i=1:20
        folder_name = strcat('images/', num2str(i), '/');
        for j=1:119
            image_name = strcat(folder_name, num2str(i), '.jpg');
            sequence = (i - 1) * 119 + j;
            images(:, sequence) = reshape(imread(image_name), [1024, 1]);
        end
    end
end