function [Result24, Result48] = Stage1_Forecasting(Mdl, weatherlist1, weatherlist2, targetlist, plant, loc, add)
%%
if add == 0
WeatherTest24 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
Weather = [WeatherTest24(:,1:5) WeatherTest24(:,weatherlist1)];
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
WeatherTest48 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48.csv']);
Weather = [WeatherTest48(:,1:5) WeatherTest48(:,weatherlist1)];
Result48 = [];
parfor i = 1:length(targetlist)
    disp(i)
    mdl = Mdl{i}
    r= predict(mdl, Weather);
    Result48 = [Result48 r];
end

Result48 = array2table(Result48);
Result48.Properties.VariableNames = targetlist;

else
WeatherTest24 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
WeatherTest24_2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24_2.csv']);

Weather = [WeatherTest24(:,1:5) WeatherTest24(:,weatherlist1) WeatherTest24_2(:,weatherlist2)];
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
WeatherTest48 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48.csv']);
WeatherTest48_2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W48_2.csv']);

Weather = [WeatherTest48(:,1:5) WeatherTest48(:,weatherlist1) WeatherTest48_2(:,weatherlist2)];
Result48 = [];
parfor i = 1:length(targetlist)
    disp(i)
    mdl = Mdl{i}
    r= predict(mdl, Weather);
    Result48 = [Result48 r];
end

Result48 = array2table(Result48);
Result48.Properties.VariableNames = targetlist;

end
    
