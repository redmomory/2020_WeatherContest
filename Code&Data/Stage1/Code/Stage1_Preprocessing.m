function [Observed, Weather, Condition] = Stage1_Preprocessing(plant, loc, weatherlist1, weatherlist2, add)
%%
load Plant1Train
load Plant2Train
load PlantTest
load Weather1Train
load Weather2Train
load Weather1Train_boryeong
load Weather2Train_boryeong

if add ==0 
if plant == 1
    Train = Plant1Train;
    Weather = Weather1Train;
else 
    Train = Plant2Train;
    Weather = Weather2Train;
end

t = ['plant',num2str(plant),'_train_tem_in_loc',num2str(loc)];
h = ['plant',num2str(plant),'_train_hum_in_loc',num2str(loc)];
c = ['plant',num2str(plant),'_train_tem_coil_loc',num2str(loc)];
to = ['plant',num2str(plant),'_train_tem_out_loc',num2str(1)];
ho = ['plant',num2str(plant),'_train_hum_out_loc',num2str(1)];


cond = ['plant',num2str(plant),'_train_cond_loc',num2str(loc)];
time = Train(:,1:5);

TempIn = Train.(t);
HumIn =  Train.(h);
TempCoil = Train.(c);
TempOut = Train.(to);
HumOut =  Train.(ho);


Cond = Train.(cond);
Observed = [TempIn HumIn TempCoil TempOut HumOut];
Observed = [time array2table(Observed, 'VariableNames',{'TempIn','HumIn','TempCoil','TempFac','HumFac'})];
Weather = [Weather(:,1:5) Weather(:,weatherlist1)];
Condition = array2table(Cond,'VariableNames',{'Condition'});

else 
    
    if plant == 1
    Train = Plant1Train;
    Weather1 = Weather1Train;
    Weather2 = Weather1Train_boryeong;
    else 
    Train = Plant2TrainBig;
    Weather1 = Weather2Train;
    Weather2 = Weather2Train_boryeong;
    end

t = ['plant',num2str(plant),'_train_tem_in_loc',num2str(loc)];
h = ['plant',num2str(plant),'_train_hum_in_loc',num2str(loc)];
c = ['plant',num2str(plant),'_train_tem_coil_loc',num2str(loc)];
to = ['plant',num2str(plant),'_train_tem_out_loc',num2str(1)];
ho = ['plant',num2str(plant),'_train_hum_out_loc',num2str(1)];


cond = ['plant',num2str(plant),'_train_cond_loc',num2str(loc)];
time = Train(:,1:5);

TempIn = Train.(t);
HumIn =  Train.(h);
TempCoil = Train.(c);
TempOut = Train.(to);
HumOut =  Train.(ho);


Cond = Train.(cond);
Observed = [TempIn HumIn TempCoil TempOut HumOut];
Observed = [time array2table(Observed, 'VariableNames',{'TempIn','HumIn','TempCoil','TempFac','HumFac'})];
Weather = [Weather(:,1:5) Weather1(:,weatherlist1) Weather2(:,weatherlist2)];
Condition = array2table(Cond,'VariableNames',{'Condition'});
end
% idx = Weather.LocalPressure == 0;
% Weather(idx,:) = [];
% Observed(idx,:) = [];
% Condition(idx,:) = [];
