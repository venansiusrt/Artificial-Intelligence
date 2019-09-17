function [fitness] = fitProb29twoVar(x1,x2)
    fitness = (x2+47).*sin(sqrt(abs(x2+x1/2+47))) + x1.*sin(sqrt(abs(x1-x2-47)));
end