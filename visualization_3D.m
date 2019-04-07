function visualization_3D(images, pcs)
    result = images' * pcs(:, 1:3);
    figure();
    scatter3(result(1:119*20, 1), result(1:119*20, 2), result(1:119*20, 3), 'r*');
    hold on;
    scatter3(result(119*20+1:119*20+7, 1), result(119*20+1:119*20+7, 2), result(119*20+1:119*20+7, 3), 'b+');
    legend('PIE data', 'Self photo');
    hold off;
end