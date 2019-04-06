function pcs = pca()
    images = load_images();
    [eigen_values, eigen_vectors] = get_eigen(images);
    draw_eigenface(eigen_values, eigen_vectors);
    pcs = get_pcs(eigen_values, eigen_vectors);
end