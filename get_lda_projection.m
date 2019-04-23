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