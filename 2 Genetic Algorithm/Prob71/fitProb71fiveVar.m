function [fitness] = fitProb71fiveVar(x1,x2,x3,x4,x5)
    ukuran = size(x1);
    x = [x1 x2 x3 x4 x5]; fitness = zeros([ukuran(1) 1]);
    for i = 1:5
        fitness = fitness + x(:,i).^4;
    end
end