function Goodfactors = GoodFactors(Correlation, threshold)
%%
idx = table2array(Correlation) > threshold';

ObservedList = Correlation.Properties.RowNames;
WeatherList =  Correlation.Properties.VariableNames;

Goodfactors = [];
for i = 1:length(idx(:,1))
    Goodfactors = setfield(Goodfactors,ObservedList{i,1},WeatherList(idx(i,:)));
end