clear all
close all
clc

P1 = readtable('easy.csv');
P2 = readtable('lr.csv');

X24 = zeros(size(P1,1),1);
P24 = zeros(size(P1,1),1);
X48 = zeros(size(P1,1),1);
P48 = zeros(size(P1,1),1);

X24_1 = P1.X24H_COND_LOC;
X24_2 = P2.X24H_COND_LOC;
P24_1 = P1.X24H_COND_LOC_PROB;
P24_2 = P2.X24H_COND_LOC_PROB;

X48_1 = P1.X48H_COND_LOC;
X48_2 = P2.X48H_COND_LOC;
P48_1 = P1.X48H_COND_LOC_PROB;
P48_2 = P2.X48H_COND_LOC_PROB;

count11 = 0;
count12 = 0;
for i = 1: size(P1,1)
    if(X24_1(i) == 1 | X24_2(i) == 1)
        P24(i) = 1;
        X24(i) = 1;
    else
        P24(i) = 0;
        X24(i) = 0;
    end
end

count21 = 0;
count22 = 0;
for i = 1: size(P1,1)
    if(X48_1(i) == 1 | X48_2(i) == 1)
        P48(i) = 1;
        X48(i) = 1;
    else
        P48(i) = 0;
        X48(i) = 0;
    end
end

P2.X24H_COND_LOC = X24;
P2.X48H_COND_LOC = X48;

P2.X24H_COND_LOC_PROB = P24;
P2.X48H_COND_LOC_PROB = P48;
writetable(P2,'203641.csv');

