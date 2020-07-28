clc
clear all

%% Section 1
% 'TempOut','HumOut','Precipitation', 'WindDirection', 'WindSpeed','LocalPressure','Radiation','Sunlight'
weatherlist1 = {'TempOut','HumOut','Precipitation', 'WindDirection', 'WindSpeed','LocalPressure','Radiation','Sunlight'};
weatherlist2 = {'TempOut2','Precipitation2','WindDirection2','WindSpeed2','LocalPressure2','HumOut2'};
targetlist = {'TempIn','HumIn', 'TempCoil','TempFac','HumFac'};
add = 0;

%% Section 2
TotalSolution = nan(3539,2);
TotalScore = nan(3539,2);
day = '0617';
Stage1Mdls = [];
Stage1Results = [];
CrossValTotalRMSE = [];
load WeatherTrain
load Plant1Train
load Plant2Train

%% Section 3
[Thresholds, CrossValRMSE] = Thresholds(weatherlist1, weatherlist2, targetlist, plant,loc,add);


%% Section 4
for plant = 1:2
    for loc = 1:3
        %% Subsection 4-1
        if plant == 1
        [Weather_trend] = WeatherTrend_V2(WeatherTrain, Plant1Train, [1:15]);
        [Weather_trend] = array2table(Weather_trend);        
       
        else 
        [Weather_trend] = WeatherTrend_V2(WeatherTrain, Plant2Train, [1:15]);
        [Weather_trend] = array2table(Weather_trend); 
        end
        

        %% Subsection 4-2
        [Observed, Weather,Condition] = Stage1_Preprocessing(plant, loc, weatherlist1, weatherlist2, add);
       
        %% Subsection 4-3       
        [TotalWeather] = [Weather Weather_trend];
        [TotalWeatherList] = TotalWeather.Properties.VariableNames;
        [Correlation] = Correlations_Norm(Observed, TotalWeather, TotalWeatherList, targetlist);
          
        %% Subsection 4-4  
        Thresholds = [0.46 0.11 0.14 0.26 0.3];
        [Goodfactors] = GoodFactors(Correlation,Thresholds);

        %% Subsection 4-5  
        [Mdl1] = Stage1_Training(TotalWeather, Observed, targetlist,Goodfactors,3000);
        Stage1Mdls = setfield(Stage1Mdls,['Mdl1',day],['Plant',num2str(plant),'Loc',num2str(loc)],Mdl1);

        %% Subsection 4-6  
        [Result24, Result48] = Stage1_Forecasting_V3(Mdl, Goodfactors, targetlist, plant, loc);
        Stage1Results = setfield(Stage1Results, ['Plant',num2str(plant),'Loc',num2str(loc)],'H24',Result24); 
        Stage1Results = setfield(Stage1Results, ['Plant',num2str(plant),'Loc',num2str(loc)],'H48',Result48); 
        CrossValTotalRMSE = setfield(CrossValTotalRMSE, ['Plant',num2str(plant),'Loc',num2str(loc), CrossValRMSE]);

          
    end
    
end


%% Section 5
for plant = 1:1
    for loc = 1:3
        %%
        T24 = getfield(Stage1Results, ['Mdl1',day],['Plant',num2str(plant),'Loc',num2str(loc)],'H24'); 
        D1 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
        T24 = [D1(:,1:5) T24];
        T24.Properties.VariableNames = {'Year','Month','Day','Hour','Minute','temp_in','hum_in','temp_coil','temp_out','hum_out'};
        name = ['Test_P',num2str(plant),'_L',num2str(loc),'_24.csv'];
        writetable(T24, name)
        %%
        T48 = getfield(Stage1Results, ['Mdl1',day],['Plant',num2str(plant),'Loc',num2str(loc)],'H48'); 
        D2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
        T48 = [D2(:,1:5) T48];
        T48.Properties.VariableNames = {'Year','Month','Day','Hour','Minute','temp_in','hum_in','temp_coil','temp_out','hum_out'};
        name = ['Test_P',num2str(plant),'_L',num2str(loc),'_48.csv'];
        writetable(T48, name)
    end
end

