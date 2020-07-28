clear all
close all
clc

P1_L1 = readtable('Result_P1_L1.csv');
P1_L2 = readtable('Result_P1_L2.csv');
P1_L3 = readtable('Result_P1_L3.csv');
P2_L1 = readtable('Result_P2_L1.csv');
P2_L2 = readtable('Result_P2_L2.csv');
P2_L3 = readtable('Result_P2_L3.csv');

P1_L1_P = zeros(size(P1_L1,1),1);
P1_L1_L = zeros(size(P1_L1,1),1);

P1_L2_P = zeros(size(P1_L2,1),1);
P1_L2_L = zeros(size(P1_L2,1),1);

P1_L3_P = zeros(size(P1_L3,1),1);
P1_L3_L = zeros(size(P1_L3,1),1);

P2_L1_P = zeros(size(P2_L1,1),1);
P2_L1_L = zeros(size(P2_L1,1),1);

P2_L2_P = zeros(size(P2_L2,1),1);
P2_L2_L = zeros(size(P2_L2,1),1);

P2_L3_P = zeros(size(P2_L3,1),1);
P2_L3_L = zeros(size(P2_L3,1),1);

%% Make Plant!
for i = 1:size(P1_L1,1)
    P1_L1_P(i) = 1;
    P1_L1_L(i) = 1;
end

for i = 1:size(P1_L2,1)
    P1_L2_P(i) = 1;
    P1_L2_L(i) = 2;
end

for i = 1:size(P1_L3,1)
    P1_L3_P(i) = 1;
    P1_L3_L(i) = 3;
end

for i = 1:size(P2_L1,1)
    P2_L1_P(i) = 2;
    P2_L1_L(i) = 1;
end

for i = 1:size(P2_L2,1)
    P2_L2_P(i) = 2;
    P2_L2_L(i) = 2;
end

for i = 1:size(P2_L3,1)
    P2_L3_P(i) = 2;
    P2_L3_L(i) = 3;
end

P1L1 = table2array(P1_L1);
P1L2 = table2array(P1_L2);
P1L3 = table2array(P1_L3);
P2L1 = table2array(P2_L1);
P2L2 = table2array(P2_L2);
P2L3 = table2array(P2_L3);
P1L1 = [P1_L1_P, P1_L1_L, P1L1];
P1L2 = [P1_L2_P, P1_L2_L, P1L2];
P1L3 = [P1_L3_P, P1_L3_L, P1L3];
P2L1 = [P2_L1_P, P2_L1_L, P2L1];
P2L2 = [P2_L2_P, P2_L2_L, P2L2];
P2L3 = [P2_L3_P, P2_L3_L, P2L3];

P = [P1L1; P1L2; P1L3; P2L1; P2L2; P2L3];
R_F = readtable('result_form.csv');
Time = R_F.MEA_DDHR;
date = datevec(Time);
date(:,6) = [];

R = [R_F.PLANT, R_F.LOC, date];
R1 = zeros(size(R,1),4);
R = [R, R1];

count = 0;
for i = 1 : size(P,1)
    for j = 1 : size(R,1)
        if(P(i,1) == R(j,1))
            if(P(i,2) == R(j,2))
                if(P(i,3) == R(j,3))
                    if(P(i,4) == R(j,4))
                        if(P(i,5) == R(j,5))
                            if(P(i,6) == R(j,6))
                                if(P(i,7) == R(j,7))
                                    R(j,8) = P(i,8);
                                    R(j,9) = P(i,9);
                                    R(j,10) = P(i,10);
                                    R(j,11) = P(i,11);
                                    count = count + 1;
                                    break;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

R_F.X24H_COND_LOC = R(:,8);
R_F.X24H_COND_LOC_PROB = R(:,9);
R_F.X48H_COND_LOC = R(:,10);
R_F.X48H_COND_LOC_PROB = R(:,11);

writetable(R_F,'easy.csv');






