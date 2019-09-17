function [fitness] = fitProb29fiveVar(x1,x2,x3,x4,x5)
    ukuran = size(x1);
    x = [x1 x2 x3 x4 x5]; fitness = zeros([ukuran(1) 1]);
    for i = 1:4
        fitness = fitness + x(:,i+1).*sin(sqrt(abs(x(:,i+1)+x(:,i)./2+47))) ...
                          + x(:,i).*sin(sqrt(abs(x(:,i)-(x(:,i+1)+47))));
    end
end