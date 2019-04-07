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