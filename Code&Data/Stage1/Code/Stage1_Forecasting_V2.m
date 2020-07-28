function [Result24, Result48] = Stage1_Forecasting_V2(Mdl, TotalWeatherList, targetlist, plant, loc)

w1 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
w2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24_2.csv']);
w3 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24_15.csv']);
w4 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24_30.csv']);
w5 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24_45.csv']);

%% 
WeatherTest24 = [w1 w2(:,6:end) w3(:,6:end) w4(:,6:end) w5(:,6:end)];
Weather = [WeatherTest24(:,1:5) WeatherTest24(:,TotalWeatherList)];
Result24 = [];
%%
parfor i = 1:length(targetlist)
    disp(i)
    mdl = Mdl{i}
    r= predict(mdl, Weather);
    Result24 = [Result24 r];
end

Result24 = array2table(Result24);
Result24.Properties.VariableNames = targetlist;

%%
w1 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48.csv']);
w2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48_2.csv']);
w3 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48_15.csv']);
w4 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48_30.csv']);
w5 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48_45.csv']);

WeatherTest48 = [w1 w2(:,6:end) w3(:,6:end) w4(:,6:end) w5(:,6:end)];
Weather = [WeatherTest48(:,1:5) WeatherTest48(:,TotalWeatherList)];
Result48 = [];
%%
parfor i = 1:length(targetlist)
    disp(i)
    mdl = Mdl{i}
    r= predict(mdl, Weather);
    Result48 = [Result48 r];
end

Result48 = array2table(Result48);
Result48.Properties.VariableNames = targetlist;

