function [Xbin] = generateEggHolderX(pop,gen)
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
            Xreal(j) = (temp/(2^gen-1))*1024-512;
        end
        %Mengecek apakah generate population berada pada -512 s/d 512
        if (sum(-512 <= Xreal(:)) + sum(Xreal(:) <= 512) == 2*pop)
            break;
        end
    end 
    Xbin = x;
end