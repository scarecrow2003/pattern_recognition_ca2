function pcs = pca()
    images = zeros(1024, 20 * 119);
    for i=1:20
        folder_name = strcat('images/', num2str(i), '/');
        for j=1:119
            image_name = strcat(folder_name, num2str(i), '.jpg');
            sequence = (i - 1) * 119 + j;
            images(:, sequence) = reshape(imread(image_name), [1024, 1]);
        end
    end
    mean_value = mean(images, 2);
    S = (images - mean_value) * (images - mean_value)' / (20 * 119);
    [V, D] = eig(S);
    eigenvalues = sum(D, 1);
    eigenvalues_total = sum(eigenvalues);
    eigenvalues_size = size(eigenvalues, 2);
    threshold = eigenvalues_total * 0.95;
    [~, I] = sort(eigenvalues, 'descend');
    total = 0;
    index = 1;
    for i=1:eigenvalues_size
        total = total + eigenvalues(I(i));
        if total >= threshold
            index = i;
            break;
        end
    end
    pcs = V(:, I(1:index));
    
    for i = 1:11
        max_val = max(pcs(:, i));
        min_val = min(pcs(:, i));
        diff = max_val - min_val;
        img = uint8((pcs(:, i) - min_val) * 255 / diff);
        subplot(4, 4, i), imshow(reshape(img, 32, 32));
        %subplot(4, 4, i), imshow(reshape(uint8(pcs(:, i) + mean_value), 32, 32));
    end
end