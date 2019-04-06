function draw_eigenface(eigen_values, eigen_vectors)
    eigen_values_count = size(eigen_values, 2);
    eigen_count = 0;
    for i=1:eigen_values_count
        if eigen_values(i) < 1e-1
            eigen_count = i - 1;
            break;
        end
    end
    eigen_faces = eigen_vectors(:, 1:eigen_count);
    rows = ceil(eigen_count / 4);
    figure();
    for i = 1:eigen_count
        subplot(4, rows, i), imshow(reshape(eigen_faces(:, i), 32, 32), []);
    end
end