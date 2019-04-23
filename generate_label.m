function [train_label, test_label] = generate_label()
    train_label = zeros(1, 20*119+7);
    test_label = zeros(1, 20*51+3);
    for i=1:20
        train_label((i-1)*119+1:i*119) = i*ones(1, 119);
        test_label((i-1)*51+1:i*51) = i*ones(1, 51);
    end
    train_label(20*119+1:20*119+7) = 21*ones(1, 7);
    test_label(20*51+1:20*51+3) = 21*ones(1, 3);
end