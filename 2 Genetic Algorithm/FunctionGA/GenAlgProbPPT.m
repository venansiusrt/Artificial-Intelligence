function iterasi = GenAlgProbPPT (arr, mutRate, crossRate)

%Mendapatkan banyak 
ukuranArr = size(arr);

%Mendapatkan banyak individu
N = ukuranArr(1);

%Mendapatkan banyak gen
gen = ukuranArr(2);

%Mendapatkan nilai numerik dan fungsi FITNESS 
for i=1:N
    temp = 0;
    for j=1:gen
        temp = temp + arr(i,j)*2^(gen-j);
    end
    arr(i,gen+1) = temp/(2^gen);
end

%Konstruksi Nilai Fitness
arr(:,gen+2) = 1+exp(-arr(:,gen+1))*sin(4*arr(gen+1));

%SELECTION
%memberi persentase tiap fitness
totalfitness = sum(arr(:,gen+2));
arr(:,gen+3) = arr(:,gen+2)/totalfitness;

%membuat partisi roulette
temparr = arr(:,gen+3);
q = zeros([1 gen+1]);
q(1) = 0;
for i = 1:N
    temp = 0;
    for j = 1:i
        temp = temp + temparr(j);
    end
    q(i+1) = temp;
end

%menentukan individu terpilih
klok = 1; R = rand(1); ind = 1;
while klok<=N
    if(q(ind)<=R && R<=q(ind+1))
        chosen(klok) = i;
        R = rand(1); 
        klok = klok+1;
        ind = 0;
    end
    ind = ind+1;
end
%array hasil seleksi
arrsel = arr(chosen,1:gen);

%CROSSOVER
%mendapatkan 2 induk berbeda yang akan dikawin silangkan
pCross = crossRate;
for i = 1:N
    r = rand(1);
    if r<pCross
        while true
            parent1 = round((N-1)*rand(1)+1);
            parent2 = round((N-1)*rand(1)+1);
            if (parent1 ~= parent2)
                tempparent = [arrsel(parent1,:); arrsel(parent2,:)];
                break; 
            end
        end
    
        %mendapatkan indeks yang akan disilangkan
        posCross = round((gen-1)*rand(1)+1);
        for k = posCross:gen
            tempparent([2*k-1 2*k]) = tempparent([2*k 2*k-1]);
        end

        arrsel(parent1,:) = tempparent(1,:);
        arrsel(parent2,:) = tempparent(2,:);
    end
end

%mutasi
%peluang terjadinya mutasi
pMut = mutRate;
for i = 1:N
    posMutN = round((N-1)*rand(1)+1);
    posMutGen = round((gen-1)*rand(1)+1);
    pMutRand = rand(1);
    if pMutRand < pMut
        arrsel(posMutN,posMutGen) = 1-arrsel(posMutN,posMutGen);
    end
end

%Mencetak hasil fitness
for i=1:N
    temp = 0;
    for j=1:gen
        temp = temp + arrsel(i,j)*2^(gen-j);
    end
    arrsel(i,gen+1) = temp/(2^gen);
    arrsel(i,gen+2) = 1+exp(-arrsel(i,j+1))*sin(4*arrsel(i,j+1));
end

iterasi = arrsel;

end