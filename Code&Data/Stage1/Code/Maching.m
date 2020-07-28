function WeatherTest = Maching(WeatherTest, PlantTest)

Datenumweather = datenum(table2array(WeatherTest(:,1:3)));
Datenumplant = datenum(table2array(PlantTest(:,1:3)));
%%
WeatherTest = table2array(WeatherTest);
PlantTest = table2array(PlantTest);
parfor i = 1:length(Datenumplant)
    try
    disp(i)
    idx1 = Datenumweather == Datenumplant(i);
    smallweather = WeatherTest(idx1,:);
    for j = 1:length(smallweather(:,4))
        idx2 = smallweather(:,4) == PlantTest(i,4);
        smallerweather = smallweather(idx2,:);
        for k = 1:length(smallerweather(:,5))
            idx3 = smallerweather(:,5) == PlantTest(i,5);
            smallestweather = smallerweather(idx3,:);
            re(i,:) = smallestweather;
        end
    end
    
    catch Me
            disp(i)
    end
   
end
%%
WeatherTest = re;
WeatherTest = array2table(WeatherTest);
% newname = {'Year','Month','Day','Hour','Minute','TempOut','Precipitation','WindDirection','WindSpeed','LocalPressure','SurfacePressure','HumOut','Radiation','Sunlight'};
% WeatherTest.Properties.VariableNames = newname;