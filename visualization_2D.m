function visualization_2D(images, pcs)
    result = images' * pcs(:, 1:2);
    figure();
    scatter(result(1:119*20, 1), result(1:119*20, 2), 'r*');
    hold on;
    scatter(result(119*20+1:119*20+7, 1), result(119*20+1:119*20+7, 2), 'b+');
    legend('PIE data', 'Self photo');
    hold off;
end