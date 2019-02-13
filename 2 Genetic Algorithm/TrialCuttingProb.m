clear; clc;

tic;

P = 10;
L = 10;

A = P*L;

a = 2;
b = 3;

rec1 = a*a; %4
rec2 = a*b; %6
 
N = 5;
gen = 5;

%GENERATE POPULATION
while true
    for i=1:N
        temp = 0;
        for j=1:gen
            arr1(i,j)=round(rand(1));
        end
        for j=1:gen
            temp = temp + arr1(i,j)*2^(gen-j);
        end
        arr1(i,gen+1) = temp;
    end

    for i=1:N
        temp = 0;
        for j=1:gen
            arr2(i,j)=round(rand(1));
        end
        for j = 1:gen
            temp = temp + arr2(i,j)*2^(gen-j);
        end
        arr2(i,gen+1) = temp;
    end
    
    if (A-arr1(:,gen+1)*rec1-arr2(:,gen+1)*rec2>=0)
        break
    end
end

A1 = arr1(:,1:gen);
A2 = arr2(:,1:gen);

kumpulanNilaiFitness = zeros([N 100]);
nilaiMax = zeros([1 100]);
setHasilGA_N = int16([]);
setHasilGA_M = int16([]);

for counter = 1:100
    [hasilGAn, hasilGAm] = GenAlgCSP(A1,A2,rec1,rec2,0.5,0.2)
    setHasilGA_N{counter} = hasilGAn;
    setHasilGA_M{counter} = hasilGAm;
    kumpulanNilaiFitness(:,counter) = hasilGAn(:,gen+2);
    A1 = hasilGAn(:,1:gen);
    A2 = hasilGAm(:,1:gen);
end

%kumpulanNilaiFitness
outputf = max(kumpulanNilaiFitness(kumpulanNilaiFitness<=A));
arrIndexCol = ceil(find(kumpulanNilaiFitness==outputf)/N);
indexCol = arrIndexCol(1);
arrIndexRow = find(kumpulanNilaiFitness(:,indexCol)==outputf);
indexRow = arrIndexRow(1);

set_of_N = setHasilGA_N{indexCol};
set_of_M = setHasilGA_M{indexCol};
 
gen_N = set_of_N(indexRow,gen+1)
gen_M = set_of_M(indexRow,gen+1)

toc