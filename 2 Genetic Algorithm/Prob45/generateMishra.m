function [Xbin] = generateMishra(pop,gen)
    x = [];
    for i = 1:pop
        temp = 0;
        for k = 1:gen
            x(i,k) = round(rand(1));
        end  
    end
    %Mencari nilai real dari nilai binary
    Xreal = [];
    while true
        for j = 1:pop
            temp = 0;
            for k = 1:gen
                temp = temp + x(j,k)*2^(gen-k);
            end
            Xreal(j) = (temp/(2^gen-1))*20-10;
        end
        %Mengecek apakah generate population berada pada -10 s/d 10
        if (sum(-10 <= Xreal(:)) + sum(Xreal(:) <= 10) == 2*pop)
            break;
        end
    end 
    Xbin = x;
end