function [eigen_values, eigen_vectors] = get_eigen(images)
    mean_value = mean(images, 2);
    S = (images - mean_value) * (images - mean_value)' / (20 * 119);
    [V, D] = eig(S);
    all_eigen_values = sum(D, 1);
    [~, I] = sort(all_eigen_values, 'descend');
    eigen_values = all_eigen_values(1, I);
    eigen_vectors = V(:, I);
end