clear; clc;

%bangkitkan N kromosom, panjang 21, minimum -3 dan max 12
format short;

%banyak individu = 8
N = 5;

%banyak gen = 8 seri
gen = 5;

%GENERATE POPULATION
for i=1:N
    for j=1:gen
        arr(i,j)=round(rand(1));
    end
end

%Mendapatkan nilai numerik dan fungsi FITNESS 
for i=1:N
    temp = 0;
    for j=1:gen
        temp = temp + arr(i,j)*2^(gen-j);
    end
    arr(i,gen+1) = temp/(2^gen-1);
end

sol = arr(:,1:gen);

%Konstruksi Nilai Fitness
fitness = 1+exp(-arr(:,gen+1)).*sin(4.*arr(:,gen+1));
calonfitness = [];
% kumpulanNilaiFitness = zeros([N 1000]);
% nilaiMax = zeros([1 1000]);
% setHasilGA = int16([]);

for counter = 1:100
    hasilGA = GenAlgProbPPT(arr(:,1:gen),0.1,0.2);
    for i=1:N
        temp = 0;
        for j=1:gen
            temp = temp + hasilGA(i,j)*2^(gen-j);
        end
        hasilGA(i,gen+1) = temp/(2^gen-1);
    end
    calonfitness = 1+exp(-hasilGA(:,gen+1)).*sin(4.*hasilGA(:,gen+1));
    for j = 1:N
        if fitness(j) < calonfitness(j)
            fitness(j) = calonfitness(j);
            sol(j,:) = hasilGA(j,1:5);
        end
    end
    arr = sol;
end
for i=1:N
    temp = 0;
    for j=1:gen
        temp = temp + arr(i,j)*2^(gen-j);
    end
    arr(i,gen+1) = temp/(2^gen-1);
end
arr
fitness
% for counter = 1:1000
%     hasilGA = GenAlgProbPPT(arr,0.3,0.5)
%     kumpulanNilaiFitness(:,counter) = hasilGA(:,gen+2);
%     nilaiMax(counter) = max(kumpulanNilaiFitness(:,counter));
%     setHasilGA{counter} = hasilGA; 
%     arr = hasilGA(:,1:gen);
% end
% 
% %Mencari nilai x yang menyebabkan y maksimum
% outputf = max(nilaiMax)
% arrIndexCol = find(nilaiMax==outputf);
% indexCol = arrIndexCol(1);
% arrIndexRow = find(kumpulanNilaiFitness(:,indexCol)==outputf);
% indexRow = arrIndexRow(1);
% 
% setx = setHasilGA{indexCol};
% x = setx(indexRow,gen+1)