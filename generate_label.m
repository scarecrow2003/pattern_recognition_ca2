function [train_label, test_label] = generate_label()
    train_label = [];
    test_label = [];
    for i=1:20
        train_label = [train_label i*ones(1, 119)];
        test_label = [test_label i*ones(1, 51)];
    end
    train_label = [train_label 21*ones(1, 7)];
    test_label = [test_label 21*ones(1, 3)];
end