function [Result24, Result48] = Stage1_Forecasting_V3(Mdl, Goodfactors, targetlist, plant, loc)

w1 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
w2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24_trend.csv']);

%% 
Result24 = [];
%%
parfor i = 1:length(targetlist)
    disp(i)
    WeatherTest24 = [w1 w2(:,6:end)];
    Weather = [WeatherTest24(:,1:5) WeatherTest24(:,getfield(Goodfactors, targetlist{:,i}))];
    mdl = Mdl{i}
    r= predict(mdl, Weather);
    Result24 = [Result24 r];
end

Result24 = array2table(Result24);
Result24.Properties.VariableNames = targetlist;

%%
w1 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48.csv']);
w2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48_trend.csv']);

Result48 = [];
%%
parfor i = 1:length(targetlist)
    disp(i)
    WeatherTest48 = [w1 w2(:,6:end)];
    Weather = [WeatherTest48(:,1:5) WeatherTest48(:,getfield(Goodfactors, targetlist{:,i}))];
    mdl = Mdl{i}
    r= predict(mdl, Weather);
    Result48 = [Result48 r];
end

Result48 = array2table(Result48);
Result48.Properties.VariableNames = targetlist;

